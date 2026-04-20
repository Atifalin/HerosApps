import React, { useState } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  StyleSheet,
  Alert,
  ScrollView,
} from 'react-native';
import { supabase } from '../../lib/supabase';

const EmailConfirmationScreen = ({ navigation, route }: any) => {
  const email = route?.params?.email || '';
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
          emailRedirectTo: 'homeheros-go://confirm-email',
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
          "We've sent another confirmation email. Please check your inbox and spam folder."
        );
      }
    } catch (err) {
      setResending(false);
      console.error('Resend email error:', err);
      Alert.alert('Error', 'An unexpected error occurred. Please try again.');
    }
  };

  return (
    <ScrollView contentContainerStyle={styles.container}>
      <View style={styles.iconContainer}>
        <Text style={styles.icon}>📬</Text>
      </View>

      <View style={styles.header}>
        <Text style={styles.title}>Check Your Email</Text>
        <Text style={styles.subtitle}>We've sent a confirmation link to</Text>
        <Text style={styles.email}>{email}</Text>
      </View>

      <View style={styles.infoCard}>
        <Text style={styles.infoText}>
          Click the link in the email to verify your account and start offering services on HomeHeros GO.
        </Text>
        <Text style={styles.infoTextSmall}>
          • Check your spam or junk folder if you don't see it
        </Text>
        <Text style={styles.infoTextSmall}>
          • The link will expire in 24 hours
        </Text>
        <Text style={styles.infoTextSmall}>
          • Once verified, you can sign in to your account
        </Text>
      </View>

      <TouchableOpacity
        style={[styles.outlineButton, resending && styles.buttonDisabled]}
        onPress={handleResendEmail}
        disabled={resending}
      >
        <Text style={styles.outlineButtonText}>
          {resending ? 'Sending...' : 'Resend Confirmation Email'}
        </Text>
      </TouchableOpacity>

      <TouchableOpacity
        style={styles.button}
        onPress={() => navigation.navigate('SignIn')}
      >
        <Text style={styles.buttonText}>Back to Sign In</Text>
      </TouchableOpacity>

      {resendCount > 0 && (
        <Text style={styles.resendCount}>
          Email sent {resendCount} {resendCount === 1 ? 'time' : 'times'}
        </Text>
      )}
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flexGrow: 1,
    justifyContent: 'center',
    padding: 20,
    backgroundColor: '#fff',
  },
  iconContainer: {
    alignItems: 'center',
    marginBottom: 20,
  },
  icon: {
    fontSize: 80,
  },
  header: {
    alignItems: 'center',
    marginBottom: 30,
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#FF6B35',
    marginBottom: 8,
  },
  subtitle: {
    fontSize: 16,
    color: '#666',
    marginBottom: 4,
  },
  email: {
    fontSize: 18,
    fontWeight: '600',
    color: '#333',
    marginTop: 4,
  },
  infoCard: {
    backgroundColor: '#fff5f0',
    borderRadius: 12,
    padding: 20,
    marginBottom: 24,
    borderLeftWidth: 4,
    borderLeftColor: '#FF6B35',
  },
  infoText: {
    fontSize: 14,
    color: '#333',
    marginBottom: 12,
    lineHeight: 20,
  },
  infoTextSmall: {
    fontSize: 13,
    color: '#666',
    marginTop: 4,
    lineHeight: 18,
  },
  button: {
    backgroundColor: '#FF6B35',
    borderRadius: 8,
    padding: 15,
    alignItems: 'center',
    marginTop: 10,
  },
  outlineButton: {
    backgroundColor: '#fff',
    borderWidth: 2,
    borderColor: '#FF6B35',
    borderRadius: 8,
    padding: 13,
    alignItems: 'center',
    marginBottom: 12,
  },
  outlineButtonText: {
    color: '#FF6B35',
    fontSize: 16,
    fontWeight: 'bold',
  },
  buttonDisabled: {
    opacity: 0.6,
  },
  buttonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: 'bold',
  },
  resendCount: {
    textAlign: 'center',
    marginTop: 12,
    color: '#999',
    fontSize: 12,
  },
});

export default EmailConfirmationScreen;
