import React from 'react';
import { View, Text, ActivityIndicator, StyleSheet, TouchableOpacity } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import { navigationRef } from './navigationRef';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { Ionicons } from '@expo/vector-icons';
import { useAuth } from '../contexts/AuthContext';
import { UserRole } from '../lib/supabase';
import AuthNavigator from './AuthNavigator';
import MainNavigator from './MainNavigator';

const Stack = createNativeStackNavigator();

const LoadingScreen = () => (
  <View style={styles.loadingContainer}>
    <ActivityIndicator size="large" color="#FF6B35" />
    <Text style={styles.loadingText}>Loading HomeHeros GO...</Text>
  </View>
);

const RoleErrorScreen = ({ onSignOut }: { onSignOut: () => void }) => (
  <View style={styles.errorContainer}>
    <Ionicons name="alert-circle" size={80} color="#FF6B35" />
    <Text style={styles.errorTitle}>Access Restricted</Text>
    <Text style={styles.errorText}>
      This app is for service providers (Heroes) only.
    </Text>
    <Text style={styles.errorSubtext}>
      Please use the HomeHeros customer app instead, or sign in with a Hero account.
    </Text>
    <TouchableOpacity style={styles.signOutButton} onPress={onSignOut}>
      <Text style={styles.signOutButtonText}>Sign Out</Text>
    </TouchableOpacity>
  </View>
);

const AppNavigator = () => {
  const { user, profile, loading, signOut } = useAuth();

  if (loading) {
    return <LoadingScreen />;
  }

  // Check if user is logged in but not a hero
  if (user && profile && profile.role !== UserRole.HERO) {
    return <RoleErrorScreen onSignOut={signOut} />;
  }

  return (
    <NavigationContainer ref={navigationRef}>
      {user ? <MainNavigator /> : <AuthNavigator />}
    </NavigationContainer>
  );
};

const styles = StyleSheet.create({
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#fff',
  },
  loadingText: {
    marginTop: 16,
    fontSize: 16,
    color: '#666',
  },
  errorContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#fff',
    padding: 20,
  },
  errorTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
    marginTop: 20,
    marginBottom: 12,
  },
  errorText: {
    fontSize: 16,
    color: '#666',
    textAlign: 'center',
    marginBottom: 8,
  },
  errorSubtext: {
    fontSize: 14,
    color: '#999',
    textAlign: 'center',
    marginBottom: 30,
    paddingHorizontal: 20,
  },
  signOutButton: {
    backgroundColor: '#FF6B35',
    paddingHorizontal: 32,
    paddingVertical: 12,
    borderRadius: 8,
  },
  signOutButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '600',
  },
});

export default AppNavigator;
