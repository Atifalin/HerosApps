import React, { useState } from 'react';
import {
  View,
  Text,
  TouchableOpacity,
  StyleSheet,
  ScrollView,
  Linking,
  Alert,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';

interface BackgroundCheckScreenProps {
  navigation: any;
  route: any;
}

const BackgroundCheckScreen: React.FC<BackgroundCheckScreenProps> = ({ navigation, route }) => {
  const email = route.params?.email || '';
  const legalAcceptance = route.params?.legalAcceptance;
  const password = route.params?.password || '';
  const [checkCompleted, setCheckCompleted] = useState(false);
  const [loading, setLoading] = useState(false);

  const completeSignup = async () => {
    setLoading(true);
    
    try {
      const { supabase } = await import('../../lib/supabase');
      
      // Perform the actual signup using Supabase client
      const { data, error: signupError } = await supabase.auth.signUp({
        email,
        password,
        options: {
          data: {
            role: 'hero',
          }
        }
      });

      if (signupError) {
        throw new Error(signupError.message);
      }

      if (!data.user) {
        throw new Error('Signup failed - no user returned');
      }

      // Wait a moment for the trigger to create profile
      await new Promise(resolve => setTimeout(resolve, 1500));

      // Update profile with role as hero and legal acceptance timestamps
      const updateData: any = {
        role: 'hero', // Set role to hero for GO app
      };

      if (legalAcceptance) {
        updateData.privacy_policy_accepted_at = legalAcceptance.privacy_policy_accepted_at;
        updateData.terms_accepted_at = legalAcceptance.terms_accepted_at;
        updateData.contractor_agreement_accepted_at = legalAcceptance.contractor_agreement_accepted_at;
      }

      const { error: updateError } = await supabase
        .from('profiles')
        .update(updateData)
        .eq('id', data.user.id);

      if (updateError) {
        console.error('Error updating profile:', updateError);
      } else {
        console.log('Profile updated: role set to hero, legal acceptance timestamps saved');
      }

      return { success: true };
    } catch (err: any) {
      console.error('Signup error:', err);
      return { success: false, error: err.message };
    } finally {
      setLoading(false);
    }
  };

  const handleStartBackgroundCheck = () => {
    const backgroundCheckUrl = 'https://homeheros.ca/background-check.html';
    
    Linking.openURL(backgroundCheckUrl).catch((err) => {
      console.error('Failed to open URL:', err);
      Alert.alert(
        'Error',
        'Unable to open background check page. Please check your internet connection.'
      );
    });
  };

  const handleContinue = async () => {
    const result = await completeSignup();
    
    if (!result.success) {
      Alert.alert('Error', result.error || 'Failed to complete signup');
      return;
    }

    Alert.alert(
      'Account Created!',
      'Your account has been created successfully. You can now sign in.',
      [
        {
          text: 'Sign In',
          onPress: () => navigation.navigate('SignIn'),
        },
      ]
    );
  };

  const handleSkipForNow = () => {
    Alert.alert(
      'Skip Background Check?',
      'You can complete the background check later from your profile settings. However, you will not be able to accept jobs until the background check is complete.',
      [
        {
          text: 'Cancel',
          style: 'cancel',
        },
        {
          text: 'Skip',
          style: 'destructive',
          onPress: async () => {
            const result = await completeSignup();
            
            if (!result.success) {
              Alert.alert('Error', result.error || 'Failed to complete signup');
              return;
            }
            
            navigation.navigate('SignIn');
          },
        },
      ]
    );
  };

  return (
    <View style={styles.container}>
      <ScrollView contentContainerStyle={styles.scrollContent}>
        <View style={styles.content}>
          {/* Icon and Title */}
          <View style={styles.titleSection}>
            <Ionicons name="shield-checkmark-outline" size={80} color="#FF6B35" />
            <Text style={styles.title}>Background Check</Text>
            <Text style={styles.subtitle}>
              As a HomeHeros service provider, we require a background check to ensure the safety and trust of our community.
            </Text>
          </View>

          {/* Info Cards */}
          <View style={styles.infoSection}>
            <View style={styles.infoCard}>
              <Ionicons name="checkmark-circle" size={24} color="#4CAF50" />
              <View style={styles.infoTextContainer}>
                <Text style={styles.infoTitle}>Quick & Easy</Text>
                <Text style={styles.infoText}>
                  The process takes just a few minutes to complete online.
                </Text>
              </View>
            </View>

            <View style={styles.infoCard}>
              <Ionicons name="lock-closed" size={24} color="#FF6B35" />
              <View style={styles.infoTextContainer}>
                <Text style={styles.infoTitle}>Secure & Private</Text>
                <Text style={styles.infoText}>
                  Your information is encrypted and handled with strict confidentiality.
                </Text>
              </View>
            </View>

            <View style={styles.infoCard}>
              <Ionicons name="time" size={24} color="#2196F3" />
              <View style={styles.infoTextContainer}>
                <Text style={styles.infoTitle}>Fast Processing</Text>
                <Text style={styles.infoText}>
                  Most background checks are completed within 24-48 hours.
                </Text>
              </View>
            </View>
          </View>

          {/* What's Checked */}
          <View style={styles.checkedSection}>
            <Text style={styles.checkedTitle}>What We Check:</Text>
            <View style={styles.checkedItem}>
              <Ionicons name="checkmark" size={20} color="#4CAF50" />
              <Text style={styles.checkedText}>Criminal record verification</Text>
            </View>
            <View style={styles.checkedItem}>
              <Ionicons name="checkmark" size={20} color="#4CAF50" />
              <Text style={styles.checkedText}>Identity verification</Text>
            </View>
            <View style={styles.checkedItem}>
              <Ionicons name="checkmark" size={20} color="#4CAF50" />
              <Text style={styles.checkedText}>Employment eligibility</Text>
            </View>
          </View>

          {/* Checkbox for completion */}
          <TouchableOpacity
            style={styles.checkboxContainer}
            onPress={() => setCheckCompleted(!checkCompleted)}
          >
            <View style={[styles.checkbox, checkCompleted && styles.checkboxChecked]}>
              {checkCompleted && <Ionicons name="checkmark" size={18} color="#fff" />}
            </View>
            <Text style={styles.checkboxLabel}>
              I have completed the background check process
            </Text>
          </TouchableOpacity>
        </View>
      </ScrollView>

      {/* Footer Buttons */}
      <View style={styles.footer}>
        <TouchableOpacity
          style={styles.startButton}
          onPress={handleStartBackgroundCheck}
        >
          <Ionicons name="open-outline" size={20} color="#fff" />
          <Text style={styles.startButtonText}>Start Background Check</Text>
        </TouchableOpacity>

        <TouchableOpacity
          style={[
            styles.continueButton,
            (!checkCompleted || loading) && styles.continueButtonDisabled
          ]}
          onPress={handleContinue}
          disabled={!checkCompleted || loading}
        >
          <Text style={styles.continueButtonText}>
            {loading ? 'Creating Account...' : 'Continue'}
          </Text>
          {!loading && <Ionicons name="arrow-forward" size={20} color="#fff" />}
        </TouchableOpacity>

        <TouchableOpacity
          style={styles.skipButton}
          onPress={handleSkipForNow}
          disabled={loading}
        >
          <Text style={styles.skipButtonText}>Skip for Now</Text>
        </TouchableOpacity>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
  },
  scrollContent: {
    flexGrow: 1,
    paddingBottom: 20,
  },
  content: {
    flex: 1,
    paddingHorizontal: 20,
    paddingTop: 60,
  },
  titleSection: {
    alignItems: 'center',
    marginBottom: 40,
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#333',
    marginTop: 16,
    marginBottom: 12,
  },
  subtitle: {
    fontSize: 16,
    color: '#666',
    textAlign: 'center',
    lineHeight: 24,
    paddingHorizontal: 10,
  },
  infoSection: {
    marginBottom: 30,
  },
  infoCard: {
    flexDirection: 'row',
    backgroundColor: '#F8F9FA',
    padding: 16,
    borderRadius: 12,
    marginBottom: 12,
    alignItems: 'center',
  },
  infoTextContainer: {
    flex: 1,
    marginLeft: 12,
  },
  infoTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 4,
  },
  infoText: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  checkedSection: {
    backgroundColor: '#F0F8FF',
    padding: 20,
    borderRadius: 12,
    marginBottom: 24,
    borderWidth: 1,
    borderColor: '#D6E9FF',
  },
  checkedTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 12,
  },
  checkedItem: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
  },
  checkedText: {
    fontSize: 14,
    color: '#555',
    marginLeft: 8,
  },
  checkboxContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 12,
  },
  checkbox: {
    width: 24,
    height: 24,
    borderRadius: 6,
    borderWidth: 2,
    borderColor: '#ddd',
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: 12,
  },
  checkboxChecked: {
    backgroundColor: '#FF6B35',
    borderColor: '#FF6B35',
  },
  checkboxLabel: {
    flex: 1,
    fontSize: 15,
    color: '#333',
  },
  footer: {
    padding: 20,
    borderTopWidth: 1,
    borderTopColor: '#f0f0f0',
  },
  startButton: {
    backgroundColor: '#2196F3',
    borderRadius: 12,
    padding: 16,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 12,
  },
  startButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: 'bold',
    marginLeft: 8,
  },
  continueButton: {
    backgroundColor: '#FF6B35',
    borderRadius: 12,
    padding: 16,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 12,
  },
  continueButtonDisabled: {
    backgroundColor: '#ccc',
    opacity: 0.6,
  },
  continueButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: 'bold',
    marginRight: 8,
  },
  skipButton: {
    padding: 12,
    alignItems: 'center',
  },
  skipButtonText: {
    color: '#999',
    fontSize: 14,
  },
});

export default BackgroundCheckScreen;
