import React, { useState, useEffect } from 'react';
import {
  View,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  ActivityIndicator,
  Alert,
  RefreshControl,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { StatusBar } from 'expo-status-bar';
import { Ionicons } from '@expo/vector-icons';
import { Typography, Card } from '../../components/ui';
import { theme } from '../../theme';
import { useAuth } from '../../contexts/AuthContext';
import { supabase } from '../../lib/supabase';

interface BookingHistoryScreenProps {
  navigation: any;
}

interface DatabaseBooking {
  id: string;
  status: string;
  scheduled_date: string;
  scheduled_time: string;
  service_name?: string;
  variant_name?: string;
  hero_id?: string;
  total_amount?: number;
  created_at: string;
  services?: { id: string; name: string };
  service_variants?: { id: string; name: string };
  heros?: { id: string; name: string };
}

interface Booking {
  id: string;
  status: string;
  scheduled_date: string;
  scheduled_time: string;
  service_name: string;
  variant_name: string;
  hero_name: string | null;
  total_amount: number;
  created_at: string;
}

export const BookingHistoryScreen: React.FC<BookingHistoryScreenProps> = ({ navigation }) => {
  const { user } = useAuth();
  const [bookings, setBookings] = useState<Booking[]>([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);

  useEffect(() => {
    fetchBookings();
  }, []);

  const fetchBookings = async () => {
    try {
      setLoading(true);
      
      if (!user?.id) {
        Alert.alert('Error', 'You need to be logged in to view your bookings');
        return;
      }

      // Fetch bookings with proper foreign key relationships
      console.log('Fetching booking history for user:', user.id);
      
      const { data, error } = await supabase
        .from('bookings')
        .select(`
          id,
          status,
          scheduled_at,
          duration_min,
          service_name,
          variant_name,
          price_cents,
          created_at,
          hero_id,
          services (id, title),
          service_variants (id, name),
          heros:fk_bookings_hero (id, name)
        `)
        .eq('customer_id', user.id)
        .order('created_at', { ascending: false });
      
      console.log('Booking history query completed');
      if (data) {
        console.log('Bookings found:', data.length);
      }
        
      if (error) {
        console.error('Error fetching bookings:', error);
        Alert.alert('Error', 'Failed to load your bookings');
        return;
      }
      
      // Transform the data with proper relationships
      const bookingsWithDetails = data?.map((booking: any) => {
        // Use existing service_name/variant_name if available, otherwise try to get from relations
        const serviceName = booking.service_name || 
          (booking.services && typeof booking.services === 'object' && 'title' in booking.services ? 
            booking.services.title : 'Unknown Service');
            
        const variantName = booking.variant_name || 
          (booking.service_variants && typeof booking.service_variants === 'object' && 'name' in booking.service_variants ? 
            booking.service_variants.name : 'Unknown Variant');
            
        const heroName = booking.heros && typeof booking.heros === 'object' && 'name' in booking.heros ? 
          booking.heros.name : null;
          
        return {
          ...booking,
          service_name: serviceName,
          variant_name: variantName,
          hero_name: heroName
        };
      }) || [];

      // Transform the data for display
      const transformedBookings: Booking[] = bookingsWithDetails.map((booking: any) => {
        // Convert price_cents to dollars
        const totalAmount = booking.price_cents ? booking.price_cents / 100 : 0;
        
        return {
          id: booking.id,
          status: booking.status,
          scheduled_date: booking.scheduled_at,
          scheduled_time: booking.scheduled_at,
          service_name: booking.service_name,
          variant_name: booking.variant_name,
          hero_name: booking.hero_name,
          total_amount: totalAmount,
          created_at: booking.created_at,
        };
      });

      setBookings(transformedBookings);
    } catch (error) {
      console.error('Error in fetchBookings:', error);
      Alert.alert('Error', 'Something went wrong while loading your bookings');
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  };

  const onRefresh = () => {
    setRefreshing(true);
    fetchBookings();
  };

  const handleBookingPress = (booking: Booking) => {
    // Navigate to booking details screen
    navigation.navigate('BookingStatus', { bookingId: booking.id });
  };

  const getStatusColor = (status: string) => {
    switch (status.toLowerCase()) {
      case 'completed':
        return theme.colors.status.success;
      case 'cancelled':
        return theme.colors.status.error;
      case 'requested':
      case 'pending':
        return theme.colors.status.warning;
      case 'confirmed':
      case 'in_progress':
        return theme.colors.primary.main;
      default:
        return theme.colors.text.secondary;
    }
  };

  const formatDate = (dateString: string | null) => {
    if (!dateString) return 'Date unavailable';
    
    try {
      const date = new Date(dateString);
      return date.toLocaleDateString('en-US', {
        year: 'numeric',
        month: 'short',
        day: 'numeric',
      });
    } catch (error) {
      console.error('Date formatting error:', error);
      return 'Date unavailable';
    }
  };

  const renderBookingCard = (booking: Booking) => (
    <TouchableOpacity
      key={booking.id}
      style={styles.bookingCard}
      onPress={() => handleBookingPress(booking)}
      activeOpacity={0.7}
    >
      <Card variant="default" padding="md" style={styles.cardContainer}>
        <View style={styles.cardHeader}>
          <Typography variant="h6" weight="semibold" numberOfLines={1} style={styles.serviceName}>
            {booking.service_name}
          </Typography>
          <View style={[styles.statusBadge, { backgroundColor: getStatusColor(booking.status) }]}>
            <Typography variant="caption" color="inverse" weight="medium">
              {booking.status.toUpperCase()}
            </Typography>
          </View>
        </View>

        <View style={styles.cardContent}>
          <View style={styles.infoRow}>
            <Ionicons name="calendar-outline" size={16} color={theme.colors.text.secondary} />
            <Typography variant="body2" style={styles.infoText}>
              {formatDate(booking.scheduled_date)} {booking.scheduled_time ? `at ${booking.scheduled_time}` : ''}
            </Typography>
          </View>

          <View style={styles.infoRow}>
            <Ionicons name="construct-outline" size={16} color={theme.colors.text.secondary} />
            <Typography variant="body2" style={styles.infoText}>
              {booking.variant_name}
            </Typography>
          </View>

          {booking.hero_name && (
            <View style={styles.infoRow}>
              <Ionicons name="person-outline" size={16} color={theme.colors.text.secondary} />
              <Typography variant="body2" style={styles.infoText}>
                {booking.hero_name}
              </Typography>
            </View>
          )}

          <View style={styles.priceRow}>
            <Typography variant="body1" weight="semibold">
              ${booking.total_amount ? booking.total_amount.toFixed(2) : '0.00'}
            </Typography>
          </View>
        </View>

        <View style={styles.cardFooter}>
          <Typography variant="caption" color="secondary">
            Booked on {formatDate(booking.created_at)}
          </Typography>
          <Ionicons name="chevron-forward" size={16} color={theme.colors.text.secondary} />
        </View>
      </Card>
    </TouchableOpacity>
  );

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar style="dark" backgroundColor={theme.colors.background.primary} />
      
      {/* Header */}
      <View style={styles.header}>
        <TouchableOpacity
          style={styles.backButton}
          onPress={() => navigation.goBack()}
          hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}
        >
          <Ionicons name="arrow-back" size={24} color={theme.colors.text.primary} />
        </TouchableOpacity>
        <Typography variant="h5" weight="semibold">
          Booking History
        </Typography>
        <View style={{ width: 24 }} />
      </View>
      
      {loading && !refreshing ? (
        <View style={styles.loadingContainer}>
          <ActivityIndicator size="large" color={theme.colors.primary.main} />
          <Typography variant="body1" style={styles.loadingText}>
            Loading your bookings...
          </Typography>
        </View>
      ) : (
        <ScrollView
          style={styles.scrollView}
          contentContainerStyle={styles.scrollContent}
          showsVerticalScrollIndicator={false}
          refreshControl={
            <RefreshControl refreshing={refreshing} onRefresh={onRefresh} />
          }
        >
          {bookings.length === 0 ? (
            <View style={styles.emptyContainer}>
              <Ionicons name="calendar-outline" size={64} color={theme.colors.text.secondary} />
              <Typography variant="h6" weight="semibold" style={styles.emptyTitle}>
                No Bookings Yet
              </Typography>
              <Typography variant="body2" color="secondary" align="center" style={styles.emptyText}>
                You haven't made any bookings yet. When you book a service, it will appear here.
              </Typography>
              <TouchableOpacity
                style={styles.browseButton}
                onPress={() => navigation.navigate('Home')}
              >
                <Typography variant="body2" color="primary" weight="semibold">
                  Browse Services
                </Typography>
              </TouchableOpacity>
            </View>
          ) : (
            bookings.map(renderBookingCard)
          )}
        </ScrollView>
      )}
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: theme.colors.background.primary,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    paddingHorizontal: theme.semanticSpacing.screenPadding,
    paddingVertical: theme.semanticSpacing.md,
    borderBottomWidth: 1,
    borderBottomColor: theme.colors.border.light,
  },
  backButton: {
    padding: 4,
  },
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    padding: theme.semanticSpacing.screenPadding,
    paddingBottom: theme.semanticSpacing.xl,
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  loadingText: {
    marginTop: theme.semanticSpacing.md,
    color: theme.colors.text.secondary,
  },
  emptyContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingVertical: 60,
    paddingHorizontal: theme.semanticSpacing.lg,
  },
  emptyTitle: {
    marginTop: theme.semanticSpacing.md,
    marginBottom: theme.semanticSpacing.sm,
  },
  emptyText: {
    marginBottom: theme.semanticSpacing.lg,
  },
  browseButton: {
    paddingVertical: theme.semanticSpacing.sm,
    paddingHorizontal: theme.semanticSpacing.md,
    borderRadius: theme.borderRadius.md,
    backgroundColor: `${theme.colors.primary.main}15`,
  },
  bookingCard: {
    marginBottom: theme.semanticSpacing.md,
  },
  cardContainer: {
    ...theme.shadows.sm,
  },
  cardHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: theme.semanticSpacing.sm,
  },
  serviceName: {
    flex: 1,
    marginRight: theme.semanticSpacing.sm,
  },
  statusBadge: {
    paddingHorizontal: theme.semanticSpacing.xs,
    paddingVertical: 4,
    borderRadius: theme.borderRadius.sm,
  },
  cardContent: {
    marginBottom: theme.semanticSpacing.sm,
  },
  infoRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 6,
  },
  infoText: {
    marginLeft: theme.semanticSpacing.xs,
    color: theme.colors.text.secondary,
  },
  priceRow: {
    marginTop: theme.semanticSpacing.xs,
  },
  cardFooter: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginTop: theme.semanticSpacing.xs,
    paddingTop: theme.semanticSpacing.xs,
    borderTopWidth: 1,
    borderTopColor: theme.colors.border.light,
  },
});
