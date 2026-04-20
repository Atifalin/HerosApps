import { Linking, Alert } from 'react-native';
import { supabase } from './supabase';
import { setRecoveryActive } from './authRecoveryState';
import { navigate } from '../navigation/navigationRef';

/**
 * Extracts tokens from a deep link URL hash/query and establishes a Supabase session.
 * Expected URL formats:
 *   homeheros://reset-password#access_token=xxx&refresh_token=yyy&type=recovery
 *   homeheros://confirm-email#access_token=xxx&refresh_token=yyy&type=signup
 */
export const handleAuthDeepLink = async (url: string | null): Promise<boolean> => {
  if (!url) return false;

  console.log('🔗 Deep link received:', url);

  try {
    let params: Record<string, string> = {};

    // Parse hash fragment (most common for Supabase auth redirects)
    const hash = url.split('#')[1];
    if (hash) {
      hash.split('&').forEach((pair) => {
        const [key, value] = pair.split('=');
        if (key && value) params[key] = decodeURIComponent(value);
      });
    }

    // Fallback: query params
    const queryString = url.split('?')[1]?.split('#')[0];
    if (queryString) {
      queryString.split('&').forEach((pair) => {
        const [key, value] = pair.split('=');
        if (key && value && !params[key]) params[key] = decodeURIComponent(value);
      });
    }

    // Check for error parameters first (expired/invalid links)
    if (params.error || params.error_code) {
      const errorCode = params.error_code || params.error;
      const description = (params.error_description || '').replace(/\+/g, ' ');
      console.log('🔗 Deep link error:', errorCode, description);

      let title = 'Link Error';
      let message = description || 'This link is invalid or has expired.';

      if (errorCode === 'otp_expired' || errorCode === 'access_denied') {
        title = 'Link Expired';
        message =
          'This password reset link has expired or was already used. Please request a new one from the app.';
      }

      Alert.alert(title, message, [{ text: 'OK' }]);
      return false;
    }

    const access_token = params.access_token;
    const refresh_token = params.refresh_token;
    const type = params.type;

    if (!access_token || !refresh_token) {
      console.log('🔗 No auth tokens in URL, ignoring');
      return false;
    }

    console.log('🔗 Setting session from deep link, type:', type);

    // If this is a password recovery flow, flag it BEFORE creating the session
    // so AuthContext doesn't elevate the user to "signed in" state.
    const isRecovery = type === 'recovery';
    if (isRecovery) {
      setRecoveryActive(true);
    }

    const { error } = await supabase.auth.setSession({
      access_token,
      refresh_token,
    });

    if (error) {
      console.error('❌ setSession error:', error);
      if (isRecovery) setRecoveryActive(false);
      Alert.alert('Link Error', 'Unable to use this link. Please request a new one.');
      return false;
    }

    console.log('✅ Deep link session established (type:', type, ')');

    // For recovery flows, navigate to the reset password screen directly.
    if (isRecovery) {
      setTimeout(() => navigate('ResetPassword'), 150);
    }

    return true;
  } catch (err) {
    console.error('❌ Deep link handler error:', err);
    return false;
  }
};

/**
 * Subscribes to incoming URLs and handles the initial one if the app was cold-started via a link.
 * Returns an unsubscribe function.
 */
export const subscribeToAuthDeepLinks = (): (() => void) => {
  // Handle cold start
  Linking.getInitialURL().then((url) => {
    if (url) handleAuthDeepLink(url);
  });

  // Handle while app is running
  const sub = Linking.addEventListener('url', ({ url }) => {
    handleAuthDeepLink(url);
  });

  return () => {
    sub.remove();
  };
};
