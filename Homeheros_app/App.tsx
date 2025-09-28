import React from 'react';
import { StatusBar } from 'expo-status-bar';
import { AuthProvider } from './src/contexts/AuthContext';
import { LocationProvider } from './src/contexts/LocationContext';
import { AppNavigator } from './src/navigation/AppNavigator';

export default function App() {
  return (
    <AuthProvider>
      <LocationProvider>
        <AppNavigator />
        <StatusBar style="auto" />
      </LocationProvider>
    </AuthProvider>
  );
}

