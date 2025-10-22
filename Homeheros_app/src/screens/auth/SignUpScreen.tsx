import React, { useState, useEffect } from 'react';
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
  const { signUp, signIn, user } = useAuth();

  // Monitor user state and navigate when authenticated
  useEffect(() => {
    console.log('👤 SignUpScreen - User state changed:', user?.email || 'No user');
    if (user) {
      console.log('✅ User is authenticated, forcing navigation to MainTabs');
      // Force navigation by resetting the navigation stack
      navigation.reset({
        index: 0,
        routes: [{ name: 'MainTabs' }],
      });
    }
  }, [user, navigation]);

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
      const { error } = await signUp(email, password);

      if (error) {
        setLoading(false);
        console.log('Error details:', JSON.stringify(error));
        
        // If user already exists, offer to navigate to sign in
        if (error.message?.toLowerCase().includes('already exists')) {
          Alert.alert(
            'Account Already Exists',
            'An account with this email already exists. Would you like to sign in instead?',
            [
              { text: 'Cancel', style: 'cancel' },
              { text: 'Sign In', onPress: () => navigation.navigate('Auth') }
            ]
          );
        } else {
          Alert.alert('Sign Up Failed', error.message || 'Network request failed. Please check your connection.');
        }
        return;
      }

      // Sign up successful - now automatically sign in
      console.log('✅ Sign up successful, signing in...');
      const { error: signInError } = await signIn(email, password);
      
      setLoading(false);

      if (signInError) {
        console.error('Sign in after signup failed:', signInError);
        Alert.alert(
          'Account Created',
          'Your account was created successfully, but automatic sign-in failed. Please sign in manually.',
          [{ text: 'OK', onPress: () => navigation.navigate('Auth') }]
        );
      } else {
        console.log('✅ Automatically signed in after sign up');
        // Navigation will happen automatically via AuthContext state change
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
              title={loading ? 'Creating Account...' : 'Create Account & Sign In'}
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
