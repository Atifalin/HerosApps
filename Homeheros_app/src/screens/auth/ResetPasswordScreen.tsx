import React, { useState, useEffect } from 'react';
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
import { setRecoveryActive } from '../../lib/authRecoveryState';

interface ResetPasswordScreenProps {
  navigation: any;
}

export const ResetPasswordScreen: React.FC<ResetPasswordScreenProps> = ({ navigation }) => {
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [loading, setLoading] = useState(false);

  useEffect(() => {
    checkSession();
  }, []);

  const checkSession = async () => {
    const { data: { session } } = await supabase.auth.getSession();
    if (!session) {
      Alert.alert(
        'Invalid Link',
        'This password reset link is invalid or has expired. Please request a new one.',
        [
          {
            text: 'OK',
            onPress: () => navigation.navigate('Login'),
          },
        ]
      );
    }
  };

  const handleResetPassword = async () => {
    if (!password || !confirmPassword) {
      Alert.alert('Error', 'Please fill in all fields');
      return;
    }

    if (password !== confirmPassword) {
      Alert.alert('Error', 'Passwords do not match');
      return;
    }

    if (password.length < 6) {
      Alert.alert('Error', 'Password must be at least 6 characters');
      return;
    }

    setLoading(true);
    try {
      const { error } = await supabase.auth.updateUser({
        password: password,
      });

      setLoading(false);

      if (error) {
        console.error('Password reset error:', error);
        Alert.alert('Error', error.message || 'Failed to reset password');
      } else {
        Alert.alert(
          'Success!',
          'Your password has been reset successfully. You can now sign in with your new password.',
          [
            {
              text: 'OK',
              onPress: async () => {
                setRecoveryActive(false);
                // Sign out clears the recovery session; AppNavigator's
                // conditional rendering will automatically switch to Login.
                await supabase.auth.signOut();
              },
            },
          ]
        );
      }
    } catch (err) {
      setLoading(false);
      console.error('Unexpected error during password reset:', err);
      Alert.alert('Error', 'An unexpected error occurred. Please try again.');
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
              Reset Password
            </Typography>
            <Typography variant="body1" align="center" color="secondary" style={styles.subtitle}>
              Enter your new password below
            </Typography>
          </View>

          <View style={styles.form}>
            <Input
              label="New Password"
              placeholder="Enter new password (min 6 characters)"
              value={password}
              onChangeText={setPassword}
              secureTextEntry
              autoComplete="new-password"
              leftIcon="lock-closed-outline"
              editable={!loading}
            />

            <Input
              label="Confirm Password"
              placeholder="Confirm your new password"
              value={confirmPassword}
              onChangeText={setConfirmPassword}
              secureTextEntry
              autoComplete="new-password"
              leftIcon="lock-closed-outline"
              editable={!loading}
            />

            <Button
              title={loading ? 'Resetting...' : 'Reset Password'}
              onPress={handleResetPassword}
              loading={loading}
              disabled={loading}
              fullWidth
              style={styles.primaryButton}
            />
          </View>

          <View style={styles.footer}>
            <Typography
              variant="body2"
              color="brand"
              onPress={() => navigation.navigate('Login')}
            >
              Cancel
            </Typography>
          </View>
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
});
