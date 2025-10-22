import React, { useState, useEffect } from 'react';
import {
  View,
  StyleSheet,
  ScrollView,
  Image,
  TouchableOpacity,
  Dimensions,
  ActivityIndicator,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';
import { useFocusEffect } from '@react-navigation/native';
import { Typography, Button, Card } from '../../components/ui';
import { theme } from '../../theme';
import { serviceCatalog, getServiceById } from '../../data/serviceCatalog';
import { supabase } from '../../lib/supabase';

interface ServiceDetailScreenProps {
  navigation: any;
  route: {
    params: {
      service: {
        id: string;
        name: string;
        icon: string;
        color: string;
        description: string;
        image: any;
        subcategories: any[];
      };
    };
  };
}

const { width: screenWidth } = Dimensions.get('window');

export const ServiceDetailScreen: React.FC<ServiceDetailScreenProps> = ({ route, navigation }) => {
  const { service: initialService } = route.params;
  const [service, setService] = useState(initialService);
  const [loading, setLoading] = useState(false);

  // Fetch fresh service data from Supabase
  const fetchServiceData = async () => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('services')
        .select(`
          id,
          title,
          slug,
          icon,
          color,
          description,
          call_out_fee,
          min_duration,
          max_duration,
          service_variants (
            id,
            name,
            slug,
            description,
            base_price,
            default_duration
          )
        `)
        .eq('id', initialService.id)
        .eq('active', true)
        .single();

      if (error) {
        console.error('Error fetching service:', error);
        return;
      }

      if (data) {
        // Transform data to match expected format
        const transformedService = {
          id: data.id,
          name: data.title,
          icon: data.icon,
          color: data.color,
          description: data.description,
          image: initialService.image,
          callOutFee: data.call_out_fee > 0 ? `$${data.call_out_fee} call out fee` : 'No call-out fee',
          minDuration: data.min_duration,
          maxDuration: data.max_duration,
          subcategories: data.service_variants?.map((variant: any) => ({
            id: variant.id,
            name: variant.name,
            description: variant.description,
            price: variant.base_price ? `From $${(variant.base_price / 100).toFixed(0)}` : 'Custom pricing',
            duration: variant.default_duration,
            addOns: []
          })) || []
        };
        setService(transformedService);
      }
    } catch (error) {
      console.error('Error fetching service data:', error);
    } finally {
      setLoading(false);
    }
  };

  // Refresh data when screen comes into focus
  useFocusEffect(
    React.useCallback(() => {
      fetchServiceData();
    }, [initialService.id])
  );

  const handleSubcategoryPress = (subcategory: any) => {
    // Navigate to booking screen
    const fullService = getServiceById(service.id) || service;
    navigation.navigate('Booking', { 
      service: fullService, 
      subcategory 
    });
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
              <Ionicons name={service.icon as any} size={32} color={theme.colors.neutral.white} />
            </View>
            <View style={styles.titleTextContainer}>
              <Typography variant="h4" weight="semibold" color="primary">
                {service.name}
              </Typography>
              <Typography variant="body1" color="secondary">
                {service.description}
              </Typography>
            </View>
          </View>

          {/* Subcategories */}
          <View style={styles.subcategoriesContainer}>
            <Typography variant="h5" weight="semibold" style={styles.sectionTitle}>
              Services We Offer
            </Typography>

            {loading && (
              <View style={styles.loadingContainer}>
                <ActivityIndicator size="small" color={theme.colors.primary.main} />
                <Typography variant="body2" color="secondary" style={styles.loadingText}>
                  Updating prices...
                </Typography>
              </View>
            )}

            {service.subcategories && service.subcategories.length > 0 ? (
              service.subcategories.map((subcategory) => (
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
            ))
            ) : (
              !loading && (
                <Typography variant="body2" color="secondary" style={styles.noSubcategories}>
                  No services available at the moment.
                </Typography>
              )
            )}
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
    marginTop: 4,
  },
  loadingContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: theme.semanticSpacing.md,
  },
  loadingText: {
    marginLeft: theme.semanticSpacing.sm,
  },
  noSubcategories: {
    textAlign: 'center',
    paddingVertical: theme.semanticSpacing.xl,
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
