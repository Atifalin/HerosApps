import React, { createContext, useContext, useEffect, useState } from 'react';
import { Session, User } from '@supabase/supabase-js';
import { supabase, UserProfile } from '../lib/supabase';
import { testSupabaseConnection } from '../utils/testSupabase';
import { testNetworkConnectivity } from '../utils/networkTest';
import { debugSupabaseSetup } from '../utils/debugSupabase';
import { navigate } from '../navigation/navigationRef';
import { subscribeToAuthDeepLinks } from '../lib/deepLinkHandler';
import { isRecoveryActive } from '../lib/authRecoveryState';

interface AuthContextType {
  user: User | null;
  profile: UserProfile | null;
  session: Session | null;
  loading: boolean;
  signUp: (email: string, password: string) => Promise<{ error?: any; needsConfirmation?: boolean; user?: User }>;
  signIn: (email: string, password: string) => Promise<{ error: any }>;
  signOut: () => Promise<{ error: any }>;
  resetPassword: (email: string) => Promise<{ error: any }>;
  updateProfile: (updates: Partial<UserProfile>) => Promise<{ error: any }>;
}

const AuthContext = createContext<AuthContextType | undefined>(undefined);

export const useAuth = () => {
  const context = useContext(AuthContext);
  if (context === undefined) {
    throw new Error('useAuth must be used within an AuthProvider');
  }
  return context;
};

interface AuthProviderProps {
  children: React.ReactNode;
}

