import React, { useState } from 'react';
import {
  View,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Image,
  Alert,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { StatusBar } from 'expo-status-bar';
import { Ionicons } from '@expo/vector-icons';
import * as Clipboard from 'expo-clipboard';
import { Typography, Card, Button } from '../../components/ui';
import { theme } from '../../theme';
import { useLocation } from '../../contexts/LocationContext';

interface PromoItem {
  id: string;
  code: string;
  title: string;
  description: string;
  expiryDate: string;
  discount: string;
  image?: any;
  isNew?: boolean;
}

// Sample promo data
const promos: PromoItem[] = [
  {
    id: '1',
    code: 'WELCOME25',
    title: 'Welcome Bonus',
    description: 'Get 25% off your first booking with HomeHeros',
    expiryDate: '2025-12-31',
    discount: '25% off',
    isNew: true,
  },
  {
    id: '2',
    code: 'CLEAN15',
    title: 'Cleaning Special',
    description: '15% off any cleaning service this month',
    expiryDate: '2025-10-31',
    discount: '15% off',
  },
  {
    id: '3',
    code: 'REFER10',
    title: 'Refer a Friend',
    description: 'Get $10 credit when you refer a friend',
    expiryDate: 'No expiry',
    discount: '$10 credit',
  },
];

interface PromosScreenProps {
  navigation: any;
}

export const PromosScreen: React.FC<PromosScreenProps> = ({ navigation }) => {
  const { currentCity } = useLocation();
  const [copiedCode, setCopiedCode] = useState<string | null>(null);

  const handleCopyCode = async (code: string) => {
    try {
      await Clipboard.setStringAsync(code);
      setCopiedCode(code);
      Alert.alert('Copied!', `Promo code "${code}" copied to clipboard`);
      
      // Reset after 2 seconds
      setTimeout(() => setCopiedCode(null), 2000);
    } catch (error) {
      console.error('Failed to copy:', error);
      Alert.alert('Error', 'Failed to copy code');
    }
  };

  const handleApplyPromo = (promo: PromoItem) => {
    Alert.alert(
      'Apply Promo Code',
      `Would you like to use "${promo.code}" for your next booking?`,
      [
        { text: 'Cancel', style: 'cancel' },
        {
          text: 'Book Now',
          onPress: () => navigation.navigate('HomeTab'),
        },
      ]
    );
  };

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar style="dark" backgroundColor={theme.colors.background.primary} />
      
      {/* Header */}
      <View style={styles.header}>
        <Typography variant="h4" weight="semibold">
          Promotions
        </Typography>
        <Typography variant="body2" color="secondary">
          Special offers for {currentCity}
        </Typography>
      </View>
      
      <ScrollView 
        style={styles.scrollView}
        contentContainerStyle={styles.scrollContent}
        showsVerticalScrollIndicator={false}
      >
        {/* Featured Promo */}
        <Card variant="default" padding="none" style={styles.featuredCard}>
          <View style={styles.featuredContent}>
            <View style={styles.featuredTextContent}>
              <View style={styles.newBadge}>
                <Typography variant="caption" color="inverse" style={styles.newBadgeText}>
                  NEW
                </Typography>
              </View>
              <Typography variant="h5" weight="semibold" style={styles.featuredTitle}>
                25% OFF Your First Service
              </Typography>
              <Typography variant="body2" color="secondary" style={styles.featuredDescription}>
                Use code WELCOME25 on your first booking with any service provider
              </Typography>
              <View style={styles.featuredButtons}>
                <Button 
                  title={copiedCode === 'WELCOME25' ? 'Copied!' : 'Copy'}
                  size="sm"
                  variant={copiedCode === 'WELCOME25' ? 'outline' : 'primary'}
                  onPress={() => handleCopyCode('WELCOME25')}
                  style={styles.copyButton}
                />
                <Button 
                  title="Use Now" 
                  size="sm"
                  onPress={() => handleApplyPromo(promos[0])}
                  style={styles.useButton}
                />
              </View>
            </View>
            <View style={styles.featuredImageContainer}>
              <View style={styles.discountBadge}>
                <Typography variant="h6" weight="bold" color="inverse">
                  25%
                </Typography>
                <Typography variant="caption" color="inverse">
                  OFF
                </Typography>
              </View>
            </View>
          </View>
        </Card>
        
        {/* Available Promos */}
        <View style={styles.sectionHeader}>
          <Typography variant="h5" weight="semibold">
            Available Offers
          </Typography>
        </View>
        
        {promos.map((promo) => (
          <Card key={promo.id} variant="default" padding="md" style={styles.promoCard}>
            <View style={styles.promoHeader}>
              <View>
                <Typography variant="h6" weight="semibold">
                  {promo.title}
                </Typography>
                <Typography variant="caption" color="secondary">
                  Expires: {promo.expiryDate}
                </Typography>
              </View>
              <View style={styles.discountTag}>
                <Typography variant="body2" weight="semibold" color="brand">
                  {promo.discount}
                </Typography>
              </View>
            </View>
            
            <Typography variant="body2" color="secondary" style={styles.promoDescription}>
              {promo.description}
            </Typography>
            
            <View style={styles.promoFooter}>
              <View style={styles.codeContainer}>
                <Typography variant="body2" weight="medium">
                  {promo.code}
                </Typography>
              </View>
              <TouchableOpacity 
                style={styles.copyIcon}
                onPress={() => handleCopyCode(promo.code)}
              >
                <Ionicons 
                  name={copiedCode === promo.code ? 'checkmark-circle' : 'copy-outline'} 
                  size={20} 
                  color={copiedCode === promo.code ? theme.colors.status.success : theme.colors.primary.main} 
                />
              </TouchableOpacity>
              <Button
                title="Apply"
                size="sm"
                variant="outline"
                onPress={() => handleApplyPromo(promo)}
                style={styles.applyButton}
              />
            </View>
            
            {promo.isNew && (
              <View style={styles.newTag}>
                <Typography variant="caption" color="inverse" style={styles.newTagText}>
                  NEW
                </Typography>
              </View>
            )}
          </Card>
        ))}
        
        {/* Terms and Conditions */}
        <View style={styles.termsContainer}>
          <Typography variant="caption" color="secondary" align="center">
            * Promotions are subject to terms and conditions.
          </Typography>
          <Typography variant="caption" color="secondary" align="center">
            * Offers may vary by location and service category.
          </Typography>
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
    paddingHorizontal: theme.semanticSpacing.screenPadding,
    paddingVertical: theme.semanticSpacing.md,
    borderBottomWidth: 1,
    borderBottomColor: theme.colors.border.light,
  },
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    padding: theme.semanticSpacing.screenPadding,
    paddingBottom: theme.semanticSpacing.xl,
  },
  featuredCard: {
    marginBottom: theme.semanticSpacing.lg,
    overflow: 'hidden',
    ...theme.shadows.md,
  },
  featuredContent: {
    flexDirection: 'row',
    minHeight: 200,
    alignItems: 'stretch',
  },
  featuredTextContent: {
    flex: 1,
    paddingHorizontal: theme.semanticSpacing.md,
    paddingVertical: theme.semanticSpacing.md,
    justifyContent: 'center',
  },
  featuredTitle: {
    marginBottom: theme.semanticSpacing.xs,
  },
  featuredDescription: {
    marginBottom: theme.semanticSpacing.md,
    lineHeight: 20,
  },
  featuredImageContainer: {
    width: 120,
    backgroundColor: theme.colors.primary.main,
    justifyContent: 'center',
    alignItems: 'center',
    position: 'relative',
  },
  newBadge: {
    backgroundColor: theme.colors.status.success,
    paddingHorizontal: theme.semanticSpacing.sm,
    paddingVertical: theme.semanticSpacing.xs / 2,
    borderRadius: theme.borderRadius.sm,
    alignSelf: 'flex-start',
    marginBottom: theme.semanticSpacing.sm,
  },
  newBadgeText: {
    fontSize: 10,
    fontWeight: 'bold',
  },
  discountBadge: {
    width: 84,
    height: 84,
    borderRadius: 42,
    backgroundColor: 'rgba(255, 255, 255, 0.22)',
    borderWidth: 1,
    borderColor: 'rgba(255, 255, 255, 0.35)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  featuredButtons: {
    flexDirection: 'row',
    gap: theme.semanticSpacing.sm,
    marginTop: theme.semanticSpacing.xs,
  },
  copyButton: {
    flex: 1,
    minWidth: 0,
  },
  useButton: {
    flex: 1,
    minWidth: 0,
  },
  applyButton: {
    marginLeft: theme.semanticSpacing.xs,
  },
  sectionHeader: {
    marginBottom: theme.semanticSpacing.md,
    marginTop: theme.semanticSpacing.md,
  },
  promoCard: {
    marginBottom: theme.semanticSpacing.md,
    position: 'relative',
    ...theme.shadows.sm,
  },
  promoHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    marginBottom: theme.semanticSpacing.xs,
  },
  discountTag: {
    paddingHorizontal: theme.semanticSpacing.sm,
    paddingVertical: theme.semanticSpacing.xs / 2,
    borderRadius: theme.borderRadius.sm,
    backgroundColor: `${theme.colors.primary.main}15`,
  },
  promoDescription: {
    marginBottom: theme.semanticSpacing.sm,
  },
  promoFooter: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: theme.semanticSpacing.sm,
  },
  codeContainer: {
    backgroundColor: theme.colors.background.secondary,
    paddingHorizontal: theme.semanticSpacing.sm,
    paddingVertical: theme.semanticSpacing.xs,
    borderRadius: theme.borderRadius.sm,
    marginRight: theme.semanticSpacing.xs,
  },
  copyIcon: {
    padding: theme.semanticSpacing.xs,
  },
  newTag: {
    position: 'absolute',
    top: 0,
    right: 0,
    backgroundColor: theme.colors.status.success,
    paddingHorizontal: theme.semanticSpacing.sm,
    paddingVertical: 2,
    borderTopRightRadius: theme.borderRadius.md,
    borderBottomLeftRadius: theme.borderRadius.md,
  },
  newTagText: {
    fontSize: 10,
    fontWeight: 'bold',
  },
  termsContainer: {
    marginTop: theme.semanticSpacing.lg,
  },
});
