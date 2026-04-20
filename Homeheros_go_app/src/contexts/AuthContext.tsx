import React, { createContext, useContext, useEffect, useState } from 'react';
import { Session, User } from '@supabase/supabase-js';
import { supabase, UserProfile, HeroProfile, UserRole } from '../lib/supabase';
import { navigate } from '../navigation/navigationRef';
import { subscribeToAuthDeepLinks } from '../lib/deepLinkHandler';
import { isRecoveryActive } from '../lib/authRecoveryState';

interface AuthContextType {
  user: User | null;
  profile: UserProfile | null;
  heroProfile: HeroProfile | null;
  session: Session | null;
  loading: boolean;
  signUp: (email: string, password: string) => Promise<{ error: any }>;
  signIn: (email: string, password: string) => Promise<{ error: any }>;
  signOut: () => Promise<{ error: any }>;
  resetPassword: (email: string) => Promise<{ error: any }>;
  updateProfile: (updates: Partial<UserProfile>) => Promise<{ error: any }>;
  updateHeroProfile: (updates: Partial<HeroProfile>) => Promise<{ error: any }>;
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
  const [heroProfile, setHeroProfile] = useState<HeroProfile | null>(null);
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

  const fetchHeroProfile = async (userId: string) => {
    try {
      const { data, error } = await supabase
        .from('heros')
        .select('*')
        .eq('user_id', userId)
        .single();
      
      if (error) {
        console.error('Error fetching hero profile:', error);
        return null;
      }
      
      return data as HeroProfile;
    } catch (error) {
      console.error('Error fetching hero profile:', error);
      return null;
    }
  };

  useEffect(() => {
    console.log('🚀 Initializing auth...');
    
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
        setLoading(false);
        return;
      }
      
      setSession(session);
      setUser(session?.user ?? null);
      
      if (session?.user) {
        console.log('👤 Found existing session for:', session.user.email);
        const userProfile = await fetchProfile(session.user.id);
        setProfile(userProfile);
        console.log('✅ Profile loaded, role:', userProfile?.role);
        
        // If user is a hero, fetch hero profile
        if (userProfile?.role === UserRole.HERO) {
          console.log('🦸 Fetching hero profile...');
          const heroData = await fetchHeroProfile(session.user.id);
          setHeroProfile(heroData);
          console.log('✅ Hero profile loaded');
        } else {
          console.log('⚠️ User is not a hero (role:', userProfile?.role, ')');
        }
      } else {
        console.log('👤 No existing session found');
      }
      
      setLoading(false);
      console.log('✅ Auth initialization complete');
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
      // the AuthNavigator where ResetPassword screen lives. The Supabase client
      // still has the recovery session internally, so updateUser() will work.
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
        console.log('✅ Profile loaded:', userProfile?.email, 'Role:', userProfile?.role);
        
        // If user is a hero, fetch hero profile
        if (userProfile?.role === UserRole.HERO) {
          console.log('🦸 Fetching hero profile...');
          const heroData = await fetchHeroProfile(session.user.id);
          setHeroProfile(heroData);
          console.log('✅ Hero profile loaded:', heroData?.name);
        } else {
          console.log('⚠️ User is not a hero, role:', userProfile?.role);
          setHeroProfile(null);
        }
      } else {
        console.log('👋 User signed out');
        setProfile(null);
        setHeroProfile(null);
      }
      
      // Always set loading to false after processing
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
      
      const { data, error } = await supabase.auth.signUp({
        email,
        password,
        options: {
          data: {
            role: UserRole.HERO, // Default role for GO app
          }
        }
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
        console.warn('User created but no session - email confirmation may be required');
        return { 
          error: { 
            message: 'Account created but email confirmation is required. Please check your email or contact support.' 
          } 
        };
      }
      
      // Ensure profile is created with hero role (fallback if trigger doesn't work)
      if (data.user && data.session) {
        console.log('✅ User created, ensuring hero profile...');
        
        // Wait a moment for the trigger to complete
        await new Promise(resolve => setTimeout(resolve, 1000));
        
        // Check if profile was created by trigger
        const existingProfile = await fetchProfile(data.user.id);
        
        if (!existingProfile) {
          console.warn('⚠️ Profile not found, creating manually...');
          
          // Create profile manually as fallback with HERO role
          const { error: profileError } = await supabase
            .from('profiles')
            .insert({
              id: data.user.id,
              email: data.user.email,
              name: data.user.email?.split('@')[0] || 'Hero',
              role: UserRole.HERO, // Explicitly set hero role
              status: 'active',
            });
          
          if (profileError) {
            console.error('❌ Failed to create profile:', profileError);
          } else {
            console.log('✅ Hero profile created successfully');
          }
        } else if (existingProfile.role !== UserRole.HERO) {
          console.warn('⚠️ Profile exists but wrong role, updating to hero...');
          
          // Update profile to hero role
          const { error: updateError } = await supabase
            .from('profiles')
            .update({ role: UserRole.HERO })
            .eq('id', data.user.id);
          
          if (updateError) {
            console.error('❌ Failed to update profile role:', updateError);
          } else {
            console.log('✅ Profile role updated to hero');
          }
        } else {
          console.log('✅ Profile already exists with hero role');
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

  const updateHeroProfile = async (updates: Partial<HeroProfile>) => {
    if (!user || !heroProfile) {
      return { error: new Error('No hero profile found') };
    }

    try {
      const { error } = await supabase
        .from('heros')
        .update(updates)
        .eq('user_id', user.id);

      if (error) {
        return { error };
      }

      // Refresh hero profile data
      const updatedHeroProfile = await fetchHeroProfile(user.id);
      setHeroProfile(updatedHeroProfile);

      return { error: null };
    } catch (error) {
      return { error };
    }
  };

  const value: AuthContextType = {
    user,
    profile,
    heroProfile,
    session,
    loading,
    signUp,
    signIn,
    signOut,
    resetPassword,
    updateProfile,
    updateHeroProfile,
  };

  return (
    <AuthContext.Provider value={value}>
      {children}
    </AuthContext.Provider>
  );
};