export const AuthProvider: React.FC<AuthProviderProps> = ({ children }) => {
  const [user, setUser] = useState<User | null>(null);
  const [profile, setProfile] = useState<UserProfile | null>(null);
  const [session, setSession] = useState<Session | null>(null);
  const [loading, setLoading] = useState(true);

  const fetchProfile = async (userId: string) => {
    try {
      const { data, error } = await supabase
        .from('profiles')
        .select('*')
        .eq('id', userId)
        .single();
      
      if (error) {
        console.error('Error fetching profile:', error);
        return null;
      }
      
      return data as UserProfile;
    } catch (error) {
      console.error('Error fetching profile:', error);
      return null;
    }
  };

  useEffect(() => {
    // Debug Supabase setup
    debugSupabaseSetup();
    
    // Test network connectivity first
    testNetworkConnectivity();
    
    // Test Supabase connection
    testSupabaseConnection();
    
    // Get initial session
    supabase.auth.getSession().then(async ({ data: { session }, error }) => {
      // Handle invalid refresh token error
      if (error) {
        console.warn('⚠️ Session error:', error.message);
        if (error.message.includes('refresh_token_not_found') || 
            error.message.includes('Invalid Refresh Token')) {
          console.log('🧹 Clearing invalid session...');
          await supabase.auth.signOut();
        }
      }
      
      setSession(session);
      setUser(session?.user ?? null);
      
      if (session?.user) {
        const userProfile = await fetchProfile(session.user.id);
        setProfile(userProfile);
      }
      
      setLoading(false);
    }).catch(async (err) => {
      console.error('❌ Session initialization error:', err);
      // Clear any corrupted session
      await supabase.auth.signOut();
      setLoading(false);
    });

    // Listen for auth changes
    const {
      data: { subscription },
    } = supabase.auth.onAuthStateChange(async (event, session) => {
      console.log('🔄 Auth state changed:', event, session?.user?.email);
      
      // Handle password recovery from email deep link
      // NOTE: We intentionally do NOT set user state here, so the app stays in
      // the unauthenticated stack where ResetPassword screen lives. The Supabase
      // client still has the recovery session internally, so updateUser() will work.
      if (event === 'PASSWORD_RECOVERY') {
        console.log('🔐 PASSWORD_RECOVERY event - navigating to ResetPassword');
        setLoading(false);
        setTimeout(() => navigate('ResetPassword'), 100);
        return;
      }

      // If we're in the middle of a password recovery flow, Supabase often
      // fires SIGNED_IN (instead of PASSWORD_RECOVERY) after setSession. In
      // that case, ignore the session so the user doesn't get logged in.
      if (isRecoveryActive() && (event === 'SIGNED_IN' || event === 'TOKEN_REFRESHED' || event === 'INITIAL_SESSION')) {
        console.log('🔐 Recovery active - ignoring', event, 'to keep ResetPassword reachable');
        setLoading(false);
        return;
      }
      
      setSession(session);
      setUser(session?.user ?? null);
      
      if (session?.user) {
        console.log('👤 User signed in, fetching profile...');
        const userProfile = await fetchProfile(session.user.id);
        setProfile(userProfile);
        console.log('✅ Profile loaded:', userProfile?.email);
      } else {
        console.log('👋 User signed out');
        setProfile(null);
      }
      
      setLoading(false);
    });

    // Subscribe to incoming auth deep links (password reset, email confirmation)
    const unsubscribeDeepLinks = subscribeToAuthDeepLinks();

    return () => {
      subscription.unsubscribe();
      unsubscribeDeepLinks();
    };
  }, []);

  const signUp = async (email: string, password: string) => {
    try {
      console.log('Attempting signup with:', email);
      console.log('Supabase URL:', process.env.EXPO_PUBLIC_SUPABASE_URL);
      console.log('API Key length:', process.env.EXPO_PUBLIC_SUPABASE_KEY?.length);
      
      const { data, error } = await supabase.auth.signUp({
        email,
        password,
      });
      
      if (error) {
        console.error('Signup error details:', {
          message: error.message,
          status: error.status,
          name: error.name,
        });
        
        // If user already exists, suggest signing in instead
        if (error.message?.toLowerCase().includes('already') || 
            error.message?.toLowerCase().includes('exists')) {
          return { 
            error: { 
              ...error, 
              message: 'An account with this email already exists. Please sign in instead.' 
            } 
          };
        }
        
        return { error };
      }
      
      // Check if user was created but no session (unconfirmed email)
      if (data.user && !data.session) {
        console.log('✅ User created, email confirmation required');
        return { 
          needsConfirmation: true,
          user: data.user
        };
      }
      
      // Ensure profile is created (fallback if trigger doesn't work)
      if (data.user && data.session) {
        console.log('Checking if profile exists for user:', data.user.id);
        
        // Wait a moment for the trigger to complete
        await new Promise(resolve => setTimeout(resolve, 1000));
        
        // Check if profile was created by trigger
        const existingProfile = await fetchProfile(data.user.id);
        
        if (!existingProfile) {
          console.warn('Profile not found, creating manually...');
          
          // Create profile manually as fallback
          const { error: profileError } = await supabase
            .from('profiles')
            .insert({
              id: data.user.id,
              email: data.user.email,
              name: data.user.email?.split('@')[0] || 'User',
              role: 'customer',
              status: 'active',
            });
          
          if (profileError) {
            console.error('Failed to create profile:', profileError);
            // Don't fail the signup, but log the error
            // The user can still use the app, profile will be created on next login
          } else {
            console.log('Profile created successfully via fallback');
          }
        } else {
          console.log('Profile already exists (created by trigger)');
        }
      }
      
      console.log('Signup successful:', {
        user: data.user?.id,
        session: data.session?.access_token ? 'present' : 'null',
      });
      return { error: null };
    } catch (err) {
      console.error('Unexpected signup error:', err);
      return { error: err };
    }
  };

  const signIn = async (email: string, password: string) => {
    try {
      console.log('Attempting sign in with:', email);
      
      const { data, error } = await supabase.auth.signInWithPassword({
        email,
        password,
      });
      
      if (error) {
        console.error('Sign in error:', {
          message: error.message,
          status: error.status,
        });
        
        // Provide more helpful error messages
        if (error.message?.toLowerCase().includes('invalid') || 
            error.message?.toLowerCase().includes('credentials')) {
          return { 
            error: { 
              ...error, 
              message: 'Invalid email or password. Please try again.' 
            } 
          };
        }
        
        if (error.message?.toLowerCase().includes('email not confirmed')) {
          return { 
            error: { 
              ...error, 
              message: 'Please verify your email address before signing in. Check your inbox for the confirmation link.' 
            } 
          };
        }
        
        return { error };
      }
      
      // Check if sign in succeeded but no session was created
      if (!data.session && !error) {
        console.error('Sign in returned no error but also no session');
        return { 
          error: { 
            message: 'Unable to sign in. Your account may need email verification. Please contact support.' 
          } 
        };
      }
      
      console.log('Sign in successful:', {
        user: data.user?.id,
        session: data.session?.access_token ? 'present' : 'null',
      });
      
      return { error: null };
    } catch (err) {
      console.error('Unexpected sign in error:', err);
      return { 
        error: { 
          message: 'An unexpected error occurred. Please check your internet connection and try again.' 
        } 
      };
    }
  };

  const signOut = async () => {
    const { error } = await supabase.auth.signOut();
    return { error };
  };

  const resetPassword = async (email: string) => {
    const { error } = await supabase.auth.resetPasswordForEmail(email);
    return { error };
  };

  const updateProfile = async (updates: Partial<UserProfile>) => {
    if (!user) {
      return { error: new Error('No user logged in') };
    }

    try {
      const { error } = await supabase
        .from('profiles')
        .update(updates)
        .eq('id', user.id);

      if (error) {
        return { error };
      }

      // Refresh profile data
      const updatedProfile = await fetchProfile(user.id);
      setProfile(updatedProfile);

      return { error: null };
    } catch (error) {
      return { error };
    }
  };

  const value: AuthContextType = {
    user,
    profile,
    session,
    loading,
    signUp,
    signIn,
    signOut,
    resetPassword,
    updateProfile,
  };

  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  );
};
