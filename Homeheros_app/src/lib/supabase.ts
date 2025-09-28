import 'react-native-url-polyfill/auto';
import { createClient } from '@supabase/supabase-js';
import * as SecureStore from 'expo-secure-store';

// Supabase configuration - using environment variables
const SUPABASE_URL = process.env.EXPO_PUBLIC_SUPABASE_URL || 'https://vttzuaerdwagipyocpha.supabase.co';
const SUPABASE_ANON_KEY = process.env.EXPO_PUBLIC_SUPABASE_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ0dHp1YWVyZHdhZ2lweW9jcGhhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg0Nzc1NDMsImV4cCI6MjA3NDA1MzU0M30.-QyK-_-jrVowVoMFy8IpCeVaeP59VNUCZtRmTD6Pfwc';

// User roles as defined in QRD
export enum UserRole {
  CUSTOMER = 'customer',
  HERO = 'hero',
  ADMIN = 'admin',
  CS = 'cs',
  FINANCE = 'finance',
  CONTRACTOR_MANAGER = 'contractor_manager',
}

// User profile type
export interface UserProfile {
  id: string;
  role: UserRole;
  name?: string;
  email?: string;
  phone?: string;
  status: string;
  created_at: string;
}

// SecureStore adapter for Supabase Auth
const ExpoSecureStoreAdapter = {
  getItem: (key: string) => {
    return SecureStore.getItemAsync(key);
  },
  setItem: (key: string, value: string) => {
    return SecureStore.setItemAsync(key, value);
  },
  removeItem: (key: string) => {
    return SecureStore.deleteItemAsync(key);
  },
};

// Initialize Supabase client with secure storage for session persistence
export const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
  auth: {
    autoRefreshToken: true,
    persistSession: true,
    detectSessionInUrl: false,
    storage: ExpoSecureStoreAdapter,
  },
});

// Log configuration for debugging
console.log('Supabase initialized with:');
console.log('URL:', SUPABASE_URL);
console.log('Key length:', SUPABASE_ANON_KEY.length);
