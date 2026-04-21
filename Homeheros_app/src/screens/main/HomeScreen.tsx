import React, { useState, useEffect } from 'react';
import {
  View,
  StyleSheet,
  ScrollView,
  StatusBar,
  TouchableOpacity,
  Dimensions,
  Image,
  Alert,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { LinearGradient } from 'expo-linear-gradient';
import { Ionicons } from '@expo/vector-icons';
import { Button, Typography, Card, Input } from '../../components/ui';
import { useAuth } from '../../contexts/AuthContext';
import { useLocation } from '../../contexts/LocationContext';
import { serviceCatalog } from '../../data/serviceCatalog';
import { supabase } from '../../lib/supabase';
import { ServiceCategory } from '../../navigation/types';
import { theme } from '../../theme';

const { width: screenWidth } = Dimensions.get('window');

interface SubCategory {
  id: string;
  name: string;
  description: string;
  price?: string;
  icon?: keyof typeof Ionicons.glyphMap;
}

interface HomeScreenProps {
  navigation: any;
}
export const HomeScreen: React.FC<HomeScreenProps> = ({ navigation }) => {
  const { user, profile, signOut } = useAuth();
  const { currentCity, loading: locationLoading, setCity, supportedCities } = useLocation();
  const [showCitySelector, setShowCitySelector] = useState(false);
  const [services, setServices] = useState<ServiceCategory[]>(serviceCatalog);
  const [loading, setLoading] = useState(false);
  const [recentAddress, setRecentAddress] = useState<any>(null);
  const [showAddressTooltip, setShowAddressTooltip] = useState(false);
  const [activeBooking, setActiveBooking] = useState<any>(null);

  // Fetch services from Supabase
  useEffect(() => {
    fetchServicesFromSupabase();
    fetchRecentAddress();
    fetchActiveBooking();

    // Subscribe to real-time booking updates
    if (user?.id) {
      const subscription = supabase
        .channel(`bookings-${user.id}`)
        .on('postgres_changes', {
          event: '*',
          schema: 'public',
          table: 'bookings',
          filter: `customer_id=eq.${user.id}`
        }, (payload) => {
          console.log('Booking update received:', payload);
          fetchActiveBooking(); // Refresh active booking when any booking changes
        })
        .subscribe();

      return () => {
        subscription.unsubscribe();
      };
    }
  }, [user?.id]);

  const fetchActiveBooking = async () => {
    if (!user?.id) return;

    try {
      console.log('Fetching active bookings for user:', user.id);
      
      const { data, error } = await supabase
        .from('bookings')
        .select(`
          id,
          status,
          scheduled_at,
          services (title),
          heros:fk_bookings_hero (name, photo_url)
        `)
        .eq('customer_id', user.id)
        .in('status', ['awaiting_hero_accept', 'enroute', 'arrived', 'in_progress'])
        .order('scheduled_at', { ascending: true })
        .limit(1)
        .single();

      if (error) {
        if (error.code !== 'PGRST116') { // PGRST116 = no rows found
          console.error('Error fetching active booking:', error);
        }
        setActiveBooking(null);
        return;
      }

      if (data) {
        console.log('Active booking found:', data);
        setActiveBooking(data);
      }
    } catch (error) {
      console.error('Error:', error);
      setActiveBooking(null);
    }
  };

  const fetchRecentAddress = async () => {
    if (!user?.id) return;

    try {
      const { data, error } = await supabase
        .from('addresses')
        .select('*')
        .eq('user_id', user.id)
        // Don't filter by city - show any recent address
        .order('created_at', { ascending: false })
        .limit(1)
        .single();

      if (error) {
        // PGRST116 is "no rows returned" - this is expected when no addresses exist
        if (error.code === 'PGRST116') {
          console.log('No saved addresses found');
          setRecentAddress(null);
          setShowAddressTooltip(false);
        } else if (error.code === '42703') {
          // Missing column - gracefully skip
          console.log('Addresses table schema needs update. Skipping tooltip.');
          setRecentAddress(null);
          setShowAddressTooltip(false);
        } else {
          console.error('Error fetching recent address:', error);
        }
        return;
      }

      if (data) {
        setRecentAddress(data);
        setShowAddressTooltip(true);
        // Auto-hide tooltip after 5 seconds
        setTimeout(() => setShowAddressTooltip(false), 5000);
      }
    } catch (error) {
      console.error('Error:', error);
      setRecentAddress(null);
      setShowAddressTooltip(false);
    }
  };

  const fetchServicesFromSupabase = async () => {
    try {
      setLoading(true);
      
      // Fetch services with their variants
      const { data: servicesData, error: servicesError } = await supabase
        .from('services')
        .select(`
          id,
          title,
          slug,
          icon,
          color,
          description,
          call_out_fee,
          min_duration,
          max_duration,
          service_variants (
            id,
            name,
            slug,
            description,
            base_price,
            default_duration
          )
        `)
        .eq('active', true)
        .order('title');

      if (servicesError) {
        console.error('Error fetching services:', servicesError);
        // Fall back to static data
        return;
      }

      // Transform Supabase data to match our ServiceCategory interface
      const transformedServices: ServiceCategory[] = servicesData.map((service: any) => ({
        id: service.id, // Use UUID instead of slug
        name: service.title, // Use title from database
        icon: service.icon as keyof typeof Ionicons.glyphMap,
        color: service.color,
        description: service.description,
        image: getServiceImage(service.slug), // Use slug for image lookup
        callOutFee: service.call_out_fee > 0 ? `$${service.call_out_fee} call out fee` : 'No call-out fee',
        minDuration: service.min_duration,
        maxDuration: service.max_duration,
        subcategories: service.service_variants?.map((variant: any) => ({
          id: variant.id, // Use UUID instead of slug
          name: variant.name,
          description: variant.description,
          price: variant.base_price ? `From $${(variant.base_price / 100).toFixed(0)}` : 'Custom pricing',
          duration: variant.default_duration,
          addOns: [] // Would need to fetch separately if needed
        })) || []
      }));

      setServices(transformedServices);
    } catch (error) {
      console.error('Error fetching services:', error);
      // Keep using static data as fallback
    } finally {
      setLoading(false);
    }
  };

  // Helper function to map service slugs to local images
  const getServiceImage = (slug: string) => {
    const imageMap: { [key: string]: any } = {
      'maid-services': require('../../../assets/Services_images/cleaning.png'),
      'cooks-chefs': require('../../../assets/Services_images/cooking.png'),
      'event-planning': require('../../../assets/Services_images/event.png'),
      'travel-services': require('../../../assets/Services_images/travel.png'),
      'handymen': require('../../../assets/Services_images/handyman.png'),
      'auto-services': require('../../../assets/Services_images/auto.png'),
      'personal-care': require('../../../assets/Services_images/personalcare.png'),
      'moving-services': require('../../../assets/Services_images/moving.png'),
    };
    return imageMap[slug] || require('../../../assets/Services_images/cleaning.png');
  };

  const handleServicePress = (service: ServiceCategory) => {
    // Navigate to service detail screen
    navigation.navigate('ServiceDetail', { service });
  };

  const handleSearchPress = () => {
    // Navigate to search screen
    navigation.navigate('Search');
  };

  const handleProfilePress = () => {
    // Navigate to profile
    navigation.navigate('Profile');
  };

  const handleNotificationPress = () => {
    // Navigate to notifications - TODO: Implement later
    Alert.alert('Coming Soon', 'Notifications feature will be available soon!');
  };

  const handleChatPress = () => {
    // Navigate to support chat
    navigation.navigate('Support');
  };

  const renderHeader = () => (
    <View style={styles.headerContainer}>
      <View style={styles.headerContent}>
        <View style={styles.headerTop}>
          <View>
            <Typography variant="body2" color="secondary" style={styles.greeting}>
              Good morning,
            </Typography>
            <Typography variant="h4" color="primary" weight="semibold">
              {profile?.name || user?.email?.split('@')[0] || 'User'}
            </Typography>
          </View>
          
          <View style={styles.headerActions}>
            <TouchableOpacity
              style={styles.headerButton}
              onPress={handleNotificationPress}
            >
              <Ionicons name="notifications-outline" size={24} color={theme.colors.text.primary} />
            </TouchableOpacity>
            
            <TouchableOpacity
              style={styles.headerButton}
              onPress={handleChatPress}
            >
              <Ionicons name="chatbubble-ellipses-outline" size={24} color={theme.colors.text.primary} />
            </TouchableOpacity>
            
            <TouchableOpacity
              style={styles.headerButton}
              onPress={handleProfilePress}
            >
              <Ionicons name="person-circle-outline" size={24} color={theme.colors.text.primary} />
            </TouchableOpacity>
          </View>
        </View>

        {/* Location selector */}
        <TouchableOpacity 
          style={styles.locationSelector}
          onPress={() => setShowCitySelector(!showCitySelector)}
        >
          <View style={styles.locationContent}>
            <Ionicons name="location-outline" size={18} color={theme.colors.primary.main} />
            <Typography variant="body2" color="primary" weight="medium" style={styles.locationText}>
              {currentCity}
            </Typography>
            <Ionicons 
              name={showCitySelector ? "chevron-up" : "chevron-down"} 
              size={16} 
              color={theme.colors.text.secondary} 
            />
          </View>
        </TouchableOpacity>

        {/* City selection dropdown */}
        {showCitySelector && (
          <Card variant="default" padding="sm" style={styles.cityDropdown}>
            {supportedCities.map((city) => (
              <TouchableOpacity 
                key={city} 
                style={styles.cityOption}
                onPress={() => {
                  setCity(city);
                  setShowCitySelector(false);
                }}
              >
                <Typography 
                  variant="body2" 
                  color={city === currentCity ? "brand" : "primary"}
                  weight={city === currentCity ? "semibold" : "regular"}
                >
                  {city}
                </Typography>
                {city === currentCity && (
                  <Ionicons name="checkmark" size={16} color={theme.colors.primary.main} />
                )}
              </TouchableOpacity>
            ))}
            <Typography variant="caption" color="secondary" style={styles.priceNote}>
              * Prices may vary based on location
            </Typography>
          </Card>
        )}

        {/* Recent Address Tooltip */}
        {showAddressTooltip && recentAddress && (
          <Card variant="default" padding="sm" style={styles.addressTooltip}>
            <View style={styles.tooltipHeader}>
              <View style={styles.tooltipTitleContainer}>
                <Ionicons name="information-circle" size={16} color={theme.colors.primary.main} />
                <Typography variant="caption" weight="semibold" style={styles.tooltipTitle}>
                  Recent Address
                </Typography>
              </View>
              <TouchableOpacity onPress={() => setShowAddressTooltip(false)}>
                <Ionicons name="close" size={16} color={theme.colors.text.secondary} />
              </TouchableOpacity>
            </View>
            <View style={styles.tooltipContent}>
              <Typography variant="body2" weight="medium">
                {recentAddress.label || 'Address'}
              </Typography>
              <Typography variant="caption" color="secondary">
                {recentAddress.street}, {recentAddress.city}
              </Typography>
            </View>
            <TouchableOpacity 
              style={styles.tooltipButton}
              onPress={() => navigation.navigate('SavedAddresses')}
            >
              <Typography variant="caption" color="brand" weight="medium">
                Manage Addresses →
              </Typography>
            </TouchableOpacity>
          </Card>
        )}

        <Typography variant="body1" color="secondary" style={styles.subtitle}>
          What service do you need today?
        </Typography>
      </View>
    </View>
  );

  const renderSearchBar = () => (
    <View style={styles.searchContainer}>
      <Card variant="default" padding="none" style={styles.searchCard}>
        <Input
          placeholder="Search for services..."
          leftIcon="search-outline"
          variant="default"
          onFocus={handleSearchPress}
          containerStyle={styles.searchInput}
          style={styles.searchInputField}
        />
      </Card>
    </View>
  );

  const renderServiceCategories = () => (
    <View style={styles.categoriesContainer}>
      <Typography variant="h5" weight="semibold" style={styles.sectionTitle}>
        Popular Services
      </Typography>
      
      <View style={styles.categoriesGrid}>
        {services.map((service: ServiceCategory) => (
          <TouchableOpacity
            key={service.id}
            style={styles.categoryCard}
            onPress={() => handleServicePress(service)}
            activeOpacity={0.8}
          >
            <Card variant="default" padding="none" style={styles.categoryCardInner}>
              <View style={styles.categoryImageContainer}>
                <Image
                  source={service.image}
                  style={styles.categoryImage}
                  resizeMode="cover"
                />
                <View style={styles.categoryOverlay}>
                  <View style={[styles.categoryIconContainer, { backgroundColor: service.color }]}>
                    <Ionicons
                      name={service.icon as any}
                      size={24}
                      color={theme.colors.neutral.white}
                    />
                  </View>
                </View>
              </View>
              
              <View style={styles.categoryContent}>
                <Typography variant="h6" weight="semibold" style={styles.categoryName}>
                  {service.name}
                </Typography>
                
                <Typography variant="caption" color="secondary" align="center" style={styles.categoryDescription}>
                  {service.description}
                </Typography>
              </View>
            </Card>
          </TouchableOpacity>
        ))}
      </View>
    </View>
  );

  const handleBookAgain = () => {
    navigation.navigate('BookingHistory');
  };

  const handleSchedule = () => {
    // Navigate to first service for scheduling
    if (services.length > 0) {
      navigation.navigate('ServiceDetail', { service: services[0] });
    }
  };

  const handleOffers = () => {
    navigation.navigate('PromosTab');
  };

  const renderQuickActions = () => (
    <View style={styles.quickActionsContainer}>
      <Typography variant="h5" weight="semibold" style={styles.sectionTitle}>
        Quick Actions
      </Typography>
      
      <View style={styles.quickActionsRow}>
        <TouchableOpacity onPress={handleBookAgain}>
          <Card variant="outlined" padding="md" style={styles.quickActionCard}>
            <Ionicons
              name="time-outline"
              size={24}
              color={theme.colors.primary.main}
              style={styles.quickActionIcon}
            />
            <Typography variant="body2" weight="medium">
              Book Again
            </Typography>
            <Typography variant="caption" color="secondary">
              Repeat last service
            </Typography>
          </Card>
        </TouchableOpacity>
        
        <TouchableOpacity onPress={handleSchedule}>
          <Card variant="outlined" padding="md" style={styles.quickActionCard}>
            <Ionicons
              name="calendar-outline"
              size={24}
              color={theme.colors.primary.main}
              style={styles.quickActionIcon}
            />
            <Typography variant="body2" weight="medium">
              Schedule
            </Typography>
            <Typography variant="caption" color="secondary">
              Plan ahead
            </Typography>
          </Card>
        </TouchableOpacity>
        
        <TouchableOpacity onPress={handleOffers}>
          <Card variant="outlined" padding="md" style={styles.quickActionCard}>
            <Ionicons
              name="gift-outline"
              size={24}
              color={theme.colors.primary.main}
              style={styles.quickActionIcon}
            />
            <Typography variant="body2" weight="medium">
              Offers
            </Typography>
            <Typography variant="caption" color="secondary">
              Special deals
            </Typography>
          </Card>
        </TouchableOpacity>
      </View>
    </View>
  );

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar barStyle="dark-content" backgroundColor={theme.colors.background.primary} />
      
      {renderHeader()}
      
      <ScrollView
        style={styles.scrollView}
        showsVerticalScrollIndicator={false}
        contentContainerStyle={styles.scrollContent}
      >
        {renderSearchBar()}
        
        {/* Active Booking Card */}
        {activeBooking && (
          <TouchableOpacity 
            style={styles.activeBookingCard}
            onPress={() => navigation.navigate('BookingStatus', { bookingId: activeBooking.id })}
          >
            <LinearGradient
              colors={['#FF6B35', '#FF8C5A']}
              start={{ x: 0, y: 0 }}
              end={{ x: 1, y: 1 }}
              style={styles.activeBookingGradient}
            >
              <View style={styles.activeBookingHeader}>
                <View style={styles.activeBookingIcon}>
                  <Ionicons name="car" size={20} color="#fff" />
                </View>
                <View style={styles.activeBookingInfo}>
                  <Typography variant="body2" style={styles.activeBookingTitle}>
                    Active Booking
                  </Typography>
                  <Typography variant="h6" style={styles.activeBookingService}>
                    {activeBooking.services?.title || 'Service'}
                  </Typography>
                </View>
              </View>
              
              <View style={styles.activeBookingStatus}>
                <View style={styles.statusBadge}>
                  <View style={styles.statusDot} />
                  <Typography variant="caption" style={styles.statusText}>
                    {activeBooking.status === 'enroute' ? 'En Route' : 
                     activeBooking.status === 'arrived' ? 'Arrived' :
                     activeBooking.status === 'in_progress' ? 'In Progress' :
                     'Awaiting Hero'}
                  </Typography>
                </View>
                
                {activeBooking.heros && (
                  <View style={styles.heroInfo}>
                    <Typography variant="caption" style={styles.heroName}>
                      {activeBooking.heros.name}
                    </Typography>
                  </View>
                )}
              </View>

              <View style={styles.activeBookingFooter}>
                <Typography variant="caption" style={styles.viewDetailsText}>
                  Tap to view details →
                </Typography>
              </View>
            </LinearGradient>
          </TouchableOpacity>
        )}
        
        {renderServiceCategories()}
        {renderQuickActions()}
        
        {/* Debug Section - Remove in production */}
        <Card variant="outlined" padding="md" margin="md">
          <Typography variant="body2" color="secondary">
            Debug: Logged in as {user?.email}
          </Typography>
          <Button
            title="Sign Out"
            variant="outline"
            size="sm"
            onPress={signOut}
            style={{ marginTop: theme.semanticSpacing.sm }}
          />
        </Card>
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: theme.colors.background.primary,
  },
  
  headerContainer: {
    backgroundColor: theme.colors.background.primary,
    paddingBottom: theme.semanticSpacing.md,
  },
  
  headerContent: {
    paddingHorizontal: theme.semanticSpacing.screenPadding,
    paddingTop: theme.semanticSpacing.lg,
    paddingBottom: theme.semanticSpacing.md,
  },
  
  headerTop: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    marginBottom: theme.semanticSpacing.md,
  },
  
  locationSelector: {
    marginBottom: theme.semanticSpacing.md,
  },
  
  locationContent: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: theme.semanticSpacing.xs,
  },
  
  locationText: {
    marginHorizontal: theme.semanticSpacing.xs,
  },
  
  cityDropdown: {
    marginBottom: theme.semanticSpacing.md,
    width: '100%',
    ...theme.shadows.md,
  },
  
  cityOption: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: theme.semanticSpacing.xs,
    paddingHorizontal: theme.semanticSpacing.xs,
    borderBottomWidth: 1,
    borderBottomColor: theme.colors.border.light,
  },
  
  priceNote: {
    marginTop: theme.semanticSpacing.sm,
    fontStyle: 'italic',
  },

  addressTooltip: {
    marginTop: theme.semanticSpacing.sm,
    backgroundColor: theme.colors.status.info + '15',
    borderLeftWidth: 3,
    borderLeftColor: theme.colors.primary.main,
  },

  tooltipHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: theme.semanticSpacing.xs,
  },

  tooltipTitleContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: theme.semanticSpacing.xs,
  },

  tooltipTitle: {
    marginLeft: theme.semanticSpacing.xs,
  },

  tooltipContent: {
    marginBottom: theme.semanticSpacing.xs,
  },

  tooltipButton: {
    marginTop: theme.semanticSpacing.xs,
    paddingTop: theme.semanticSpacing.xs,
    borderTopWidth: 1,
    borderTopColor: theme.colors.border.light,
  },

  activeBookingCard: {
    marginHorizontal: theme.semanticSpacing.screenPadding,
    marginTop: theme.semanticSpacing.md,
    marginBottom: theme.semanticSpacing.md,
    borderRadius: theme.borderRadius.lg,
    overflow: 'hidden',
    ...theme.shadows.md,
  },

  activeBookingGradient: {
    padding: theme.semanticSpacing.md,
  },

  activeBookingHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: theme.semanticSpacing.sm,
  },

  activeBookingIcon: {
    width: 32,
    height: 32,
    borderRadius: 16,
    backgroundColor: 'rgba(255, 255, 255, 0.2)',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: theme.semanticSpacing.sm,
  },

  activeBookingInfo: {
    flex: 1,
  },

  activeBookingTitle: {
    color: '#fff',
    opacity: 0.9,
    marginBottom: 2,
    fontSize: 11,
  },

  activeBookingService: {
    color: '#fff',
    fontWeight: '600',
    fontSize: 15,
  },

  activeBookingStatus: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: theme.semanticSpacing.sm,
  },

  statusBadge: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: 'rgba(255, 255, 255, 0.2)',
    paddingHorizontal: 10,
    paddingVertical: 4,
    borderRadius: 16,
  },

  statusDot: {
    width: 6,
    height: 6,
    borderRadius: 3,
    backgroundColor: '#4CAF50',
    marginRight: 4,
  },

  statusText: {
    color: '#fff',
    fontSize: 11,
    fontWeight: '600',
  },

  heroInfo: {
    flexDirection: 'row',
    alignItems: 'center',
  },

  heroName: {
    color: '#fff',
    fontSize: 11,
    opacity: 0.9,
  },

  activeBookingFooter: {
    borderTopWidth: 1,
    borderTopColor: 'rgba(255, 255, 255, 0.15)',
    paddingTop: theme.semanticSpacing.xs,
    marginTop: theme.semanticSpacing.xs,
  },

  viewDetailsText: {
    color: '#fff',
    textAlign: 'center',
    opacity: 0.85,
    fontSize: 11,
  },
  
  greeting: {
    opacity: 0.9,
  },
  
  headerActions: {
    flexDirection: 'row',
    gap: theme.semanticSpacing.sm,
  },
  
  headerButton: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: theme.colors.neutral[100],
    justifyContent: 'center',
    alignItems: 'center',
    ...theme.shadows.sm,
  },
  
  subtitle: {
    opacity: 0.9,
  },
  
  scrollView: {
    flex: 1,
  },
  
  scrollContent: {
    paddingBottom: theme.semanticSpacing.xl,
  },
  
  searchContainer: {
    paddingHorizontal: theme.semanticSpacing.screenPadding,
    marginBottom: theme.semanticSpacing.xl,
  },
  
  searchCard: {
    borderRadius: theme.borderRadius.xl,
    ...theme.shadows.md,
  },
  
  searchInput: {
    marginBottom: 0,
  },
  
  searchInputField: {
    backgroundColor: 'transparent',
  },
  
  categoriesContainer: {
    paddingHorizontal: theme.semanticSpacing.screenPadding,
    marginBottom: theme.semanticSpacing['2xl'],
  },
  
  sectionTitle: {
    marginBottom: theme.semanticSpacing.md,
  },
  
  categoriesGrid: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  
  categoryCard: {
    width: (screenWidth - theme.semanticSpacing.screenPadding * 2 - theme.semanticSpacing.md) / 2,
    marginBottom: theme.semanticSpacing.md,
  },
  
  categoryCardInner: {
    overflow: 'hidden',
    borderRadius: theme.borderRadius.lg,
  },
  
  categoryImageContainer: {
    position: 'relative',
    height: 100,
    width: '100%',
  },
  
  categoryImage: {
    width: '100%',
    height: '100%',
  },
  
  categoryOverlay: {
    position: 'absolute',
    top: theme.semanticSpacing.sm,
    right: theme.semanticSpacing.sm,
  },
  
  categoryIconContainer: {
    width: 36,
    height: 36,
    borderRadius: 18,
    justifyContent: 'center',
    alignItems: 'center',
    ...theme.shadows.sm,
  },
  
  categoryContent: {
    padding: theme.semanticSpacing.sm,
    alignItems: 'center',
    minHeight: 60,
    justifyContent: 'center',
  },
  
  categoryName: {
    marginBottom: theme.semanticSpacing.xs,
    textAlign: 'center',
  },
  
  categoryDescription: {
    textAlign: 'center',
    lineHeight: 16,
  },
  
  quickActionsContainer: {
    paddingHorizontal: theme.semanticSpacing.screenPadding,
  },
  
  quickActionsRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    gap: theme.semanticSpacing.sm,
  },
  
  quickActionCard: {
    flex: 1,
    alignItems: 'center',
    minHeight: 100,
  },
  
  quickActionIcon: {
    marginBottom: theme.semanticSpacing.xs,
  },
});
