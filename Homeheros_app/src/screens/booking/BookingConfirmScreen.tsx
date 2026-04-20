import React, { useState, useEffect, useMemo } from 'react';
import {
  View,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Alert,
  ActivityIndicator,
  TextInput,
  Platform,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { StatusBar } from 'expo-status-bar';
import { Ionicons } from '@expo/vector-icons';
import { CardField, useConfirmPayment, CardFieldInput } from '@stripe/stripe-react-native';
import { Typography, Button, Card } from '../../components/ui';
import { theme } from '../../theme';
import { useAuth } from '../../contexts/AuthContext';
import { ScreenProps, Hero } from '../../navigation/types';
import { paymentService, PaymentMethod } from '../../services/paymentService';
import { supabase } from '../../lib/supabase';
import { STRIPE_CONFIG } from '../../config/stripe';
import { createStripePaymentIntent, updatePaymentStatus } from '../../services/stripeService';

// Heroes will be fetched from Supabase

export const BookingConfirmScreen: React.FC<ScreenProps<'BookingConfirm'>> = ({ 
  navigation, 
  route 
}) => {
  const { bookingRequest, pricing } = route.params;
  const { user } = useAuth();
  
  const [paymentMethods, setPaymentMethods] = useState<PaymentMethod[]>([]);
  const [selectedPaymentMethod, setSelectedPaymentMethod] = useState<PaymentMethod | null>(null);
  const [loading, setLoading] = useState(false);
  const [loadingPaymentMethods, setLoadingPaymentMethods] = useState(true);
  const [useRealPayment, setUseRealPayment] = useState(false);
  const [cardComplete, setCardComplete] = useState(false);
  const [stripeCardholderName, setStripeCardholderName] = useState('');
  const { confirmPayment, loading: stripeLoading } = useConfirmPayment();

  useEffect(() => {
    loadPaymentMethods();
  }, []);

  // Fetch add-on details for display
  const [addOnDetails, setAddOnDetails] = useState<Array<{id: string; name: string; price: number}>>([]);

  useEffect(() => {
    if (bookingRequest.addOns && bookingRequest.addOns.length > 0) {
      fetchAddOnDetails();
    }
  }, [bookingRequest.addOns]);

  const fetchAddOnDetails = async () => {
    try {
      const { data, error } = await supabase
        .from('add_ons')
        .select('id, name, price')
        .in('id', bookingRequest.addOns);

      if (!error && data) {
        setAddOnDetails(data.map(addOn => ({
          id: addOn.id,
          name: addOn.name,
          price: parseFloat(addOn.price) || 0
        })));
      }
    } catch (error) {
      console.error('Error fetching add-on details:', error);
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


  const handlePaymentMethodSelection = (method: PaymentMethod) => {
    setSelectedPaymentMethod(method);
  };

  // No hero price multiplier - use pricing as-is
  const finalPricing = pricing;

  const handleConfirmBooking = async () => {
    // If using real Stripe payment, validate card is complete
    if (useRealPayment) {
      if (!cardComplete) {
        Alert.alert('Card Error', 'Please enter complete card details');
        return;
      }
      if (!stripeCardholderName.trim()) {
        Alert.alert('Card Error', 'Cardholder name is required');
        return;
      }
    } else {
      // Payment method is optional for mock payment
      if (!selectedPaymentMethod && paymentMethods.length > 0) {
        Alert.alert('Error', 'Please select a payment method');
        return;
      }
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

      // 2. Create booking without hero assignment (will be assigned via admin tool)
      const bookingData = {
        customer_id: user.id,
        contractor_id: '550e8400-e29b-41d4-a716-446655440000', // Default contractor
        address_id: addressId,
        service_id: bookingRequest.serviceId,
        service_variant_id: bookingRequest.subcategoryId,
        service_name: bookingRequest.serviceName,
        variant_name: bookingRequest.variantName,
        hero_id: null, // No hero assigned yet - will be assigned via admin tool
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

      // 3. Process payment — either real Stripe or mock
      if (useRealPayment) {
        // Step A: Create PaymentIntent via Edge Function
        const stripeResult = await createStripePaymentIntent({
          amountCents: Math.round(finalPricing.total * 100),
          currency: 'cad',
          bookingId: booking.id,
          customerEmail: user.email || undefined,
        });

        if (!stripeResult.success || !stripeResult.clientSecret) {
          Alert.alert('Payment Error', stripeResult.error || 'Failed to create payment');
          return;
        }

        console.log('Stripe PaymentIntent created:', stripeResult.paymentIntentId);

        // Step B: Confirm the payment with the Stripe SDK using the card details
        const { paymentIntent, error: confirmError } = await confirmPayment(
          stripeResult.clientSecret,
          {
            paymentMethodType: 'Card',
            paymentMethodData: {
              billingDetails: {
                name: stripeCardholderName.trim(),
                email: user.email || undefined,
              },
            },
          }
        );

        if (confirmError) {
          console.error('Stripe confirm error:', confirmError);
          Alert.alert(
            'Payment Failed',
            confirmError.message || 'Your card was declined. Please try again.'
          );
          // Update payment status in DB
          if (stripeResult.paymentIntentId) {
            await updatePaymentStatus(stripeResult.paymentIntentId, 'failed');
          }
          return;
        }

        console.log('Stripe payment confirmed! Status:', paymentIntent?.status);

        // Step C: Update payment status in DB
        if (stripeResult.paymentIntentId && paymentIntent?.status) {
          await updatePaymentStatus(stripeResult.paymentIntentId, paymentIntent.status);
        }
      } else if (selectedPaymentMethod) {
        // Mock payment
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

        // Update payment record with booking ID
        await supabase
          .from('payments')
          .update({ booking_id: booking.id })
          .eq('payment_intent_id', paymentResult.paymentIntent?.id);
      } else {
        console.log('Mock payment - no payment method selected');
      }

      // 4. Insert add-ons if any were selected
      if (bookingRequest.addOns && bookingRequest.addOns.length > 0) {
        const { data: addOnDetails, error: addOnLookupError } = await supabase
          .from('add_ons')
          .select('id, price')
          .in('id', bookingRequest.addOns);

        if (addOnLookupError) {
          console.error('Error loading add-on pricing:', addOnLookupError);
        }

        const addOnPriceMap = new Map(
          (addOnDetails || []).map(addOn => [addOn.id, parseFloat(addOn.price) || 0])
        );

        const addOnInserts = bookingRequest.addOns.map(addOnId => {
          const unitPrice = addOnPriceMap.get(addOnId);
          const quantity = 1;

          if (unitPrice === undefined) {
            console.error(
              '[ADMIN FLAG] Missing price for add-on',
              addOnId,
              'during booking',
              booking.id
            );
          }

          const safeUnitPrice = unitPrice ?? 0;
          return {
            booking_id: booking.id,
            add_on_id: addOnId,
            quantity,
            unit_price: safeUnitPrice,
            total_price: safeUnitPrice * quantity
          };
        });

        const { error: addOnsError } = await supabase
          .from('booking_add_ons')
          .insert(addOnInserts);

        if (addOnsError) {
          console.error('Error inserting add-ons:', addOnsError);
          // Continue even if add-ons fail - booking is still created
        } else {
          console.log(`Inserted ${addOnInserts.length} add-ons for booking ${booking.id}`);
        }
      }

      // 5. Create initial status history
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

        {/* Hero Assignment Notice */}
        <Card variant="default" padding="md" style={styles.sectionCard}>
          <View style={styles.heroNotice}>
            <Ionicons name="information-circle" size={24} color={theme.colors.info.main} />
            <View style={styles.heroNoticeText}>
              <Typography variant="body1" weight="semibold">
                Service Provider Assignment
              </Typography>
              <Typography variant="body2" color="secondary">
                A qualified service provider will be assigned to your booking shortly after confirmation.
              </Typography>
            </View>
          </View>
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
              <View style={styles.mockPaymentNotice}>
                <Ionicons name="card-outline" size={32} color={theme.colors.warning.main} />
                <Typography variant="body1" weight="semibold" style={styles.mockPaymentTitle}>
                  Mock Payment
                </Typography>
                <Typography variant="body2" color="secondary" align="center">
                  Stripe integration coming soon. For now, bookings use mock payment processing.
                </Typography>
              </View>
            </View>
          )}
        </Card>

        {/* Real Stripe Payment (Preview) */}
        <Card variant="default" padding="md" style={styles.stripeCard}>
          <TouchableOpacity 
            style={styles.stripeCardHeader}
            onPress={() => setUseRealPayment(!useRealPayment)}
            activeOpacity={0.7}
          >
            <View style={styles.stripeCardHeaderLeft}>
              <View style={styles.stripeBadge}>
                <Ionicons name="flash" size={14} color="#fff" />
              </View>
              <View style={{ flex: 1 }}>
                <Typography variant="body1" weight="semibold">
                  Pay with Stripe
                </Typography>
                <Typography variant="caption" color="secondary">
                  Real payment processing (Test Mode)
                </Typography>
              </View>
            </View>
            <View style={[
              styles.stripeToggle,
              useRealPayment && styles.stripeToggleActive
            ]}>
              <View style={[
                styles.stripeToggleThumb,
                useRealPayment && styles.stripeToggleThumbActive
              ]} />
            </View>
          </TouchableOpacity>

          {useRealPayment && (
            <View style={styles.stripeFormContainer}>
              <View style={styles.stripeTestBanner}>
                <Ionicons name="information-circle" size={16} color="#635BFF" />
                <Typography variant="caption" style={styles.stripeTestText}>
                  Test mode — Use card 4242 4242 4242 4242
                </Typography>
              </View>

              <View style={styles.stripeInputGroup}>
                <Typography variant="caption" weight="medium" style={styles.stripeInputLabel}>
                  Cardholder Name
                </Typography>
                <TextInput
                  style={styles.stripeInput}
                  placeholder="John Doe"
                  placeholderTextColor="#9CA3AF"
                  value={stripeCardholderName}
                  onChangeText={setStripeCardholderName}
                  autoCapitalize="words"
                />
              </View>

              <View style={styles.stripeInputGroup}>
                <Typography variant="caption" weight="medium" style={styles.stripeInputLabel}>
                  Card Details
                </Typography>
                <CardField
                  postalCodeEnabled={false}
                  placeholders={{
                    number: '4242 4242 4242 4242',
                  }}
                  cardStyle={{
                    backgroundColor: '#FAFAFA',
                    textColor: '#1F2937',
                    borderWidth: 1,
                    borderColor: '#E5E7EB',
                    borderRadius: 10,
                    fontSize: 15,
                    placeholderColor: '#9CA3AF',
                  }}
                  style={styles.stripeCardField}
                  onCardChange={(cardDetails: CardFieldInput.Details) => {
                    setCardComplete(cardDetails.complete);
                  }}
                />
              </View>

              {cardComplete && (
                <View style={styles.stripeCardComplete}>
                  <Ionicons name="checkmark-circle" size={16} color="#10B981" />
                  <Typography variant="caption" style={{ color: '#10B981', marginLeft: 4 }}>
                    Card details complete
                  </Typography>
                </View>
              )}

              <View style={styles.stripePoweredBy}>
                <Ionicons name="lock-closed" size={12} color="#9CA3AF" />
                <Typography variant="caption" color="secondary" style={{ marginLeft: 4 }}>
                  Secured by Stripe
                </Typography>
              </View>
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

          {addOnDetails.length > 0 && (
            <View style={styles.addOnSummaryList}>
              {addOnDetails.map(addOn => (
                <View key={addOn.id} style={styles.addOnSummaryRow}>
                  <Typography variant="body2" color="secondary">
                    {addOn.name}
                  </Typography>
                  <Typography variant="body2" weight="medium">
                    +${(addOn.price || 0).toFixed(2)}
                  </Typography>
                </View>
              ))}
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
  heroNotice: {
    flexDirection: 'row',
    alignItems: 'flex-start',
    gap: theme.semanticSpacing.sm,
  },
  heroNoticeText: {
    flex: 1,
  },
  mockPaymentNotice: {
    alignItems: 'center',
    gap: theme.semanticSpacing.sm,
  },
  mockPaymentTitle: {
    marginTop: theme.semanticSpacing.xs,
  },
  addOnSummaryList: {
    marginTop: theme.semanticSpacing.xs,
    marginBottom: theme.semanticSpacing.sm,
    gap: theme.semanticSpacing.xs,
  },
  addOnSummaryRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  stripeCard: {
    marginBottom: theme.semanticSpacing.md,
    borderWidth: 1,
    borderColor: '#635BFF20',
    ...theme.shadows.sm,
  },
  stripeCardHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
  },
  stripeCardHeaderLeft: {
    flexDirection: 'row',
    alignItems: 'center',
    flex: 1,
    gap: 10,
  },
  stripeBadge: {
    width: 28,
    height: 28,
    borderRadius: 8,
    backgroundColor: '#635BFF',
    justifyContent: 'center',
    alignItems: 'center',
  },
  stripeToggle: {
    width: 44,
    height: 24,
    borderRadius: 12,
    backgroundColor: '#E5E7EB',
    padding: 2,
    justifyContent: 'center',
  },
  stripeToggleActive: {
    backgroundColor: '#635BFF',
  },
  stripeToggleThumb: {
    width: 20,
    height: 20,
    borderRadius: 10,
    backgroundColor: '#fff',
    ...Platform.select({
      ios: {
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 1 },
        shadowOpacity: 0.2,
        shadowRadius: 2,
      },
      android: {
        elevation: 2,
      },
    }),
  },
  stripeToggleThumbActive: {
    alignSelf: 'flex-end',
  },
  stripeFormContainer: {
    marginTop: theme.semanticSpacing.md,
    paddingTop: theme.semanticSpacing.md,
    borderTopWidth: 1,
    borderTopColor: '#635BFF15',
  },
  stripeTestBanner: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#635BFF10',
    paddingHorizontal: 12,
    paddingVertical: 8,
    borderRadius: 8,
    marginBottom: theme.semanticSpacing.md,
    gap: 6,
  },
  stripeTestText: {
    color: '#635BFF',
    flex: 1,
  },
  stripeInputGroup: {
    marginBottom: 12,
  },
  stripeInputLabel: {
    marginBottom: 6,
    color: '#6B7280',
  },
  stripeInput: {
    borderWidth: 1,
    borderColor: '#E5E7EB',
    borderRadius: 10,
    paddingHorizontal: 14,
    paddingVertical: Platform.OS === 'ios' ? 12 : 10,
    fontSize: 15,
    color: theme.colors.text.primary,
    backgroundColor: '#FAFAFA',
  },
  stripeCardField: {
    width: '100%',
    height: 50,
    marginVertical: 4,
  },
  stripeCardComplete: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
  },
  stripePoweredBy: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    marginTop: 4,
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
