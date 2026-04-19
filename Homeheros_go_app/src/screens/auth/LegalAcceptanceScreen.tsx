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

interface LegalAcceptanceScreenProps {
  navigation: any;
}

const LegalAcceptanceScreen: React.FC<LegalAcceptanceScreenProps> = ({ navigation }) => {
  const [privacyAccepted, setPrivacyAccepted] = useState(false);
  const [termsAccepted, setTermsAccepted] = useState(false);
  const [contractorAccepted, setContractorAccepted] = useState(false);

  const handleContinue = () => {
    if (!privacyAccepted || !termsAccepted || !contractorAccepted) {
      Alert.alert(
        'Acceptance Required',
        'You must accept all agreements to continue creating your provider account.'
      );
      return;
    }

    // Navigate to SignUp with acceptance timestamps
    navigation.navigate('SignUp', {
      legalAcceptance: {
        privacy_policy_accepted_at: new Date().toISOString(),
        terms_accepted_at: new Date().toISOString(),
        contractor_agreement_accepted_at: new Date().toISOString(),
      },
    });
  };

  const openDocument = (type: 'privacy' | 'terms' | 'contractor') => {
    const urls = {
      privacy: 'https://homeheros.ca/privacy-policy.html',
      terms: 'https://homeheros.ca/terms-conditions.html',
      contractor: 'https://homeheros.ca/contractor-agreement.html',
    };

    const titles = {
      privacy: 'Privacy Policy',
      terms: 'Terms & Conditions',
      contractor: 'Contractor Agreement',
    };

    Linking.openURL(urls[type]).catch((err) => {
      console.error('Failed to open URL:', err);
      Alert.alert(
        'Error',
        `Unable to open ${titles[type]}. Please check your internet connection.`
      );
    });
  };

  const CheckBox = ({ 
    checked, 
    onPress, 
    label, 
    documentType 
  }: { 
    checked: boolean; 
    onPress: () => void; 
    label: string;
    documentType: 'privacy' | 'terms' | 'contractor';
  }) => (
    <View style={styles.checkboxContainer}>
      <TouchableOpacity
        style={[styles.checkbox, checked && styles.checkboxChecked]}
        onPress={onPress}
      >
        {checked && <Ionicons name="checkmark" size={18} color="#fff" />}
      </TouchableOpacity>
      <View style={styles.checkboxTextContainer}>
        <Text style={styles.checkboxLabel}>
          {label}{' '}
          <Text 
            style={styles.linkText}
            onPress={() => openDocument(documentType)}
          >
            Read Document
          </Text>
        </Text>
      </View>
    </View>
  );

  return (
    <View style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <TouchableOpacity
          style={styles.backButton}
          onPress={() => navigation.goBack()}
        >
          <Ionicons name="arrow-back" size={24} color="#333" />
        </TouchableOpacity>
      </View>

      <ScrollView contentContainerStyle={styles.scrollContent}>
        <View style={styles.content}>
          {/* Title Section */}
          <View style={styles.titleSection}>
            <Ionicons name="shield-checkmark" size={60} color="#FF6B35" />
            <Text style={styles.title}>Legal Agreements</Text>
            <Text style={styles.subtitle}>
              Before creating your provider account, please review and accept the following agreements.
            </Text>
          </View>

          {/* Agreements Section */}
          <View style={styles.agreementsSection}>
            <CheckBox
              checked={privacyAccepted}
              onPress={() => setPrivacyAccepted(!privacyAccepted)}
              label="I have read and accept the Privacy Policy"
              documentType="privacy"
            />

            <CheckBox
              checked={termsAccepted}
              onPress={() => setTermsAccepted(!termsAccepted)}
              label="I have read and accept the Terms & Conditions"
              documentType="terms"
            />

            <CheckBox
              checked={contractorAccepted}
              onPress={() => setContractorAccepted(!contractorAccepted)}
              label="I have read and accept the Contractor Agreement"
              documentType="contractor"
            />
          </View>

          {/* Info Box */}
          <View style={styles.infoBox}>
            <Ionicons name="information-circle" size={20} color="#FF6B35" />
            <Text style={styles.infoText}>
              These agreements outline your rights and responsibilities as a HomeHeros service provider.
            </Text>
          </View>
        </View>
      </ScrollView>

      {/* Footer Button */}
      <View style={styles.footer}>
        <TouchableOpacity
          style={[
            styles.continueButton,
            (!privacyAccepted || !termsAccepted || !contractorAccepted) && styles.continueButtonDisabled
          ]}
          onPress={handleContinue}
          disabled={!privacyAccepted || !termsAccepted || !contractorAccepted}
        >
          <Text style={styles.continueButtonText}>Continue to Sign Up</Text>
          <Ionicons name="arrow-forward" size={20} color="#fff" />
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
  header: {
    paddingTop: 50,
    paddingHorizontal: 20,
    paddingBottom: 10,
  },
  backButton: {
    width: 40,
    height: 40,
    justifyContent: 'center',
  },
  scrollContent: {
    flexGrow: 1,
  },
  content: {
    flex: 1,
    paddingHorizontal: 20,
    paddingBottom: 20,
  },
  titleSection: {
    alignItems: 'center',
    marginTop: 20,
    marginBottom: 40,
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#333',
    marginTop: 16,
    marginBottom: 8,
  },
  subtitle: {
    fontSize: 16,
    color: '#666',
    textAlign: 'center',
    lineHeight: 22,
    paddingHorizontal: 20,
  },
  agreementsSection: {
    marginBottom: 30,
  },
  checkboxContainer: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    marginBottom: 24,
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
    marginTop: 2,
  },
  checkboxChecked: {
    backgroundColor: '#FF6B35',
    borderColor: '#FF6B35',
  },
  checkboxTextContainer: {
    flex: 1,
  },
  checkboxLabel: {
    fontSize: 15,
    color: '#333',
    lineHeight: 22,
  },
  linkText: {
    color: '#FF6B35',
    fontWeight: '600',
    textDecorationLine: 'underline',
  },
  infoBox: {
    flexDirection: 'row',
    backgroundColor: '#FFF5F0',
    padding: 16,
    borderRadius: 12,
    borderWidth: 1,
    borderColor: '#FFE5D9',
  },
  infoText: {
    flex: 1,
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
    marginLeft: 12,
  },
  footer: {
    padding: 20,
    borderTopWidth: 1,
    borderTopColor: '#f0f0f0',
  },
  continueButton: {
    backgroundColor: '#FF6B35',
    borderRadius: 12,
    padding: 16,
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
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
});

export default LegalAcceptanceScreen;
