import React, { useState, useEffect } from 'react';
import {
  View,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Alert,
  ActivityIndicator,
  Linking,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { StatusBar } from 'expo-status-bar';
import { Ionicons } from '@expo/vector-icons';
import { Typography, Button, Card } from '../../components/ui';
import { theme } from '../../theme';
import { ScreenProps, Booking } from '../../navigation/types';
import { supabase } from '../../lib/supabase';

export const BookingStatusScreen: React.FC<ScreenProps<'BookingStatus'>> = ({ 
  navigation, 
  route 
}) => {
  const { bookingId } = route.params;
  
  const [booking, setBooking] = useState<Booking | null>(null);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);

  useEffect(() => {
    loadBookingDetails();
    
    // Set up real-time subscription for booking updates
    const subscription = supabase
      .channel(`booking-${bookingId}`)
      .on('postgres_changes', {
        event: 'UPDATE',
        schema: 'public',
        table: 'bookings',
        filter: `id=eq.${bookingId}`
      }, (payload) => {
        console.log('Booking updated:', payload);
        loadBookingDetails();
      })
      .subscribe();

    return () => {
      subscription.unsubscribe();
    };
  }, [bookingId]);

  const loadBookingDetails = async () => {
    try {
      // Fetch booking with hero details, address, and add-ons
      const { data, error } = await supabase
        .from('bookings')
        .select(`
          *,
          heros:fk_bookings_hero (
            id,
            name,
            rating_avg,
            rating_count,
            skills,
            contractor_id
          ),
          services (id, title),
          service_variants (id, name),
          addresses (
            id,
            street,
            line1,
            city,
            province,
            postal_code,
            label
          )
        `)
        .eq('id', bookingId)
        .single();

      // Fetch add-ons separately
      const { data: addOnsData } = await supabase
        .from('booking_add_ons')
        .select(`
          add_on_id,
          add_ons (
            id,
            name,
            price
          )
        `)
        .eq('booking_id', bookingId);

      if (error) {
        console.error('Error loading booking:', error);
        Alert.alert('Error', 'Failed to load booking details');
        return;
      }

      // Transform the data to match our Booking type
      const transformedBooking: Booking = {
        id: data.id,
        status: data.status,
        request: {
          serviceId: data.service_id,
          subcategoryId: data.service_variant_id,
          serviceName: data.services?.title || data.service_name || 'Unknown Service',
          variantName: data.service_variants?.name || data.variant_name || 'Unknown Variant',
          scheduledDate: data.scheduled_at,
          scheduledTime: new Date(data.scheduled_at).toLocaleTimeString('en-CA', { hour: '2-digit', minute: '2-digit' }),
          duration: data.duration_min,
          address: {
            street: data.addresses?.street || data.addresses?.line1 || 'Address not available',
            city: data.addresses?.city || '',
            postalCode: data.addresses?.postal_code || '',
            province: data.addresses?.province,
            label: data.addresses?.label,
          },
          phoneNumber: data.customer_phone || '',
          addOns: addOnsData?.map(ao => ao.add_on_id) || [],
          specialInstructions: data.notes,
          heroId: data.hero_id,
        },
        addOnDetails: addOnsData?.map((ao: any) => ({
          id: ao.add_ons?.id || ao.add_on_id,
          name: ao.add_ons?.name || 'Unknown Add-on',
          price: parseFloat(ao.add_ons?.price || 0),
        })) || [],
        hero: data.heros ? {
          id: data.heros.id,
          name: data.heros.name,
          rating: parseFloat(data.heros.rating_avg) || 0,
          reviewCount: data.heros.rating_count || 0,
          skills: data.heros.skills || [],
          isAvailable: true,
          contractor_id: data.heros.contractor_id
        } : undefined,
        pricing: {
          basePrice: 0,
          callOutFee: 0,
          addOnTotal: 0,
          subtotal: data.price_cents / 100,
          tax: 0,
          total: data.price_cents / 100,
          promoDiscount: 0,
        },
        createdAt: new Date(data.created_at),
        updatedAt: new Date(data.updated_at),
        estimatedArrival: undefined,
        actualArrival: undefined,
        completedAt: undefined,
      };

      setBooking(transformedBooking);
    } catch (error) {
      console.error('Error loading booking details:', error);
      Alert.alert('Error', 'Something went wrong');
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  };

  const handleRefresh = () => {
    setRefreshing(true);
    loadBookingDetails();
  };

  const handleCancelBooking = () => {
    Alert.alert(
      'Cancel Booking',
      'Are you sure you want to cancel this booking? You may be charged a cancellation fee.',
      [
        { text: 'Keep Booking', style: 'cancel' },
        { 
          text: 'Cancel Booking', 
          style: 'destructive',
          onPress: confirmCancelBooking
        }
      ]
    );
  };

  const confirmCancelBooking = async () => {
    try {
      const { error } = await supabase.rpc('update_booking_status', {
        booking_id: bookingId,
        new_status: 'cancelled',
        notes: 'Cancelled by customer',
        user_id: booking?.request.heroId
      });

      if (error) {
        Alert.alert('Error', 'Failed to cancel booking');
        return;
      }

      Alert.alert('Booking Cancelled', 'Your booking has been cancelled successfully.');
      navigation.goBack();
    } catch (error) {
      Alert.alert('Error', 'Something went wrong');
    }
  };

  const handleCallHero = () => {
    if (booking?.hero) {
      // In a real app, you'd have the hero's phone number
      const phoneNumber = '+1234567890'; // Mock phone number
      Linking.openURL(`tel:${phoneNumber}`);
    }
  };

  const handleAddToCalendar = () => {
    if (!booking) return;

    const startDate = new Date(booking.request.scheduledDate);
    const [hours, minutes] = booking.request.scheduledTime.split(':');
    startDate.setHours(parseInt(hours), parseInt(minutes));
    
    const endDate = new Date(startDate);
    endDate.setMinutes(endDate.getMinutes() + booking.request.duration);

    const title = `HomeHeros Service - ${booking.request.variantName}`;
    const details = `Service: ${booking.request.variantName}\nCategory: ${booking.request.serviceName}\nAddress: ${booking.request.address.street}, ${booking.request.address.city}\nProvider: ${booking.hero?.name || 'TBD'}`;
    const location = `${booking.request.address.street}, ${booking.request.address.city}`;

    // Format dates for calendar URL
    const formatDate = (date: Date) => {
      return date.toISOString().replace(/[-:]/g, '').split('.')[0] + 'Z';
    };

    const calendarUrl = `https://calendar.google.com/calendar/render?action=TEMPLATE&text=${encodeURIComponent(title)}&dates=${formatDate(startDate)}/${formatDate(endDate)}&details=${encodeURIComponent(details)}&location=${encodeURIComponent(location)}`;

    Linking.openURL(calendarUrl).catch(() => {
      Alert.alert('Error', 'Could not open calendar app');
    });
  };

  const getStatusInfo = (status: string) => {
    switch (status) {
      case 'requested':
        return {
          title: 'Awaiting Hero Assignment',
          description: 'We\'re finding the perfect service provider for you',
          icon: 'hourglass-outline' as keyof typeof Ionicons.glyphMap,
          color: theme.colors.warning.main,
          showProgress: true
        };
      case 'confirmed':
        return {
          title: 'Booking Confirmed',
          description: 'Your service provider has been assigned',
          icon: 'checkmark-circle-outline' as keyof typeof Ionicons.glyphMap,
          color: theme.colors.success.main,
          showProgress: false
        };
      case 'en_route':
        return {
          title: 'Provider En Route',
          description: 'Your service provider is on their way',
          icon: 'car-outline' as keyof typeof Ionicons.glyphMap,
          color: theme.colors.info.main,
          showProgress: false
        };
      case 'in_progress':
        return {
          title: 'Service In Progress',
          description: 'Your service is currently being performed',
          icon: 'construct-outline' as keyof typeof Ionicons.glyphMap,
          color: theme.colors.primary.main,
          showProgress: false
        };
      case 'completed':
        return {
          title: 'Service Completed',
          description: 'Your service has been completed successfully',
          icon: 'checkmark-done-outline' as keyof typeof Ionicons.glyphMap,
          color: theme.colors.success.main,
          showProgress: false
        };
      case 'cancelled':
        return {
          title: 'Booking Cancelled',
          description: 'This booking has been cancelled',
          icon: 'close-circle-outline' as keyof typeof Ionicons.glyphMap,
          color: theme.colors.error.main,
          showProgress: false
        };
      default:
        return {
          title: 'Unknown Status',
          description: 'Status unknown',
          icon: 'help-circle-outline' as keyof typeof Ionicons.glyphMap,
          color: theme.colors.text.secondary,
          showProgress: false
        };
    }
  };

  const formatDate = (date: Date) => {
    return date.toLocaleDateString('en-CA', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  };

  if (loading) {
    return (
      <SafeAreaView style={styles.container}>
        <View style={styles.loadingContainer}>
          <ActivityIndicator size="large" color={theme.colors.primary.main} />
          <Typography variant="body1" style={styles.loadingText}>
            Loading booking details...
          </Typography>
        </View>
      </SafeAreaView>
    );
  }

  if (!booking) {
    return (
      <SafeAreaView style={styles.container}>
        <View style={styles.errorContainer}>
          <Ionicons name="alert-circle-outline" size={48} color={theme.colors.error.main} />
          <Typography variant="h6" style={styles.errorTitle}>
            Booking Not Found
          </Typography>
          <Typography variant="body2" color="secondary" align="center">
            We couldn't find the booking you're looking for.
          </Typography>
          <Button
            title="Go Back"
            onPress={() => navigation.goBack()}
            style={styles.errorButton}
          />
        </View>
      </SafeAreaView>
    );
  }

  const statusInfo = getStatusInfo(booking.status);

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar style="dark" backgroundColor={theme.colors.background.primary} />
      
      {/* Header */}
      <View style={styles.header}>
        <TouchableOpacity
          style={styles.backButton}
          onPress={() => navigation.goBack()}
        >
          <Ionicons name="arrow-back" size={24} color={theme.colors.text.primary} />
        </TouchableOpacity>
        
        <View style={styles.headerContent}>
          <Typography variant="h5" weight="semibold">
            Booking Status
          </Typography>
          <Typography variant="body2" color="secondary">
            Booking #{booking.id.slice(-8)}
          </Typography>
        </View>

        <TouchableOpacity
          style={styles.refreshButton}
          onPress={handleRefresh}
        >
          <Ionicons 
            name="refresh" 
            size={24} 
            color={theme.colors.text.primary}
            style={refreshing ? styles.spinning : undefined}
          />
        </TouchableOpacity>
      </View>

      <ScrollView 
        style={styles.scrollView}
        contentContainerStyle={styles.scrollContent}
        showsVerticalScrollIndicator={false}
      >
        {/* Status Card */}
        <Card variant="default" padding="lg" style={styles.statusCard}>
          <View style={styles.statusHeader}>
            <View style={[styles.statusIcon, { backgroundColor: `${statusInfo.color}15` }]}>
              <Ionicons name={statusInfo.icon} size={32} color={statusInfo.color} />
            </View>
            
            <View style={styles.statusInfo}>
              <Typography variant="h5" weight="semibold">
                {statusInfo.title}
              </Typography>
              <Typography variant="body1" color="secondary">
                {statusInfo.description}
              </Typography>
            </View>
          </View>

          {statusInfo.showProgress && (
            <View style={styles.progressContainer}>
              <View style={styles.progressBar}>
                <View style={styles.progressFill} />
              </View>
              <Typography variant="caption" color="secondary" style={styles.progressText}>
                Estimated assignment time: 5-15 minutes
              </Typography>
            </View>
          )}
        </Card>

        {/* Service Details */}
        <Card variant="default" padding="md" style={styles.detailsCard}>
          <Typography variant="h6" weight="semibold" style={styles.sectionTitle}>
            Service Details
          </Typography>
          
          <View style={styles.detailRow}>
            <Typography variant="body2" color="secondary">Service</Typography>
            <Typography variant="body1" weight="medium">
              {booking.request.variantName}
            </Typography>
          </View>

          <View style={styles.detailRow}>
            <Typography variant="body2" color="secondary">Category</Typography>
            <Typography variant="body1">
              {booking.request.serviceName}
            </Typography>
          </View>
          
          <View style={styles.detailRow}>
            <Typography variant="body2" color="secondary">Date & Time</Typography>
            <Typography variant="body1">
              {formatDate(new Date(booking.request.scheduledDate))} at {booking.request.scheduledTime}
            </Typography>
          </View>
          
          <View style={styles.detailRow}>
            <Typography variant="body2" color="secondary">Duration</Typography>
            <Typography variant="body1">
              {Math.floor(booking.request.duration / 60)}h {booking.request.duration % 60}m
            </Typography>
          </View>
          
          <View style={styles.detailRow}>
            <Typography variant="body2" color="secondary">Address</Typography>
            <View style={styles.addressDetails}>
              {booking.request.address.label && (
                <Typography variant="body2" weight="medium">
                  {booking.request.address.label}
                </Typography>
              )}
              <Typography variant="body1">
                {booking.request.address.street}
              </Typography>
              <Typography variant="body2" color="secondary">
                {booking.request.address.city}, {booking.request.address.province || 'ON'} {booking.request.address.postalCode}
              </Typography>
            </View>
          </View>

          {booking.request.phoneNumber && (
            <View style={styles.detailRow}>
              <Typography variant="body2" color="secondary">Contact Phone</Typography>
              <TouchableOpacity onPress={() => Linking.openURL(`tel:${booking.request.phoneNumber}`)}>
                <Typography variant="body1" color="brand" weight="medium">
                  {booking.request.phoneNumber}
                </Typography>
              </TouchableOpacity>
            </View>
          )}

          {booking.addOnDetails && booking.addOnDetails.length > 0 && (
            <View style={styles.addOnsSection}>
              <Typography variant="body2" color="secondary" style={styles.addOnsTitle}>
                Add-ons
              </Typography>
              {booking.addOnDetails.map((addOn: any) => (
                <View key={addOn.id} style={styles.addOnRow}>
                  <Typography variant="body2">{addOn.name}</Typography>
                  <Typography variant="body2" weight="medium">
                    +${addOn.price.toFixed(2)}
                  </Typography>
                </View>
              ))}
            </View>
          )}
          
          <View style={[styles.detailRow, styles.totalRow]}>
            <Typography variant="h6" weight="semibold">Total Amount</Typography>
            <Typography variant="h6" weight="semibold" color="brand">
              ${booking.pricing.total.toFixed(2)}
            </Typography>
          </View>
        </Card>

        {/* Hero Details (if assigned) */}
        {booking.hero && (
          <Card variant="default" padding="md" style={styles.heroCard}>
            <Typography variant="h6" weight="semibold" style={styles.sectionTitle}>
              Your Service Provider
            </Typography>
            
            <View style={styles.heroInfo}>
              <View style={styles.heroAvatar}>
                <Typography variant="h5" color="inverse" weight="semibold">
                  {booking.hero.name.split(' ').map(n => n[0]).join('')}
                </Typography>
              </View>
              
              <View style={styles.heroDetails}>
                <Typography variant="h6" weight="semibold">
                  {booking.hero.name}
                </Typography>
                
                <View style={styles.heroRating}>
                  <Ionicons name="star" size={16} color="#FFD700" />
                  <Typography variant="body2" weight="medium" style={styles.ratingText}>
                    {booking.hero.rating} ({booking.hero.reviewCount} reviews)
                  </Typography>
                </View>
              </View>
              
              <TouchableOpacity
                style={styles.callButton}
                onPress={handleCallHero}
              >
                <Ionicons name="call" size={20} color={theme.colors.primary.main} />
              </TouchableOpacity>
            </View>
          </Card>
        )}

        {/* Action Buttons */}
        <View style={styles.actionButtons}>
          <Button
            title="Add to Calendar"
            variant="outline"
            onPress={handleAddToCalendar}
            style={styles.actionButton}
          />
          
          {booking.status === 'requested' && (
            <Button
              title="Cancel Booking"
              variant="outline"
              onPress={handleCancelBooking}
              style={styles.cancelButton}
            />
          )}
        </View>
      </ScrollView>
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
    paddingHorizontal: theme.semanticSpacing.md,
    paddingVertical: theme.semanticSpacing.md,
    borderBottomWidth: 1,
    borderBottomColor: theme.colors.border.light,
  },
  backButton: {
    marginRight: theme.semanticSpacing.sm,
    padding: theme.semanticSpacing.xs,
  },
  headerContent: {
    flex: 1,
  },
  refreshButton: {
    padding: theme.semanticSpacing.xs,
  },
  spinning: {
    // Add rotation animation if needed
  },
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    padding: theme.semanticSpacing.screenPadding,
    paddingBottom: theme.semanticSpacing.xl,
  },
  statusCard: {
    marginBottom: theme.semanticSpacing.md,
    ...theme.shadows.md,
  },
  statusHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: theme.semanticSpacing.md,
  },
  statusIcon: {
    width: 64,
    height: 64,
    borderRadius: 32,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: theme.semanticSpacing.md,
  },
  statusInfo: {
    flex: 1,
  },
  progressContainer: {
    marginTop: theme.semanticSpacing.md,
  },
  progressBar: {
    height: 4,
    backgroundColor: theme.colors.neutral[200],
    borderRadius: 2,
    overflow: 'hidden',
  },
  progressFill: {
    height: '100%',
    width: '30%',
    backgroundColor: theme.colors.primary.main,
    borderRadius: 2,
  },
  progressText: {
    marginTop: theme.semanticSpacing.xs,
    textAlign: 'center',
  },
  detailsCard: {
    marginBottom: theme.semanticSpacing.md,
    ...theme.shadows.sm,
  },
  sectionTitle: {
    marginBottom: theme.semanticSpacing.md,
  },
  detailRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    paddingVertical: theme.semanticSpacing.xs,
    borderBottomWidth: 1,
    borderBottomColor: theme.colors.border.light,
    paddingBottom: theme.semanticSpacing.sm,
    marginBottom: theme.semanticSpacing.sm,
  },
  addressDetails: {
    flex: 1,
    alignItems: 'flex-end',
  },
  addOnsSection: {
    marginTop: theme.semanticSpacing.sm,
    paddingTop: theme.semanticSpacing.sm,
    borderTopWidth: 1,
    borderTopColor: theme.colors.border.light,
  },
  addOnsTitle: {
    marginBottom: theme.semanticSpacing.xs,
  },
  addOnRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingVertical: 4,
    paddingLeft: theme.semanticSpacing.sm,
  },
  totalRow: {
    borderTopWidth: 2,
    borderTopColor: theme.colors.primary.main,
    borderBottomWidth: 0,
    marginTop: theme.semanticSpacing.sm,
    paddingTop: theme.semanticSpacing.md,
  },
  heroCard: {
    marginBottom: theme.semanticSpacing.md,
    ...theme.shadows.sm,
  },
  heroInfo: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  heroAvatar: {
    width: 56,
    height: 56,
    borderRadius: 28,
    backgroundColor: theme.colors.primary.main,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: theme.semanticSpacing.md,
  },
  heroDetails: {
    flex: 1,
  },
  heroRating: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: 4,
  },
  ratingText: {
    marginLeft: 4,
  },
  callButton: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: `${theme.colors.primary.main}15`,
    justifyContent: 'center',
    alignItems: 'center',
  },
  actionButtons: {
    gap: theme.semanticSpacing.md,
  },
  actionButton: {
    marginBottom: theme.semanticSpacing.sm,
  },
  cancelButton: {
    borderColor: theme.colors.error.main,
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  loadingText: {
    marginTop: theme.semanticSpacing.md,
  },
  errorContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingHorizontal: theme.semanticSpacing.screenPadding,
  },
  errorTitle: {
    marginTop: theme.semanticSpacing.md,
    marginBottom: theme.semanticSpacing.sm,
  },
  errorButton: {
    marginTop: theme.semanticSpacing.lg,
  },
});
