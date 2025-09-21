// Shared Supabase configuration for all HomeHeros apps
export const SUPABASE_CONFIG = {
  url: 'https://vttzuaerdwagipyocpha.supabase.co',
  anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ0dHp1YWVyZHdhZ2lweW9jcGhhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg0Nzc1NDMsImV4cCI6MjA3NDA1MzU0M30.-QyK-_-jrVowVoMFy8IpCeVaeP59VNUCZtRmTD6Pfwc',
};

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
