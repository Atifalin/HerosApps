import React, { useState, useEffect } from 'react';
import {
  View,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Alert,
  ActivityIndicator,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { StatusBar } from 'expo-status-bar';
import { Ionicons } from '@expo/vector-icons';
import { Typography, Button, Card } from '../../components/ui';
import { theme } from '../../theme';
import { useAuth } from '../../contexts/AuthContext';
import { ScreenProps, Hero } from '../../navigation/types';
import { paymentService, PaymentMethod } from '../../services/paymentService';
import { supabase } from '../../lib/supabase';

// Heroes will be fetched from Supabase

export const BookingConfirmScreen: React.FC<ScreenProps<'BookingConfirm'>> = ({ 
  navigation, 
  route 
}) => {
  const { bookingRequest, pricing } = route.params;
  const { user } = useAuth();
  
  const [selectedHero, setSelectedHero] = useState<Hero | null>(null);
  const [paymentMethods, setPaymentMethods] = useState<PaymentMethod[]>([]);
  const [selectedPaymentMethod, setSelectedPaymentMethod] = useState<PaymentMethod | null>(null);
  const [loading, setLoading] = useState(false);
  const [loadingPaymentMethods, setLoadingPaymentMethods] = useState(true);
  const [availableHeroes, setAvailableHeroes] = useState<Hero[]>([]);
  const [loadingHeroes, setLoadingHeroes] = useState(true);

  useEffect(() => {
    loadPaymentMethods();
    loadAvailableHeroes();
  }, []);

  const loadAvailableHeroes = async () => {
    try {
      setLoadingHeroes(true);
      
      // Fetch heroes from Supabase (using 'heros' table)
      const { data: heroesData, error } = await supabase
        .from('heros')
        .select('*')
        .eq('status', 'active')
        .eq('verification_status', 'verified')
        .order('rating_avg', { ascending: false });

      if (error) {
        console.error('Error loading heroes:', error);
        return;
      }

      // Transform Supabase data to match Hero interface
      const transformedHeroes: Hero[] = heroesData.map((hero: any) => ({
        id: hero.id,
        name: hero.name,
        rating: parseFloat(hero.rating_avg) || 0,
        reviewCount: hero.rating_count || 0,
        avatar: hero.photo_url,
        skills: hero.skills || [], 
        isAvailable: hero.status === 'active',
        distance: Math.random() * 5 + 1, // Mock distance for now
        priceMultiplier: 1.0 + (Math.random() * 0.2 - 0.1), // Random multiplier between 0.9-1.1
        contractor_id: hero.contractor_id // Add contractor_id from database
      }));

      setAvailableHeroes(transformedHeroes);
    } catch (error) {
      console.error('Error fetching heroes:', error);
    } finally {
      setLoadingHeroes(false);
    }
  };

  const loadPaymentMethods = async () => {
    try {
      const methods = await paymentService.getPaymentMethods(user?.id || '');
      setPaymentMethods(methods);
      setSelectedPaymentMethod(methods.find(m => m.isDefault) || methods[0] || null);
    } catch (error) {
      console.error('Error loading payment methods:', error);
    } finally {
      setLoadingPaymentMethods(false);
    }
  };

  const handleHeroSelection = (hero: Hero) => {
    setSelectedHero(hero);
  };

  const handlePaymentMethodSelection = (method: PaymentMethod) => {
    setSelectedPaymentMethod(method);
  };

  const calculateFinalPricing = () => {
    const multiplier = selectedHero?.priceMultiplier ?? 1.0;
    
    // Use the actual base price from the booking request (which comes from database)
    const basePrice = pricing.basePrice;
    const adjustedBasePrice = basePrice * multiplier;
    const adjustedSubtotal = adjustedBasePrice + pricing.callOutFee + pricing.addOnTotal;
    const adjustedTax = adjustedSubtotal * 0.12;
    const adjustedTotal = adjustedSubtotal + adjustedTax;

    return {
      ...pricing,
      basePrice: adjustedBasePrice,
      subtotal: adjustedSubtotal,
      tax: adjustedTax,
      total: adjustedTotal
    };
  };

  const finalPricing = calculateFinalPricing();

  const handleConfirmBooking = async () => {
    if (!selectedHero) {
      Alert.alert('Error', 'Please select a service provider');
      return;
    }

    if (!selectedPaymentMethod) {
      Alert.alert('Error', 'Please select a payment method');
      return;
    }

    if (!user?.id) {
      Alert.alert('Error', 'User not authenticated');
      return;
    }

    setLoading(true);

    try {
      // 1. Create or get address first
      let addressId: string;
      
      // Check if using a saved address or need to create new one
      if (bookingRequest.addressId) {
        // Using existing saved address
        addressId = bookingRequest.addressId;
      } else {
        // Create new address from booking request
        const { data: newAddress, error: addressError } = await supabase
          .from('addresses')
          .insert({
            user_id: user.id,
            street: bookingRequest.address.street,
            line1: bookingRequest.address.street,
            city: bookingRequest.address.city,
            province: bookingRequest.address.province || 'ON',
            postal_code: bookingRequest.address.postalCode,
            label: bookingRequest.address.label || null,
            is_default: false,
          })
          .select()
          .single();

        if (addressError) {
          console.error('Address creation error:', addressError);
          Alert.alert('Error', 'Failed to save address. Please try again.');
          setLoading(false);
          return;
        }

        addressId = newAddress.id;
      }

      // 2. Create booking with proper IDs
      const bookingData = {
        customer_id: user.id,
        contractor_id: selectedHero.contractor_id || '550e8400-e29b-41d4-a716-446655440000',
        address_id: addressId,
        service_id: bookingRequest.serviceId,
        service_variant_id: bookingRequest.subcategoryId,
        service_name: bookingRequest.serviceName,
        variant_name: bookingRequest.variantName,
        hero_id: selectedHero.id,
        customer_phone: bookingRequest.phoneNumber,
        status: 'requested',
        scheduled_at: new Date(bookingRequest.scheduledDate).toISOString(),
        duration_min: bookingRequest.duration,
        price_cents: Math.round(finalPricing.total * 100),
        currency: 'CAD',
        notes: bookingRequest.specialInstructions,
      };

      const { data: booking, error: bookingError } = await supabase
        .from('bookings')
        .insert(bookingData)
        .select()
        .single();

      if (bookingError) {
        console.error('Booking creation error:', bookingError);
        Alert.alert('Error', 'Failed to create booking. Please try again.');
        return;
      }

      // 2. Create payment intent with proper booking ID
      const paymentResult = await paymentService.createPaymentIntent(
        Math.round(finalPricing.total * 100), // Convert to cents
        'cad',
        selectedPaymentMethod.id,
        booking.id
      );

      if (!paymentResult.success) {
        Alert.alert('Payment Error', paymentResult.error || 'Payment authorization failed');
        return;
      }

      // 3. Update payment record with booking ID
      await supabase
        .from('payments')
        .update({ booking_id: booking.id })
        .eq('payment_intent_id', paymentResult.paymentIntent?.id);

      // 4. Create initial status history
      try {
        await supabase
          .from('booking_status_history')
          .insert({
            booking_id: booking.id,
            status: 'requested',
            notes: 'Booking created and payment authorized'
            // created_by is now nullable
          });
      } catch (historyError) {
        console.error('Error creating booking history:', historyError);
        // Continue even if history creation fails
      }

      // Navigate to booking status screen
      console.log('Navigating to BookingStatus with ID:', booking.id);
      navigation.reset({
        index: 0,
        routes: [{ name: 'MainTabs' }]
      });
      
      // Use a slight delay to ensure navigation completes before showing the booking status
      setTimeout(() => {
        navigation.navigate('BookingStatus', { bookingId: booking.id });
      }, 500);

    } catch (error) {
      console.error('Booking confirmation error:', error);
      Alert.alert('Error', 'Something went wrong. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const formatDate = (date: Date) => {
    try {
      return date.toLocaleDateString('en-CA', {
        weekday: 'long',
        year: 'numeric',
        month: 'long',
        day: 'numeric'
      });
    } catch (error) {
      console.error('Date formatting error:', error);
      return 'Date unavailable';
    }
  };

  const renderHeroCard = (hero: Hero) => (
    <TouchableOpacity
      key={hero.id}
      style={[
        styles.heroCard,
        selectedHero?.id === hero.id && styles.selectedHeroCard
      ]}
      onPress={() => handleHeroSelection(hero)}
    >
      <View style={styles.heroAvatar}>
        <Typography variant="h5" color="inverse" weight="semibold">
          {hero.name.split(' ').map(n => n[0]).join('')}
        </Typography>
      </View>
      
      <View style={styles.heroInfo}>
        <Typography variant="body1" weight="semibold">
          {hero.name}
        </Typography>
        
        <View style={styles.heroRating}>
          <Ionicons name="star" size={14} color="#FFD700" />
          <Typography variant="body2" weight="medium" style={styles.ratingText}>
            {hero.rating} ({hero.reviewCount} reviews)
          </Typography>
        </View>
        
        <Typography variant="caption" color="secondary">
          {hero.distance} km away
        </Typography>
      </View>
      
      <View style={styles.heroPrice}>
        {(hero.priceMultiplier ?? 1.0) !== 1.0 && (
          <Typography variant="caption" color={(hero.priceMultiplier ?? 1.0) > 1 ? 'error' : 'success'}>
            {(hero.priceMultiplier ?? 1.0) > 1 ? '+' : ''}{(((hero.priceMultiplier ?? 1.0) - 1) * 100).toFixed(0)}%
          </Typography>
        )}
        
        <View style={styles.heroSelection}>
          {selectedHero?.id === hero.id && (
            <Ionicons name="checkmark-circle" size={24} color={theme.colors.primary.main} />
          )}
        </View>
      </View>
    </TouchableOpacity>
  );

  const renderPaymentMethodCard = (method: PaymentMethod) => (
    <TouchableOpacity
      key={method.id}
      style={[
        styles.paymentCard,
        selectedPaymentMethod?.id === method.id && styles.selectedPaymentCard
      ]}
      onPress={() => handlePaymentMethodSelection(method)}
    >
      <View style={styles.paymentIcon}>
        <Ionicons 
          name={method.type === 'card' ? 'card-outline' : 'phone-portrait-outline'} 
          size={24} 
          color={theme.colors.primary.main} 
        />
      </View>
      
      <View style={styles.paymentInfo}>
        <Typography variant="body1" weight="medium">
          {method.brand?.toUpperCase()} •••• {method.last4}
        </Typography>
        <Typography variant="caption" color="secondary">
          Expires {method.expiryMonth?.toString().padStart(2, '0')}/{method.expiryYear}
        </Typography>
      </View>
      
      <View style={styles.paymentSelection}>
        {selectedPaymentMethod?.id === method.id && (
          <Ionicons name="checkmark-circle" size={20} color={theme.colors.primary.main} />
        )}
      </View>
    </TouchableOpacity>
  );

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
          <Typography variant="h5" weight="semibold">
            Confirm Booking
          </Typography>
          <Typography variant="body2" color="secondary">
            Review and confirm your service
          </Typography>
        </View>
      </View>

      <ScrollView 
        style={styles.scrollView}
        contentContainerStyle={styles.scrollContent}
        showsVerticalScrollIndicator={false}
      >
        {/* Booking Summary */}
        <Card variant="default" padding="md" style={styles.summaryCard}>
          <Typography variant="h6" weight="semibold" style={styles.sectionTitle}>
            Booking Summary
          </Typography>
          
          <View style={styles.summaryRow}>
            <Typography variant="body2" color="secondary">Date & Time</Typography>
            <Typography variant="body1" weight="medium">
              {bookingRequest.scheduledDate ? formatDate(new Date(bookingRequest.scheduledDate)) : 'Selected date'} at {bookingRequest.scheduledTime || 'selected time'}
            </Typography>
          </View>
          
          <View style={styles.summaryRow}>
            <Typography variant="body2" color="secondary">Address</Typography>
            <Typography variant="body1">
              {bookingRequest.address.street}, {bookingRequest.address.city}
            </Typography>
          </View>
          
          <View style={styles.summaryRow}>
            <Typography variant="body2" color="secondary">Duration</Typography>
            <Typography variant="body1">
              {Math.floor(bookingRequest.duration / 60)}h {bookingRequest.duration % 60}m
            </Typography>
          </View>
        </Card>

        {/* Hero Selection */}
        <Card variant="default" padding="md" style={styles.sectionCard}>
          <Typography variant="h6" weight="semibold" style={styles.sectionTitle}>
            Choose Your Service Provider
          </Typography>
          
          {loadingHeroes ? (
            <View style={styles.loadingContainer}>
              <ActivityIndicator size="small" color={theme.colors.primary.main} />
              <Typography variant="body2" color="secondary" style={styles.loadingText}>
                Loading available service providers...
              </Typography>
            </View>
          ) : availableHeroes.length > 0 ? (
            availableHeroes.map(renderHeroCard)
          ) : (
            <View style={styles.noHeroesContainer}>
              <Typography variant="body2" color="secondary">
                No service providers available at this time.
              </Typography>
            </View>
          )}
        </Card>

        {/* Payment Method */}
        <Card variant="default" padding="md" style={styles.sectionCard}>
          <Typography variant="h6" weight="semibold" style={styles.sectionTitle}>
            Payment Method
          </Typography>
          
          {loadingPaymentMethods ? (
            <View style={styles.loadingContainer}>
              <ActivityIndicator size="small" color={theme.colors.primary.main} />
              <Typography variant="body2" color="secondary" style={styles.loadingText}>
                Loading payment methods...
              </Typography>
            </View>
          ) : paymentMethods.length > 0 ? (
            paymentMethods.map(renderPaymentMethodCard)
          ) : (
            <View style={styles.noPaymentMethods}>
              <Typography variant="body2" color="secondary">
                No payment methods found. Using mock payment for demo.
              </Typography>
            </View>
          )}
        </Card>

        {/* Final Pricing */}
        <Card variant="default" padding="md" style={styles.pricingCard}>
          <Typography variant="h6" weight="semibold" style={styles.sectionTitle}>
            Final Pricing
          </Typography>
          
          <View style={styles.pricingRow}>
            <Typography variant="body1">Base Price</Typography>
            <Typography variant="body1">${finalPricing.basePrice.toFixed(2)}</Typography>
          </View>
          
          {finalPricing.callOutFee > 0 && (
            <View style={styles.pricingRow}>
              <Typography variant="body1">Call-out Fee</Typography>
              <Typography variant="body1">${finalPricing.callOutFee.toFixed(2)}</Typography>
            </View>
          )}
          
          {finalPricing.addOnTotal > 0 && (
            <View style={styles.pricingRow}>
              <Typography variant="body1">Add-ons</Typography>
              <Typography variant="body1">${finalPricing.addOnTotal.toFixed(2)}</Typography>
            </View>
          )}
          
          <View style={styles.pricingRow}>
            <Typography variant="body1">Subtotal</Typography>
            <Typography variant="body1">${finalPricing.subtotal.toFixed(2)}</Typography>
          </View>
          
          <View style={styles.pricingRow}>
            <Typography variant="body1">Tax (GST + PST)</Typography>
            <Typography variant="body1">${finalPricing.tax.toFixed(2)}</Typography>
          </View>
          
          <View style={[styles.pricingRow, styles.totalRow]}>
            <Typography variant="h6" weight="semibold">Total</Typography>
            <Typography variant="h6" weight="semibold" color="brand">
              ${finalPricing.total.toFixed(2)}
            </Typography>
          </View>
        </Card>
      </ScrollView>

      {/* Confirm Button */}
      <View style={styles.footer}>
        <Button
          title="Confirm & Pay"
          onPress={handleConfirmBooking}
          loading={loading}
          fullWidth
        />
      </View>
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
  },
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    padding: theme.semanticSpacing.screenPadding,
    paddingBottom: theme.semanticSpacing.xl,
  },
  summaryCard: {
    marginBottom: theme.semanticSpacing.md,
    ...theme.shadows.sm,
  },
  sectionCard: {
    marginBottom: theme.semanticSpacing.md,
    ...theme.shadows.sm,
  },
  sectionTitle: {
    marginBottom: theme.semanticSpacing.md,
  },
  summaryRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'flex-start',
    paddingVertical: theme.semanticSpacing.xs,
  },
  heroCard: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: theme.semanticSpacing.md,
    marginBottom: theme.semanticSpacing.sm,
    backgroundColor: theme.colors.background.secondary,
    borderRadius: theme.borderRadius.md,
    borderWidth: 2,
    borderColor: 'transparent',
  },
  selectedHeroCard: {
    borderColor: theme.colors.primary.main,
    backgroundColor: `${theme.colors.primary.main}05`,
  },
  heroAvatar: {
    width: 48,
    height: 48,
    borderRadius: 24,
    backgroundColor: theme.colors.primary.main,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: theme.semanticSpacing.md,
  },
  heroInfo: {
    flex: 1,
  },
  heroRating: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: 2,
  },
  ratingText: {
    marginLeft: 4,
  },
  heroPrice: {
    alignItems: 'flex-end',
  },
  heroSelection: {
    marginTop: theme.semanticSpacing.xs,
  },
  paymentCard: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: theme.semanticSpacing.md,
    marginBottom: theme.semanticSpacing.sm,
    backgroundColor: theme.colors.background.secondary,
    borderRadius: theme.borderRadius.md,
    borderWidth: 2,
    borderColor: 'transparent',
  },
  selectedPaymentCard: {
    borderColor: theme.colors.primary.main,
    backgroundColor: `${theme.colors.primary.main}05`,
  },
  paymentIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: `${theme.colors.primary.main}15`,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: theme.semanticSpacing.md,
  },
  paymentInfo: {
    flex: 1,
  },
  paymentSelection: {
    width: 24,
    height: 24,
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
  noPaymentMethods: {
    paddingVertical: theme.semanticSpacing.md,
    alignItems: 'center',
  },
  noHeroesContainer: {
    paddingVertical: theme.semanticSpacing.md,
    alignItems: 'center',
  },
  pricingCard: {
    ...theme.shadows.md,
  },
  pricingRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: theme.semanticSpacing.xs,
  },
  totalRow: {
    borderTopWidth: 1,
    borderTopColor: theme.colors.border.light,
    marginTop: theme.semanticSpacing.sm,
    paddingTop: theme.semanticSpacing.sm,
  },
  footer: {
    padding: theme.semanticSpacing.screenPadding,
    borderTopWidth: 1,
    borderTopColor: theme.colors.border.light,
    backgroundColor: theme.colors.background.primary,
  },
});
