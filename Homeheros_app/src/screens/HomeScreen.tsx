import React from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  StyleSheet,
  SafeAreaView,
} from 'react-native';
import { useAuth } from '../contexts/AuthContext';

export const HomeScreen: React.FC = () => {
  const { user, profile, signOut } = useAuth();

  const handleSignOut = async () => {
    await signOut();
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>Welcome to HomeHeros!</Text>
        <Text style={styles.subtitle}>
          Hello, {profile?.name || user?.email}
        </Text>
        {profile && (
          <Text style={styles.roleText}>
            Role: {profile.role}
          </Text>
        )}
      </View>

      <View style={styles.content}>
        <Text style={styles.sectionTitle}>Find Your Hero</Text>
        <Text style={styles.description}>
          Browse and book trusted service providers in your area.
        </Text>

        <View style={styles.categories}>
          <TouchableOpacity style={styles.categoryCard}>
            <Text style={styles.categoryTitle}>🏠 Cleaning</Text>
          </TouchableOpacity>
          
          <TouchableOpacity style={styles.categoryCard}>
            <Text style={styles.categoryTitle}>🔧 Handyman</Text>
          </TouchableOpacity>
          
          <TouchableOpacity style={styles.categoryCard}>
            <Text style={styles.categoryTitle}>📦 Moving</Text>
          </TouchableOpacity>
          
          <TouchableOpacity style={styles.categoryCard}>
            <Text style={styles.categoryTitle}>🚗 Auto Detailing</Text>
          </TouchableOpacity>
        </View>
      </View>

      <View style={styles.footer}>
        <TouchableOpacity style={styles.signOutButton} onPress={handleSignOut}>
          <Text style={styles.signOutText}>Sign Out</Text>
        </TouchableOpacity>
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
  },
  header: {
    padding: 20,
    alignItems: 'center',
    borderBottomWidth: 1,
    borderBottomColor: '#eee',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 8,
  },
  subtitle: {
    fontSize: 16,
    color: '#666',
  },
  roleText: {
    fontSize: 14,
    color: '#007AFF',
    fontWeight: '500',
    marginTop: 4,
  },
  content: {
    flex: 1,
    padding: 20,
  },
  sectionTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 8,
  },
  description: {
    fontSize: 16,
    color: '#666',
    marginBottom: 30,
  },
  categories: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  categoryCard: {
    width: '48%',
    backgroundColor: '#f8f9fa',
    borderRadius: 12,
    padding: 20,
    marginBottom: 16,
    alignItems: 'center',
    borderWidth: 1,
    borderColor: '#e9ecef',
  },
  categoryTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
  },
  footer: {
    padding: 20,
    borderTopWidth: 1,
    borderTopColor: '#eee',
  },
  signOutButton: {
    backgroundColor: '#dc3545',
    borderRadius: 8,
    padding: 16,
    alignItems: 'center',
  },
  signOutText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '600',
  },
});
