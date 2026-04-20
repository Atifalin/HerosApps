import React from 'react';
import { StatusBar } from 'expo-status-bar';
import { StripeProvider } from '@stripe/stripe-react-native';
import { AuthProvider } from './src/contexts/AuthContext';
import { LocationProvider } from './src/contexts/LocationContext';
import { AppNavigator } from './src/navigation/AppNavigator';
import { STRIPE_CONFIG } from './src/config/stripe';

export default function App() {
  return (
    <StripeProvider
      publishableKey={STRIPE_CONFIG.publishableKey}
      merchantIdentifier={`merchant.com.homeheros.app`}
    >
      <AuthProvider>
        <LocationProvider>
          <AppNavigator />
          <StatusBar style="auto" />
        </LocationProvider>
      </AuthProvider>
    </StripeProvider>
  );
}

