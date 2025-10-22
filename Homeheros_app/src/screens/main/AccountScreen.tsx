import React, { useState, useEffect } from 'react';
import {
  View,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Switch,
  Alert,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { StatusBar } from 'expo-status-bar';
import { Ionicons } from '@expo/vector-icons';
import { Typography, Card, Button } from '../../components/ui';
import { theme } from '../../theme';
import { useAuth } from '../../contexts/AuthContext';
import { supabase } from '../../lib/supabase';

interface MenuItem {
  id: string;
  title: string;
  icon: keyof typeof Ionicons.glyphMap;
  action: () => void;
  showChevron?: boolean;
  badge?: string;
}

interface AccountScreenProps {
  navigation: any;
}

export const AccountScreen: React.FC<AccountScreenProps> = ({ navigation }) => {
  const { user, profile, signOut } = useAuth();
  const [notificationsEnabled, setNotificationsEnabled] = useState(true);
  const [activeBookingsCount, setActiveBookingsCount] = useState<number>(0);
  const [loadingBookings, setLoadingBookings] = useState(true);
  
  // Fetch active bookings count when screen is focused
  useEffect(() => {
    const unsubscribe = navigation.addListener('focus', () => {
      fetchActiveBookingsCount();
    });
    
    // Initial fetch
    fetchActiveBookingsCount();
    
    return unsubscribe;
  }, [navigation]);
  
  const fetchActiveBookingsCount = async () => {
    if (!user?.id) return;
    
    try {
      setLoadingBookings(true);
      
      // Get count of active bookings using a simpler query
      console.log('Fetching active bookings for user:', user.id);
      
      // First, try a simple query to get all bookings for this user
      const { data, error: fetchError } = await supabase
        .from('bookings')
        .select('id, status')
        .eq('customer_id', user.id);
      
      if (fetchError) {
        console.error('Error fetching bookings:', fetchError);
        return;
      }
      
      console.log('Total bookings found:', data?.length || 0);
      
      // Filter active bookings client-side
      const activeBookings = data?.filter(booking => 
        booking.status !== 'completed' && 
        booking.status !== 'cancelled'
      ) || [];
      
      console.log('Active bookings count:', activeBookings.length);
      setActiveBookingsCount(activeBookings.length);
    } catch (error) {
      console.error('Error in fetchActiveBookingsCount:', error);
    } finally {
      setLoadingBookings(false);
    }
  };

  const handleSignOut = () => {
    Alert.alert(
      'Sign Out',
      'Are you sure you want to sign out?',
      [
        { text: 'Cancel', style: 'cancel' },
        { 
          text: 'Sign Out', 
          style: 'destructive',
          onPress: async () => {
            await signOut();
          }
        }
      ]
    );
  };

  const handleProfile = () => {
    // Navigate to profile screen
    navigation.navigate('Profile');
  };

  const handlePaymentMethods = () => {
    // Navigate to payment methods screen
    console.log('Payment methods');
  };

  const handleBookingHistory = () => {
    // Navigate to booking history screen
    navigation.navigate('BookingHistory');
  };

  const handleAddresses = () => {
    // Navigate to addresses screen
    navigation.navigate('SavedAddresses');
  };

  const handleHelp = () => {
    // Navigate to help center
    console.log('Help center');
  };

  const handleAbout = () => {
    // Navigate to about screen
    console.log('About');
  };

  const accountMenuItems: MenuItem[] = [
    {
      id: 'profile',
      title: 'Edit Profile',
      icon: 'person-outline',
      action: handleProfile,
      showChevron: true,
    },
    {
      id: 'payment',
      title: 'Payment Methods',
      icon: 'card-outline',
      action: handlePaymentMethods,
      showChevron: true,
    },
    {
      id: 'bookings',
      title: 'Booking History',
      icon: 'calendar-outline',
      action: handleBookingHistory,
      showChevron: true,
      badge: activeBookingsCount > 0 ? `${activeBookingsCount}` : undefined, // Will show badge only if count > 0
    },
    {
      id: 'addresses',
      title: 'Saved Addresses',
      icon: 'location-outline',
      action: handleAddresses,
      showChevron: true,
    },
  ];

  const supportMenuItems: MenuItem[] = [
    {
      id: 'help',
      title: 'Help Center',
      icon: 'help-circle-outline',
      action: handleHelp,
      showChevron: true,
    },
    {
      id: 'about',
      title: 'About HomeHeros',
      icon: 'information-circle-outline',
      action: handleAbout,
      showChevron: true,
    },
  ];

  const renderMenuItem = (item: MenuItem) => (
    <TouchableOpacity
      key={item.id}
      style={styles.menuItem}
      onPress={item.action}
      activeOpacity={0.7}
    >
      <View style={styles.menuItemLeft}>
        <View style={styles.menuItemIcon}>
          <Ionicons name={item.icon} size={22} color={theme.colors.primary.main} />
        </View>
        <Typography variant="body1">{item.title}</Typography>
      </View>
      
      <View style={styles.menuItemRight}>
        {item.badge && (
          <View style={styles.badge}>
            <Typography variant="caption" color="inverse">
              {item.badge}
            </Typography>
          </View>
        )}
        {item.showChevron && (
          <Ionicons name="chevron-forward" size={20} color={theme.colors.text.secondary} />
        )}
      </View>
    </TouchableOpacity>
  );

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar style="dark" backgroundColor={theme.colors.background.primary} />
      
      {/* Header */}
      <View style={styles.header}>
        <Typography variant="h4" weight="semibold">
          Account
        </Typography>
      </View>
      
      <ScrollView 
        style={styles.scrollView}
        contentContainerStyle={styles.scrollContent}
        showsVerticalScrollIndicator={false}
      >
        {/* Profile Card */}
        <Card variant="default" padding="md" style={styles.profileCard}>
          <View style={styles.profileContent}>
            <View style={styles.profileAvatar}>
              <Typography variant="h3" color="inverse" weight="semibold">
                {profile?.name?.charAt(0) || user?.email?.charAt(0)?.toUpperCase() || 'U'}
              </Typography>
            </View>
            <View style={styles.profileInfo}>
              <Typography variant="h5" weight="semibold">
                {profile?.name || user?.email?.split('@')[0] || 'User'}
              </Typography>
              <Typography variant="body2" color="secondary">
                {user?.email || 'No email provided'}
              </Typography>
            </View>
          </View>
        </Card>
        
        {/* Account Settings */}
        <View style={styles.sectionHeader}>
          <Typography variant="h6" weight="semibold">
            Account Settings
          </Typography>
        </View>
        
        <Card variant="default" padding="none" style={styles.menuCard}>
          {accountMenuItems.map(renderMenuItem)}
        </Card>
        
        {/* Notifications */}
        <View style={styles.sectionHeader}>
          <Typography variant="h6" weight="semibold">
            Notifications
          </Typography>
        </View>
        
        <Card variant="default" padding="none" style={styles.menuCard}>
          <View style={styles.menuItem}>
            <View style={styles.menuItemLeft}>
              <View style={styles.menuItemIcon}>
                <Ionicons name="notifications-outline" size={22} color={theme.colors.primary.main} />
              </View>
              <Typography variant="body1">Push Notifications</Typography>
            </View>
            
            <Switch
              value={notificationsEnabled}
              onValueChange={setNotificationsEnabled}
              trackColor={{ false: theme.colors.neutral[300], true: `${theme.colors.primary.main}80` }}
              thumbColor={notificationsEnabled ? theme.colors.primary.main : theme.colors.neutral[100]}
            />
          </View>
        </Card>
        
        {/* Support */}
        <View style={styles.sectionHeader}>
          <Typography variant="h6" weight="semibold">
            Support
          </Typography>
        </View>
        
        <Card variant="default" padding="none" style={styles.menuCard}>
          {supportMenuItems.map(renderMenuItem)}
        </Card>
        
        {/* Sign Out Button */}
        <Button
          title="Sign Out"
          variant="outline"
          onPress={handleSignOut}
          style={styles.signOutButton}
          fullWidth
        />
        
        {/* App Version */}
        <View style={styles.versionContainer}>
          <Typography variant="caption" color="secondary" align="center">
            HomeHeros v1.0.0
          </Typography>
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
    paddingHorizontal: theme.semanticSpacing.screenPadding,
    paddingVertical: theme.semanticSpacing.md,
    borderBottomWidth: 1,
    borderBottomColor: theme.colors.border.light,
  },
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    padding: theme.semanticSpacing.screenPadding,
    paddingBottom: theme.semanticSpacing.xl,
  },
  profileCard: {
    marginBottom: theme.semanticSpacing.lg,
    ...theme.shadows.sm,
  },
  profileContent: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  profileAvatar: {
    width: 60,
    height: 60,
    borderRadius: 30,
    backgroundColor: theme.colors.primary.main,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: theme.semanticSpacing.md,
  },
  profileInfo: {
    flex: 1,
  },
  sectionHeader: {
    marginBottom: theme.semanticSpacing.sm,
    marginTop: theme.semanticSpacing.lg,
  },
  menuCard: {
    overflow: 'hidden',
    ...theme.shadows.sm,
  },
  menuItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: theme.semanticSpacing.md,
    paddingHorizontal: theme.semanticSpacing.md,
    borderBottomWidth: 1,
    borderBottomColor: theme.colors.border.light,
  },
  menuItemLeft: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  menuItemIcon: {
    width: 36,
    height: 36,
    borderRadius: 18,
    backgroundColor: `${theme.colors.primary.main}15`,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: theme.semanticSpacing.sm,
  },
  menuItemRight: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  badge: {
    backgroundColor: theme.colors.status.success,
    paddingHorizontal: theme.semanticSpacing.xs,
    paddingVertical: 2,
    borderRadius: 10,
    marginRight: theme.semanticSpacing.xs,
  },
  signOutButton: {
    marginTop: theme.semanticSpacing.xl,
  },
  versionContainer: {
    marginTop: theme.semanticSpacing.md,
  },
});
