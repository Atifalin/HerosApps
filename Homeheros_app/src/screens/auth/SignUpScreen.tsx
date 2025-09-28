import React, { useState } from 'react';
import {
  View,
  StyleSheet,
  Alert,
  KeyboardAvoidingView,
  Platform,
  ScrollView,
  TouchableOpacity,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { useAuth } from '../../contexts/AuthContext';
import { testDirectAuth } from '../../utils/testDirectAuth';
import { Button, Input, Typography } from '../../components/ui';
import { theme } from '../../theme';

interface SignUpScreenProps {
  navigation: any;
}

export const SignUpScreen: React.FC<SignUpScreenProps> = ({ navigation }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const { signUp } = useAuth();

  const handleSignUp = async () => {
    if (!email || !password || !confirmPassword) {
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
      // Test direct auth first
      console.log('Testing direct auth...');
      const directResult = await testDirectAuth(email, password);
      
      if (directResult.success) {
        console.log('Direct auth worked! Now trying Supabase client...');
      }
      
      const { error } = await signUp(email, password);
      setLoading(false);

      if (error) {
        console.log('Error details:', JSON.stringify(error));
        Alert.alert('Sign Up Failed', error.message || 'Network request failed. Please check your connection.');
      } else {
        Alert.alert(
          'Success',
          'Account created successfully! Please check your email to verify your account.',
          [{ text: 'OK', onPress: () => navigation.navigate('Auth') }]
        );
      }
    } catch (err) {
      setLoading(false);
      console.error('Unexpected error during signup:', err);
      Alert.alert('Sign Up Failed', 'An unexpected error occurred. Please try again later.');
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
              Create Account
            </Typography>
            <Typography variant="body1" align="center" color="secondary" style={styles.subtitle}>
              Join HomeHeros and find your perfect service provider
            </Typography>
          </View>

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
            />

            <Input
              label="Password"
              placeholder="Create a password (min 6 characters)"
              value={password}
              onChangeText={setPassword}
              secureTextEntry
              autoComplete="new-password"
              leftIcon="lock-closed-outline"
            />

            <Input
              label="Confirm Password"
              placeholder="Confirm your password"
              value={confirmPassword}
              onChangeText={setConfirmPassword}
              secureTextEntry
              autoComplete="new-password"
              leftIcon="lock-closed-outline"
            />

            <Button
              title={loading ? 'Creating Account...' : 'Create Account'}
              onPress={handleSignUp}
              loading={loading}
              disabled={loading}
              fullWidth
              style={styles.signUpButton}
            />
          </View>

          <View style={styles.footer}>
            <Typography variant="body2" color="secondary">
              Already have an account?{' '}
              <Typography
                variant="body2"
                color="brand"
                onPress={() => navigation.navigate('Auth')}
              >
                Sign In
              </Typography>
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
  
  signUpButton: {
    marginTop: theme.semanticSpacing.md,
  },
  
  footer: {
    alignItems: 'center',
    marginTop: theme.semanticSpacing.lg,
  },
});
