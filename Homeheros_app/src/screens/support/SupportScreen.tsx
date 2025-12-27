import React, { useState } from 'react';
import {
  View,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Alert,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { StatusBar } from 'expo-status-bar';
import { Ionicons } from '@expo/vector-icons';
import { Typography, Button, Card } from '../../components/ui';
import { theme } from '../../theme';
import { ScreenProps } from '../../navigation/types';

interface QuickAction {
  id: string;
  title: string;
  description: string;
  icon: keyof typeof Ionicons.glyphMap;
  category: string;
}

const quickActions: QuickAction[] = [
  {
    id: '1',
    title: 'Track My Booking',
    description: 'Check status and location',
    icon: 'location-outline',
    category: 'booking',
  },
  {
    id: '2',
    title: 'Payment Issue',
    description: 'Charges, refunds, methods',
    icon: 'card-outline',
    category: 'payment',
  },
  {
    id: '3',
    title: 'Cancel Booking',
    description: 'Cancel or reschedule',
    icon: 'close-circle-outline',
    category: 'booking',
  },
  {
    id: '4',
    title: 'Service Question',
    description: "What's included?",
    icon: 'help-circle-outline',
    category: 'general',
  },
  {
    id: '5',
    title: 'Account Help',
    description: 'Profile, addresses, settings',
    icon: 'person-outline',
    category: 'account',
  },
  {
    id: '6',
    title: 'App Not Working',
    description: 'Technical issues',
    icon: 'bug-outline',
    category: 'technical',
  },
];

export const SupportScreen: React.FC<ScreenProps<'Support'>> = ({ navigation }) => {
  const [selectedCategory, setSelectedCategory] = useState<string | null>(null);

  const handleQuickAction = (action: QuickAction) => {
    // Navigate to chat with pre-selected category
    navigation.navigate('Chat', { 
      category: action.category,
      initialMessage: action.title 
    });
  };

  const handleStartChat = () => {
    navigation.navigate('Chat', {});
  };

  const handleEmailSupport = () => {
    Alert.alert(
      'Email Support',
      'Send us an email at support@homeheros.com and we\'ll get back to you within 24 hours.',
      [
        { text: 'Cancel', style: 'cancel' },
        { text: 'Open Email', onPress: () => {} }
      ]
    );
  };

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar style="dark" backgroundColor={theme.colors.background.primary} />
      
      {/* Header */}
      <View style={styles.header}>
        <TouchableOpacity
          style={styles.backButton}
          onPress={() => navigation.goBack()}
        >
          <Ionicons name="arrow-back" size={24} color={theme.colors.text.primary} />
        </TouchableOpacity>
        
        <View style={styles.headerContent}>
          <Typography variant="h5" weight="semibold" align="center">
            Help & Support
          </Typography>
        </View>
        
        <View style={styles.headerSpacer} />
      </View>

      <ScrollView 
        style={styles.scrollView}
        contentContainerStyle={styles.scrollContent}
        showsVerticalScrollIndicator={false}
      >
        {/* Hero Section */}
        <Card variant="default" padding="lg" style={styles.heroCard}>
          <View style={styles.heroIcon}>
            <Ionicons name="chatbubbles" size={48} color={theme.colors.primary.main} />
          </View>
          <Typography variant="h5" weight="semibold" align="center" style={styles.heroTitle}>
            How can we help you?
          </Typography>
          <Typography variant="body1" color="secondary" align="center" style={styles.heroDescription}>
            Get instant help with our AI assistant or connect with our support team
          </Typography>
          
          <Button
            title="Start Chat"
            onPress={handleStartChat}
            style={styles.startChatButton}
          />
        </Card>

        {/* Quick Actions */}
        <View style={styles.section}>
          <Typography variant="h6" weight="semibold" style={styles.sectionTitle}>
            Quick Help
          </Typography>
          <Typography variant="body2" color="secondary" style={styles.sectionDescription}>
            Tap a topic to get instant answers
          </Typography>
          
          <View style={styles.quickActionsList}>
            {quickActions.map((action) => (
              <TouchableOpacity
                key={action.id}
                onPress={() => handleQuickAction(action)}
                activeOpacity={0.7}
              >
                <Card variant="outlined" padding="md" style={styles.quickActionItem}>
                  <View style={styles.quickActionContent}>
                    <View style={[styles.quickActionIconSmall, { backgroundColor: `${theme.colors.primary.main}15` }]}>
                      <Ionicons name={action.icon} size={20} color={theme.colors.primary.main} />
                    </View>
                    <View style={styles.quickActionText}>
                      <Typography variant="body1" weight="semibold">
                        {action.title}
                      </Typography>
                      <Typography variant="body2" color="secondary">
                        {action.description}
                      </Typography>
                    </View>
                    <Ionicons name="chevron-forward" size={20} color={theme.colors.text.secondary} />
                  </View>
                </Card>
              </TouchableOpacity>
            ))}
          </View>
        </View>

        {/* Contact Options */}
        <View style={styles.section}>
          <Typography variant="h6" weight="semibold" style={styles.sectionTitle}>
            Other Ways to Reach Us
          </Typography>
          
          <TouchableOpacity onPress={handleEmailSupport}>
            <Card variant="outlined" padding="md" style={styles.contactCard}>
              <View style={styles.contactCardContent}>
                <View style={[styles.contactIcon, { backgroundColor: `${theme.colors.info.main}15` }]}>
                  <Ionicons name="mail-outline" size={24} color={theme.colors.info.main} />
                </View>
                <View style={styles.contactInfo}>
                  <Typography variant="body1" weight="semibold">
                    Email Support
                  </Typography>
                  <Typography variant="body2" color="secondary">
                    Response within 24 hours
                  </Typography>
                </View>
                <Ionicons name="chevron-forward" size={20} color={theme.colors.text.secondary} />
              </View>
            </Card>
          </TouchableOpacity>

          <Card variant="outlined" padding="md" style={styles.contactCard}>
            <View style={styles.contactCardContent}>
              <View style={[styles.contactIcon, { backgroundColor: `${theme.colors.success.main}15` }]}>
                <Ionicons name="call-outline" size={24} color={theme.colors.success.main} />
              </View>
              <View style={styles.contactInfo}>
                <Typography variant="body1" weight="semibold">
                  Phone Support
                </Typography>
                <Typography variant="body2" color="secondary">
                  Mon-Fri, 9AM-6PM EST
                </Typography>
              </View>
              <Typography variant="body2" color="brand" weight="medium">
                1-800-HEROES
              </Typography>
            </View>
          </Card>
        </View>

        {/* FAQ Preview */}
        <View style={styles.section}>
          <Typography variant="h6" weight="semibold" style={styles.sectionTitle}>
            Common Questions
          </Typography>
          
          <Card variant="outlined" padding="sm" style={styles.faqCard}>
            <TouchableOpacity style={styles.faqItem}>
              <Typography variant="body2" weight="medium">
                How do I cancel or reschedule a booking?
              </Typography>
              <Ionicons name="chevron-forward" size={16} color={theme.colors.text.secondary} />
            </TouchableOpacity>
          </Card>

          <Card variant="outlined" padding="sm" style={styles.faqCard}>
            <TouchableOpacity style={styles.faqItem}>
              <Typography variant="body2" weight="medium">
                What payment methods do you accept?
              </Typography>
              <Ionicons name="chevron-forward" size={16} color={theme.colors.text.secondary} />
            </TouchableOpacity>
          </Card>

          <Card variant="outlined" padding="sm" style={styles.faqCard}>
            <TouchableOpacity style={styles.faqItem}>
              <Typography variant="body2" weight="medium">
                How do I track my service provider?
              </Typography>
              <Ionicons name="chevron-forward" size={16} color={theme.colors.text.secondary} />
            </TouchableOpacity>
          </Card>
        </View>
      </ScrollView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: theme.colors.background.primary,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: theme.semanticSpacing.md,
    paddingVertical: theme.semanticSpacing.md,
    borderBottomWidth: 1,
    borderBottomColor: theme.colors.border.light,
  },
  backButton: {
    marginRight: theme.semanticSpacing.sm,
    padding: theme.semanticSpacing.xs,
  },
  headerContent: {
    flex: 1,
    alignItems: 'center',
  },
  headerSpacer: {
    width: 40,
  },
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    padding: theme.semanticSpacing.screenPadding,
    paddingBottom: theme.semanticSpacing.xl,
  },
  heroCard: {
    alignItems: 'center',
    marginBottom: theme.semanticSpacing.lg,
    ...theme.shadows.md,
  },
  heroIcon: {
    width: 80,
    height: 80,
    borderRadius: 40,
    backgroundColor: `${theme.colors.primary.main}15`,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: theme.semanticSpacing.md,
  },
  heroTitle: {
    marginBottom: theme.semanticSpacing.sm,
  },
  heroDescription: {
    marginBottom: theme.semanticSpacing.lg,
  },
  startChatButton: {
    width: '100%',
  },
  section: {
    marginBottom: theme.semanticSpacing.xl,
  },
  sectionTitle: {
    marginBottom: theme.semanticSpacing.xs,
  },
  sectionDescription: {
    marginBottom: theme.semanticSpacing.md,
  },
  quickActionsList: {
    gap: theme.semanticSpacing.sm,
  },
  quickActionItem: {
    marginBottom: theme.semanticSpacing.sm,
  },
  quickActionContent: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: theme.semanticSpacing.md,
  },
  quickActionIconSmall: {
    width: 40,
    height: 40,
    borderRadius: 20,
    justifyContent: 'center',
    alignItems: 'center',
  },
  quickActionText: {
    flex: 1,
  },
  contactCard: {
    marginBottom: theme.semanticSpacing.md,
  },
  contactCardContent: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  contactIcon: {
    width: 48,
    height: 48,
    borderRadius: 24,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: theme.semanticSpacing.md,
  },
  contactInfo: {
    flex: 1,
  },
  faqCard: {
    marginBottom: theme.semanticSpacing.sm,
  },
  faqItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: theme.semanticSpacing.sm,
  },
});
