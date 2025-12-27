import React, { useState, useEffect, ComponentType } from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { Ionicons } from '@expo/vector-icons';
import { useAuth } from '../contexts/AuthContext';
import { OnboardingScreen } from '../screens/onboarding/OnboardingScreen';
import { LoginScreen } from '../screens/auth/LoginScreen';
import { SignUpScreen } from '../screens/auth/SignUpScreen';
import { HomeScreen } from '../screens/main/HomeScreen';
import { PromosScreen } from '../screens/main/PromosScreen';
import { AccountScreen } from '../screens/main/AccountScreen';
import { SearchScreen } from '../screens/main/SearchScreen';
import { ServiceDetailScreen } from '../screens/services/ServiceDetailScreen';
import { BookingScreen } from '../screens/booking/BookingScreen';
import { BookingConfirmScreen } from '../screens/booking/BookingConfirmScreen';
import { BookingStatusScreen } from '../screens/booking/BookingStatusScreen';
import { BookingHistoryScreen } from '../screens/account/BookingHistoryScreen';
import { SavedAddressesScreen } from '../screens/account/SavedAddressesScreen';
import { ProfileScreen } from '../screens/account/ProfileScreen';
import { SupportScreen } from '../screens/support/SupportScreen';
import { ChatScreen } from '../screens/support/ChatScreen';
import { theme } from '../theme';

const Stack = createNativeStackNavigator();
const Tab = createBottomTabNavigator();

// Main Tab Navigator
const MainTabNavigator = () => {
  return (
    <Tab.Navigator
      screenOptions={({ route }) => ({
        headerShown: false,
        tabBarIcon: ({ focused, color, size }) => {
          let iconName: keyof typeof Ionicons.glyphMap = 'home';

          if (route.name === 'HomeTab') {
            iconName = focused ? 'home' : 'home-outline';
          } else if (route.name === 'PromosTab') {
            iconName = focused ? 'pricetag' : 'pricetag-outline';
          } else if (route.name === 'AccountTab') {
            iconName = focused ? 'person' : 'person-outline';
          }

          return <Ionicons name={iconName} size={size} color={color} />;
        },
        tabBarActiveTintColor: theme.colors.primary.main,
        tabBarInactiveTintColor: theme.colors.text.secondary,
        tabBarStyle: {
          borderTopWidth: 1,
          borderTopColor: theme.colors.border.light,
          elevation: 0,
          shadowOpacity: 0,
          height: 60,
          paddingBottom: 8,
          paddingTop: 8,
        },
        tabBarLabelStyle: {
          fontSize: 12,
          fontWeight: '500',
        },
      })}
    >
      <Tab.Screen 
        name="HomeTab" 
        component={HomeScreen} 
        options={{ title: 'Home' }}
      />
      <Tab.Screen 
        name="PromosTab" 
        component={PromosScreen} 
        options={{ title: 'Promos' }}
      />
      <Tab.Screen 
        name="AccountTab" 
        component={AccountScreen} 
        options={{ title: 'Account' }}
      />
    </Tab.Navigator>
  );
};

// Main App Navigator
export const AppNavigator: React.FC = () => {
  const { user, loading } = useAuth();
  const [isFirstLaunch, setIsFirstLaunch] = useState<boolean | null>(null);

  // Debug: Log user state changes
  useEffect(() => {
    console.log('🧭 AppNavigator - User state:', user?.email || 'No user', 'Loading:', loading, 'First launch:', isFirstLaunch);
  }, [user, loading, isFirstLaunch]);

  useEffect(() => {
    const checkFirstLaunch = async () => {
      try {
        const hasLaunched = await AsyncStorage.getItem('hasLaunched');
        if (hasLaunched === null) {
          setIsFirstLaunch(true);
          await AsyncStorage.setItem('hasLaunched', 'true');
        } else {
          setIsFirstLaunch(false);
        }
      } catch (error) {
        console.error('Error checking first launch:', error);
        setIsFirstLaunch(false);
      }
    };

    checkFirstLaunch();
  }, []);

  if (loading || isFirstLaunch === null) {
    // You can add a loading screen here
    return null;
  }

  return (
    <NavigationContainer>
      <Stack.Navigator screenOptions={{ headerShown: false }}>
        {isFirstLaunch ? (
          // First time user - show onboarding
          <Stack.Screen name="Onboarding" component={OnboardingScreen} />
        ) : user ? (
          // User is signed in - show main app with tabs
          <Stack.Screen name="MainTabs" component={MainTabNavigator} />
        ) : (
          // User is not signed in - show auth screens
          <>
            <Stack.Screen name="Login" component={LoginScreen} />
            <Stack.Screen name="SignUp" component={SignUpScreen} />
          </>
        )}
        
        {/* Auth screens accessible from onboarding */}
        <Stack.Group screenOptions={{ presentation: 'modal' }}>
          <Stack.Screen name="Auth" component={LoginScreen} />
          <Stack.Screen name="AuthSignUp" component={SignUpScreen} />
        </Stack.Group>
        
        {/* Main app screens */}
        <Stack.Group>
          <Stack.Screen 
            name="ServiceDetail" 
            component={ServiceDetailScreen as React.ComponentType<any>} 
            options={{
              headerShown: false,
              animation: 'slide_from_right'
            }}
          />
          <Stack.Screen 
            name="Search" 
            component={SearchScreen} 
            options={{
              headerShown: false,
              animation: 'slide_from_bottom'
            }}
          />
          <Stack.Screen 
            name="Booking" 
            component={BookingScreen as React.ComponentType<any>} 
            options={{
              headerShown: false,
              animation: 'slide_from_right'
            }}
          />
          <Stack.Screen 
            name="BookingConfirm" 
            component={BookingConfirmScreen as React.ComponentType<any>} 
            options={{
              headerShown: false,
              animation: 'slide_from_right'
            }}
          />
          <Stack.Screen 
            name="BookingStatus" 
            component={BookingStatusScreen as React.ComponentType<any>} 
            options={{
              headerShown: false,
              animation: 'slide_from_right'
            }}
          />
          <Stack.Screen 
            name="BookingHistory" 
            component={BookingHistoryScreen as React.ComponentType<any>} 
            options={{
              headerShown: false,
              animation: 'slide_from_right'
            }}
          />
          <Stack.Screen 
            name="SavedAddresses" 
            component={SavedAddressesScreen as React.ComponentType<any>} 
            options={{
              headerShown: false,
              animation: 'slide_from_right'
            }}
          />
          <Stack.Screen 
            name="Profile" 
            component={ProfileScreen as React.ComponentType<any>} 
            options={{
              headerShown: false,
              animation: 'slide_from_right'
            }}
          />
          <Stack.Screen 
            name="Support" 
            component={SupportScreen as React.ComponentType<any>} 
            options={{
              headerShown: false,
              animation: 'slide_from_right'
            }}
          />
          <Stack.Screen 
            name="Chat" 
            component={ChatScreen as React.ComponentType<any>} 
            options={{
              headerShown: false,
              animation: 'slide_from_right'
            }}
          />
        </Stack.Group>
      </Stack.Navigator>
    </NavigationContainer>
  );
};
