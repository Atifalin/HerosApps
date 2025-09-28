import React, { useState } from 'react';
import {
  View,
  StyleSheet,
  ScrollView,
  StatusBar,
  TouchableOpacity,
  Dimensions,
  Image,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { LinearGradient } from 'expo-linear-gradient';
import { Ionicons } from '@expo/vector-icons';
import { Button, Typography, Card, Input } from '../../components/ui';
import { useAuth } from '../../contexts/AuthContext';
import { useLocation } from '../../contexts/LocationContext';
import { theme } from '../../theme';

const { width: screenWidth } = Dimensions.get('window');

interface SubCategory {
  id: string;
  name: string;
  description: string;
  price?: string;
  icon?: keyof typeof Ionicons.glyphMap;
}

interface ServiceCategory {
  id: string;
  name: string;
  icon: keyof typeof Ionicons.glyphMap;
  color: string;
  description: string;
  image: any; // Local image require() returns any type
  subcategories: SubCategory[];
}

const serviceCategories: ServiceCategory[] = [
  {
    id: '1',
    name: 'Maid Services',
    icon: 'home-outline',
    color: theme.colors.primary.main,
    description: 'Professional Cleaning',
    image: require('../../../assets/Services_images/cleaning.png'),
    subcategories: [
      {
        id: '1-1',
        name: 'Deep Cleaning',
        description: 'Complete home cleaning service',
        price: 'From $250'
      },
      {
        id: '1-2',
        name: 'Add-ons',
        description: 'Fridge, Oven, Patio Cleaning',
        price: '$50 extra'
      },
      {
        id: '1-3',
        name: 'Swimming Pool',
        description: 'Pool cleaning service',
        price: '$500'
      },
      {
        id: '1-4',
        name: 'Garage',
        description: '2 Car Garage cleaning',
        price: '$75'
      }
    ]
  },
  {
    id: '2',
    name: 'Cooks & Chefs',
    icon: 'restaurant-outline',
    color: '#FF6B35',
    description: 'Personal Chef Services',
    image: require('../../../assets/Services_images/cooking.png'),
    subcategories: [
      {
        id: '2-1',
        name: 'Home Cooking',
        description: 'Daily meals tailored to your taste & diet',
        price: '$75/hour'
      },
      {
        id: '2-2',
        name: 'Grocery Shopping',
        description: 'Shopping for ingredients',
        price: '$60 + food cost'
      },
      {
        id: '2-3',
        name: 'Event Catering',
        description: 'Elegant meals for special occasions',
        price: 'Custom packages'
      }
    ]
  },
  {
    id: '3',
    name: 'Event Planning',
    icon: 'calendar-outline',
    color: '#6C5CE7',
    description: 'Complete Event Management',
    image: require('../../../assets/Services_images/event.png'),
    subcategories: [
      {
        id: '3-1',
        name: 'Corporate Events',
        description: 'Conferences, Team-Building, Product Launches',
        price: 'Custom packages'
      },
      {
        id: '3-2',
        name: 'Weddings & Engagements',
        description: 'Full-scale planning & coordination',
        price: 'Custom packages'
      },
      {
        id: '3-3',
        name: 'Social Celebrations',
        description: 'Birthdays, Anniversaries, Baby Showers',
        price: 'Custom packages'
      }
    ]
  },
  {
    id: '4',
    name: 'Travel Services',
    icon: 'airplane-outline',
    color: '#00B894',
    description: 'Tour Guides & Travel',
    image: require('../../../assets/Services_images/travel.png'),
    subcategories: [
      {
        id: '4-1',
        name: 'Personalized Local Tours',
        description: 'Wine tours, adventure hikes, cultural spots',
        price: 'Custom packages'
      },
      {
        id: '4-2',
        name: 'Luxury & Wellness Getaways',
        description: 'Spa weekends, romantic retreats, cabin escapes',
        price: 'Custom packages'
      },
      {
        id: '4-3',
        name: 'Group & Corporate Travel',
        description: 'Team retreats, family reunions, friend trips',
        price: 'Custom packages'
      },
      {
        id: '4-4',
        name: 'Airport Pickups & Day Trips',
        description: 'Stress-free travel with curated stops',
        price: 'Custom packages'
      }
    ]
  },
  {
    id: '5',
    name: 'Handymen',
    icon: 'build-outline',
    color: '#FDCB6E',
    description: 'Home Improvements',
    image: require('../../../assets/Services_images/handyman.png'),
    subcategories: [
      {
        id: '5-1',
        name: 'Repairs & Installs',
        description: 'Fixtures, furniture assembly, shelves',
        price: '$65 call out fee'
      },
      {
        id: '5-2',
        name: 'Electrical',
        description: 'Switches, fans, lighting, smart home',
        price: '$65 call out fee'
      },
      {
        id: '5-3',
        name: 'Plumbing',
        description: 'Drains, toilet repairs, shower fittings',
        price: '$65 call out fee'
      },
      {
        id: '5-4',
        name: 'Moving Services',
        description: 'Local moves, packing & unpacking',
        price: 'From $100/hour'
      }
    ]
  },
  {
    id: '6',
    name: 'Auto Services',
    icon: 'car-outline',
    color: '#E84393',
    description: 'Repair & Detailing',
    image: require('../../../assets/Services_images/auto.png'),
    subcategories: [
      {
        id: '6-1',
        name: 'Auto Repair',
        description: 'Battery, brakes, oil changes, diagnostics',
        price: '$150 call out fee'
      },
      {
        id: '6-2',
        name: 'Auto Detailing',
        description: 'Interior cleaning, exterior wash, wax',
        price: 'Custom quotes'
      }
    ]
  },
  {
    id: '7',
    name: 'Personal Care',
    icon: 'flower-outline',
    color: '#A29BFE',
    description: 'Massage & Salon at Home',
    image: require('../../../assets/Services_images/personalcare.png'),
    subcategories: [
      {
        id: '7-1',
        name: 'Massage Therapy',
        description: 'Swedish, Deep Tissue, Prenatal & Relaxation',
        price: '$60 call out fee + service'
      },
      {
        id: '7-2',
        name: 'Spa Services',
        description: 'Facials, manicures, pedicures, body treatments',
        price: 'From $50'
      },
      {
        id: '7-3',
        name: 'Salon Services',
        description: 'Haircuts, styling, color, beard trims',
        price: 'From $50'
      }
    ]
  },
];

interface HomeScreenProps {
  navigation: any;
}

export const HomeScreen: React.FC<HomeScreenProps> = ({ navigation }) => {
  const { user, profile, signOut } = useAuth();
  const { currentCity, loading: locationLoading, setCity, supportedCities } = useLocation();
  const [showCitySelector, setShowCitySelector] = useState(false);

  const handleServicePress = (service: ServiceCategory) => {
    // Navigate to service detail screen
    navigation.navigate('ServiceDetail', { service });
  };

  const handleSearchPress = () => {
    // Navigate to search screen
    navigation.navigate('Search');
  };

  const handleProfilePress = () => {
    // Navigate to profile screen
    console.log('Profile pressed');
  };

  const handleNotificationPress = () => {
    // Navigate to notifications
    console.log('Notifications pressed');
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
        {serviceCategories.map((service) => (
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
                      name={service.icon}
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

  const renderQuickActions = () => (
    <View style={styles.quickActionsContainer}>
      <Typography variant="h5" weight="semibold" style={styles.sectionTitle}>
        Quick Actions
      </Typography>
      
      <View style={styles.quickActionsRow}>
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
