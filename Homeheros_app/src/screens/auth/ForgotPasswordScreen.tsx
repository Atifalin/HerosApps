import React, { useState } from 'react';
import {
  View,
  StyleSheet,
  Alert,
  KeyboardAvoidingView,
  Platform,
  ScrollView,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Button, Input, Typography } from '../../components/ui';
import { theme } from '../../theme';
import { supabase } from '../../lib/supabase';

interface ForgotPasswordScreenProps {
  navigation: any;
}

export const ForgotPasswordScreen: React.FC<ForgotPasswordScreenProps> = ({ navigation }) => {
  const [email, setEmail] = useState('');
  const [loading, setLoading] = useState(false);
  const [emailSent, setEmailSent] = useState(false);

  const handleResetPassword = async () => {
    if (!email) {
      Alert.alert('Error', 'Please enter your email address');
      return;
    }

    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      Alert.alert('Error', 'Please enter a valid email address');
      return;
    }

    setLoading(true);
    try {
      const { error } = await supabase.auth.resetPasswordForEmail(email, {
        redirectTo: 'homeheros://reset-password',
      });

      setLoading(false);

      if (error) {
        console.error('Password reset error:', error);
        Alert.alert('Error', error.message || 'Failed to send reset email. Please try again.');
      } else {
        setEmailSent(true);
      }
    } catch (err) {
      setLoading(false);
      console.error('Unexpected error during password reset:', err);
      Alert.alert('Error', 'An unexpected error occurred. Please try again later.');
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <KeyboardAvoidingView
        style={styles.keyboardView}
        behavior={Platform.OS === 'ios' ? 'padding' : 'height'}
      >
        <ScrollView contentContainerStyle={styles.scrollContainer}>
          <View style={styles.header}>
            <Typography variant="h2" align="center" color="brand">
              {emailSent ? 'Check Your Email' : 'Forgot Password?'}
            </Typography>
            <Typography variant="body1" align="center" color="secondary" style={styles.subtitle}>
              {emailSent
                ? `We've sent a password reset link to ${email}`
                : "Enter your email and we'll send you a link to reset your password"}
            </Typography>
          </View>

          {!emailSent ? (
            <>
              <View style={styles.form}>
                <Input
                  label="Email"
                  placeholder="Enter your email"
                  value={email}
                  onChangeText={setEmail}
                  keyboardType="email-address"
                  autoCapitalize="none"
                  autoComplete="email"
                  leftIcon="mail-outline"
                  editable={!loading}
                />

                <Button
                  title={loading ? 'Sending...' : 'Send Reset Link'}
                  onPress={handleResetPassword}
                  loading={loading}
                  disabled={loading}
                  fullWidth
                  style={styles.primaryButton}
                />
              </View>

              <View style={styles.footer}>
                <Typography variant="body2" color="secondary">
                  Remember your password?{' '}
                  <Typography
                    variant="body2"
                    color="brand"
                    onPress={() => navigation.goBack()}
                  >
                    Sign In
                  </Typography>
                </Typography>
              </View>
            </>
          ) : (
            <View style={styles.successContainer}>
              <Typography variant="h1" align="center" style={styles.successIcon}>
                ✉️
              </Typography>
              <Typography variant="body1" align="center" color="secondary" style={styles.instructions}>
                Click the link in the email to reset your password. If you don't see it, check your spam folder.
              </Typography>
              <Typography variant="caption" align="center" color="tertiary" style={styles.expireNote}>
                The link will expire in 1 hour.
              </Typography>
              <Button
                title="Back to Sign In"
                onPress={() => navigation.goBack()}
                fullWidth
                style={styles.primaryButton}
              />
            </View>
          )}
        </ScrollView>
      </KeyboardAvoidingView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: theme.colors.background.primary,
  },
  keyboardView: {
    flex: 1,
  },
  scrollContainer: {
    flexGrow: 1,
    justifyContent: 'center',
    padding: theme.semanticSpacing.screenPadding,
  },
  header: {
    alignItems: 'center',
    marginBottom: theme.semanticSpacing.xl,
  },
  subtitle: {
    marginTop: theme.semanticSpacing.sm,
    paddingHorizontal: theme.semanticSpacing.md,
  },
  form: {
    marginBottom: theme.semanticSpacing.xl,
  },
  primaryButton: {
    marginTop: theme.semanticSpacing.md,
  },
  footer: {
    alignItems: 'center',
    marginTop: theme.semanticSpacing.lg,
  },
  successContainer: {
    alignItems: 'center',
  },
  successIcon: {
    fontSize: 64,
    marginBottom: theme.semanticSpacing.lg,
  },
  instructions: {
    marginBottom: theme.semanticSpacing.md,
    paddingHorizontal: theme.semanticSpacing.md,
  },
  expireNote: {
    marginBottom: theme.semanticSpacing.xl,
  },
});
