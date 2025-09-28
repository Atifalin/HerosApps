import React from 'react';
import {
  View,
  StyleSheet,
  ScrollView,
  Image,
  TouchableOpacity,
  Dimensions,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { Typography, Button, Card } from '../../components/ui';
import { theme } from '../../theme';
import { NativeStackScreenProps } from '@react-navigation/native-stack';
import { ParamListBase } from '@react-navigation/native';

interface SubCategory {
  id: string;
  name: string;
  description: string;
  price?: string;
  icon?: keyof typeof Ionicons.glyphMap;
}

// Define the route params interface
interface ServiceDetailRouteParams {
  service: {
    id: string;
    name: string;
    icon: keyof typeof Ionicons.glyphMap;
    color: string;
    description: string;
    image: any;
    subcategories: SubCategory[];
  };
}

// Extend ParamListBase to include our route params
type ExtendedParamList = ParamListBase & {
  ServiceDetail: ServiceDetailRouteParams;
};

type ServiceDetailScreenProps = NativeStackScreenProps<ExtendedParamList, 'ServiceDetail'>;

const { width: screenWidth } = Dimensions.get('window');

export const ServiceDetailScreen: React.FC<ServiceDetailScreenProps> = ({ route, navigation }) => {
  const { service } = route.params;

  const handleSubcategoryPress = (subcategory: SubCategory) => {
    // Navigate to subcategory detail or booking screen
    console.log(`Selected subcategory: ${subcategory.name}`);
    // TODO: Implement navigation to booking flow
  };

  return (
    <SafeAreaView style={styles.container}>
      <ScrollView showsVerticalScrollIndicator={false}>
        {/* Header with image and back button */}
        <View style={styles.imageContainer}>
          <Image source={service.image} style={styles.headerImage} resizeMode="cover" />
          <View style={styles.overlay}>
            <TouchableOpacity 
              style={styles.backButton}
              onPress={() => navigation.goBack()}
            >
              <Ionicons name="arrow-back" size={24} color={theme.colors.neutral.white} />
            </TouchableOpacity>
          </View>
        </View>

        {/* Service title and description */}
        <View style={styles.contentContainer}>
          <View style={styles.titleContainer}>
            <View style={[styles.iconContainer, { backgroundColor: service.color }]}>
              <Ionicons name={service.icon} size={28} color={theme.colors.neutral.white} />
            </View>
            <View style={styles.titleTextContainer}>
              <Typography variant="h4" weight="semibold" color="primary">
                {service.name}
              </Typography>
              <Typography variant="body1" color="secondary" style={styles.description}>
                {service.description}
              </Typography>
            </View>
          </View>

          {/* Subcategories */}
          <View style={styles.subcategoriesContainer}>
            <Typography variant="h5" weight="semibold" style={styles.sectionTitle}>
              Services We Offer
            </Typography>

            {service.subcategories.map((subcategory) => (
              <TouchableOpacity
                key={subcategory.id}
                style={styles.subcategoryCard}
                onPress={() => handleSubcategoryPress(subcategory)}
                activeOpacity={0.8}
              >
                <Card variant="default" padding="md" style={styles.subcategoryCardInner}>
                  <View style={styles.subcategoryContent}>
                    <View style={styles.subcategoryHeader}>
                      <Typography variant="h6" weight="semibold" color="primary">
                        {subcategory.name}
                      </Typography>
                      <Typography 
                        variant="body2" 
                        weight="semibold" 
                        color="brand"
                        style={styles.price}
                      >
                        {subcategory.price}
                      </Typography>
                    </View>
                    <Typography variant="body2" color="secondary" style={styles.subcategoryDescription}>
                      {subcategory.description}
                    </Typography>
                    <View style={styles.buttonContainer}>
                      <Button 
                        title="Book Now" 
                        size="sm"
                        variant="outline"
                        style={styles.bookButton}
                        buttonColor={service.color}
                        textStyle={{ color: service.color }}
                        onPress={() => handleSubcategoryPress(subcategory)}
                      />
                    </View>
                  </View>
                </Card>
              </TouchableOpacity>
            ))}
          </View>

          {/* Book service button */}
          <Button
            title="Book This Service"
            onPress={() => console.log('Book service pressed')}
            style={styles.bookServiceButton}
            buttonColor={service.color}
            fullWidth
          />
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
  imageContainer: {
    position: 'relative',
    height: 200,
    width: '100%',
  },
  headerImage: {
    width: '100%',
    height: '100%',
  },
  overlay: {
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    backgroundColor: 'rgba(0, 0, 0, 0.3)',
    justifyContent: 'flex-start',
    alignItems: 'flex-start',
    padding: theme.semanticSpacing.md,
  },
  backButton: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  contentContainer: {
    padding: theme.semanticSpacing.screenPadding,
  },
  titleContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: theme.semanticSpacing.lg,
  },
  iconContainer: {
    width: 56,
    height: 56,
    borderRadius: 28,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: theme.semanticSpacing.md,
    ...theme.shadows.md,
  },
  titleTextContainer: {
    flex: 1,
  },
  description: {
    marginTop: theme.semanticSpacing.xs,
  },
  subcategoriesContainer: {
    marginBottom: theme.semanticSpacing.xl,
  },
  sectionTitle: {
    marginBottom: theme.semanticSpacing.md,
  },
  subcategoryCard: {
    width: '100%',
    marginBottom: theme.semanticSpacing.md,
  },
  subcategoryCardInner: {
    width: '100%',
  },
  subcategoryContent: {
    width: '100%',
  },
  subcategoryHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: theme.semanticSpacing.xs,
  },
  price: {
    color: theme.colors.primary.main,
  },
  subcategoryDescription: {
    marginBottom: theme.semanticSpacing.sm,
  },
  buttonContainer: {
    alignItems: 'flex-start',
  },
  bookButton: {
    minWidth: 100,
    borderColor: theme.colors.primary.main,
  },
  bookServiceButton: {
    marginTop: theme.semanticSpacing.md,
  },
});
