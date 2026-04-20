import React, { useState } from 'react';
import {
  View,
  StyleSheet,
  Alert,
  ScrollView,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Button, Typography } from '../../components/ui';
import { theme } from '../../theme';
import { supabase } from '../../lib/supabase';

interface EmailConfirmationScreenProps {
  navigation: any;
  route: {
    params?: {
      email?: string;
    };
  };
}

export const EmailConfirmationScreen: React.FC<EmailConfirmationScreenProps> = ({ navigation, route }) => {
  const email = route.params?.email || '';
  const [resending, setResending] = useState(false);
  const [resendCount, setResendCount] = useState(0);

  const handleResendEmail = async () => {
    if (!email) {
      Alert.alert('Error', 'Email address not found. Please sign up again.');
      return;
    }

    setResending(true);
    try {
      const { error } = await supabase.auth.resend({
        type: 'signup',
        email: email,
        options: {
          emailRedirectTo: 'homeheros://confirm-email',
        },
      });

      setResending(false);

      if (error) {
        if (error.message?.toLowerCase().includes('rate limit')) {
          Alert.alert(
            'Please Wait',
            'Please wait 60 seconds before requesting another email.'
          );
        } else {
          Alert.alert('Error', error.message || 'Failed to resend email');
        }
      } else {
        setResendCount(resendCount + 1);
        Alert.alert(
          'Email Sent!',
          'We\'ve sent another confirmation email. Please check your inbox and spam folder.'
        );
      }
    } catch (err) {
      setResending(false);
      console.error('Resend email error:', err);
      Alert.alert('Error', 'An unexpected error occurred. Please try again.');
    }
  };

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView contentContainerStyle={styles.scrollContainer}>
        <View style={styles.iconContainer}>
          <Typography variant="h1" align="center" style={styles.icon}>
            📬
          </Typography>
        </View>

        <View style={styles.header}>
          <Typography variant="h2" align="center" color="brand">
            Check Your Email
          </Typography>
          <Typography variant="body1" align="center" color="secondary" style={styles.subtitle}>
            We've sent a confirmation link to
          </Typography>
          <Typography variant="body1" align="center" color="primary" style={styles.email}>
            {email}
          </Typography>
        </View>

        <View style={styles.infoCard}>
          <Typography variant="body2" color="secondary" style={styles.infoText}>
            Click the link in the email to verify your account and start using HomeHeros.
          </Typography>
          <Typography variant="caption" color="tertiary" style={styles.infoTextSmall}>
            • Check your spam or junk folder if you don't see it
          </Typography>
          <Typography variant="caption" color="tertiary" style={styles.infoTextSmall}>
            • The link will expire in 24 hours
          </Typography>
          <Typography variant="caption" color="tertiary" style={styles.infoTextSmall}>
            • Once verified, you can sign in to your account
          </Typography>
        </View>

        <View style={styles.actions}>
          <Button
            title={resending ? 'Sending...' : 'Resend Confirmation Email'}
            onPress={handleResendEmail}
            loading={resending}
            disabled={resending}
            variant="outline"
            fullWidth
            style={styles.resendButton}
          />

          <Button
            title="Back to Sign In"
            onPress={() => navigation.navigate('Login')}
            fullWidth
            style={styles.signInButton}
          />
        </View>

        {resendCount > 0 && (
          <Typography variant="caption" align="center" color="tertiary" style={styles.resendCount}>
            Email sent {resendCount} {resendCount === 1 ? 'time' : 'times'}
          </Typography>
        )}
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: theme.colors.background.primary,
  },
  scrollContainer: {
    flexGrow: 1,
    justifyContent: 'center',
    padding: theme.semanticSpacing.screenPadding,
  },
  iconContainer: {
    alignItems: 'center',
    marginBottom: theme.semanticSpacing.lg,
  },
  icon: {
    fontSize: 80,
  },
  header: {
    alignItems: 'center',
    marginBottom: theme.semanticSpacing.xl,
  },
  subtitle: {
    marginTop: theme.semanticSpacing.sm,
  },
  email: {
    marginTop: theme.semanticSpacing.xs,
    fontWeight: '600',
  },
  infoCard: {
    backgroundColor: theme.colors.background.secondary,
    borderRadius: 12,
    padding: theme.semanticSpacing.lg,
    marginBottom: theme.semanticSpacing.xl,
    borderLeftWidth: 4,
    borderLeftColor: theme.colors.primary.main,
  },
  infoText: {
    marginBottom: theme.semanticSpacing.sm,
    lineHeight: 20,
  },
  infoTextSmall: {
    marginTop: theme.semanticSpacing.xs,
    lineHeight: 18,
  },
  actions: {
    marginBottom: theme.semanticSpacing.md,
  },
  resendButton: {
    marginBottom: theme.semanticSpacing.sm,
  },
  signInButton: {
    marginTop: theme.semanticSpacing.xs,
  },
  resendCount: {
    marginTop: theme.semanticSpacing.sm,
  },
});
