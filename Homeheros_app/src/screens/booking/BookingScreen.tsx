import React, { useState, useEffect } from 'react';
import {
  View,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Alert,
  Platform,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { StatusBar } from 'expo-status-bar';
import { Ionicons } from '@expo/vector-icons';
import DateTimePicker from '@react-native-community/datetimepicker';
import { Typography, Button, Card, Input } from '../../components/ui';
import { theme } from '../../theme';
import { useLocation } from '../../contexts/LocationContext';
import { useAuth } from '../../contexts/AuthContext';
import { ScreenProps } from '../../navigation/types';
import { getAddOnsByCategory } from '../../data/serviceCatalog';
import { supabase } from '../../lib/supabase';

export const BookingScreen: React.FC<ScreenProps<'Booking'>> = ({ 
  navigation, 
  route 
}) => {
  const { service, subcategory } = route.params;
  const { currentCity } = useLocation();
  const { user } = useAuth();

  // Form state
  const [selectedDate, setSelectedDate] = useState(new Date());
  const [selectedTime, setSelectedTime] = useState(new Date());
  const [showDatePicker, setShowDatePicker] = useState(false);
  const [showTimePicker, setShowTimePicker] = useState(false);
  const [duration, setDuration] = useState(subcategory.duration || 120);
  const [selectedAddOns, setSelectedAddOns] = useState<string[]>([]);
  const [address, setAddress] = useState({
    street: '',
    city: currentCity,
    postalCode: '',
  });
  const [specialInstructions, setSpecialInstructions] = useState('');
  const [loading, setLoading] = useState(false);
  const [addOns, setAddOns] = useState<any[]>([]);
  const [loadingAddOns, setLoadingAddOns] = useState(true);

  // Fetch add-ons from Supabase
  useEffect(() => {
    fetchAddOns();
  }, [service.id]);

  const fetchAddOns = async () => {
    try {
      setLoadingAddOns(true);
      
      // Get the service UUID from the database using the slug
      const { data: serviceData, error: serviceError } = await supabase
        .from('services')
        .select('id')
        .eq('slug', service.id)
        .single();

      if (serviceError || !serviceData) {
        console.error('Error fetching service:', serviceError);
        setAddOns(getAddOnsByCategory(service.id)); // Fallback to static data
        return;
      }

      // Fetch add-ons for this service
      const { data: addOnsData, error: addOnsError } = await supabase
        .from('add_ons')
        .select('*')
        .eq('service_id', serviceData.id)
        .eq('is_active', true);

      if (addOnsError) {
        console.error('Error fetching add-ons:', addOnsError);
        setAddOns(getAddOnsByCategory(service.id)); // Fallback to static data
        return;
      }

      // Transform to match expected format
      const transformedAddOns = addOnsData.map((addOn: any) => ({
        id: addOn.id,
        name: addOn.name,
        description: addOn.description,
        price: parseFloat(addOn.price),
        category: addOn.category
      }));

      setAddOns(transformedAddOns);
    } catch (error) {
      console.error('Error fetching add-ons:', error);
      setAddOns(getAddOnsByCategory(service.id)); // Fallback to static data
    } finally {
      setLoadingAddOns(false);
    }
  };

  // Calculate pricing
  const calculatePricing = () => {
    // Get base price from subcategory (which comes from database)
    let basePrice = subcategory.price ? 
      parseFloat(subcategory.price.replace(/[^0-9.]/g, '')) || 150 : 150;
    
    let callOutFee = service.callOutFee?.includes('$') ? 
      parseFloat(service.callOutFee.replace(/[^0-9.]/g, '')) : 0;
    
    let addOnTotal = selectedAddOns.reduce((total, addOnId) => {
      const addOn = addOns.find(a => a.id === addOnId);
      return total + (addOn?.price || 0);
    }, 0);

    const subtotal = basePrice + callOutFee + addOnTotal;
    const tax = subtotal * 0.12; // 12% tax (GST + PST)
    const total = subtotal + tax;

    return {
      basePrice,
      callOutFee,
      addOnTotal,
      subtotal,
      tax,
      total
    };
  };

  const pricing = calculatePricing();

  const handleDateChange = (event: any, selectedDate?: Date) => {
    setShowDatePicker(false);
    if (selectedDate) {
      setSelectedDate(selectedDate);
    }
  };

  const handleTimeChange = (event: any, selectedTime?: Date) => {
    setShowTimePicker(false);
    if (selectedTime) {
      setSelectedTime(selectedTime);
    }
  };

  const toggleAddOn = (addOnId: string) => {
    setSelectedAddOns(prev => 
      prev.includes(addOnId) 
        ? prev.filter(id => id !== addOnId)
        : [...prev, addOnId]
    );
  };

  const validateForm = () => {
    if (!address.street.trim()) {
      Alert.alert('Error', 'Please enter your street address');
      return false;
    }
    if (!address.postalCode.trim()) {
      Alert.alert('Error', 'Please enter your postal code');
      return false;
    }
    
    const now = new Date();
    const bookingDateTime = new Date(selectedDate);
    bookingDateTime.setHours(selectedTime.getHours(), selectedTime.getMinutes());
    
    if (bookingDateTime <= now) {
      Alert.alert('Error', 'Please select a future date and time');
      return false;
    }

    return true;
  };

  const handleContinue = async () => {
    if (!validateForm()) return;
    
    setLoading(true);
    
    try {
      // Get the actual UUID for the service based on the slug
      const { data: serviceData, error: serviceError } = await supabase
        .from('services')
        .select('id')
        .eq('slug', service.id)
        .single();
        
      if (serviceError) {
        console.error('Error fetching service ID:', serviceError);
        Alert.alert('Error', 'Failed to prepare booking. Please try again.');
        setLoading(false);
        return;
      }
      
      // Get the actual UUID for the service variant based on the slug
      const { data: variantData, error: variantError } = await supabase
        .from('service_variants')
        .select('id')
        .eq('slug', subcategory.id)
        .single();
        
      if (variantError) {
        console.error('Error fetching variant ID:', variantError);
        Alert.alert('Error', 'Failed to prepare booking. Please try again.');
        setLoading(false);
        return;
      }

    const bookingRequest = {
      serviceId: serviceData.id, // Use the actual UUID
      subcategoryId: variantData.id, // Use the actual UUID
      serviceName: service.name, // Include the service name
      variantName: subcategory.name, // Include the variant name
      scheduledDate: selectedDate.toISOString(),
      scheduledTime: `${selectedTime.getHours().toString().padStart(2, '0')}:${selectedTime.getMinutes().toString().padStart(2, '0')}`,
      duration,
      address: {
        street: address.street,
        city: address.city,
        postalCode: address.postalCode,
      },
      addOns: selectedAddOns,
      specialInstructions: specialInstructions.trim() || undefined,
    };

    navigation.navigate('BookingConfirm', {
      bookingRequest,
      pricing,
      availableHeroes: [] // Will be populated in BookingConfirm screen
    });
    
    } catch (error) {
      console.error('Error preparing booking:', error);
      Alert.alert('Error', 'Something went wrong. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  const formatDate = (date: Date) => {
    return date.toLocaleDateString('en-CA', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    });
  };

  const formatTime = (time: Date) => {
    return time.toLocaleTimeString('en-CA', {
      hour: '2-digit',
      minute: '2-digit'
    });
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
          <Typography variant="h5" weight="semibold">
            Book {subcategory.name}
          </Typography>
          <Typography variant="body2" color="secondary">
            {service.name} • {currentCity}
          </Typography>
        </View>
      </View>

      <ScrollView 
        style={styles.scrollView}
        contentContainerStyle={styles.scrollContent}
        showsVerticalScrollIndicator={false}
      >
        {/* Service Summary */}
        <Card variant="default" padding="md" style={styles.summaryCard}>
          <View style={styles.serviceHeader}>
            <View style={[styles.serviceIcon, { backgroundColor: `${service.color}15` }]}>
              <Ionicons name={service.icon as any} size={24} color={service.color} />
            </View>
            <View style={styles.serviceInfo}>
              <Typography variant="h6" weight="semibold">
                {subcategory.name}
              </Typography>
              <Typography variant="body2" color="secondary">
                {subcategory.description}
              </Typography>
              <Typography variant="body2" color="brand" weight="medium">
                {subcategory.price}
              </Typography>
            </View>
          </View>
        </Card>

        {/* Date & Time Selection */}
        <Card variant="default" padding="md" style={styles.sectionCard}>
          <Typography variant="h6" weight="semibold" style={styles.sectionTitle}>
            When do you need this service?
          </Typography>
          
          <View style={styles.dateTimeContainer}>
            <TouchableOpacity
              style={styles.dateTimeButton}
              onPress={() => setShowDatePicker(true)}
            >
              <Ionicons name="calendar-outline" size={20} color={theme.colors.primary.main} />
              <View style={styles.dateTimeText}>
                <Typography variant="body2" color="secondary">Date</Typography>
                <Typography variant="body1" weight="medium">
                  {formatDate(selectedDate)}
                </Typography>
              </View>
            </TouchableOpacity>

            <TouchableOpacity
              style={styles.dateTimeButton}
              onPress={() => setShowTimePicker(true)}
            >
              <Ionicons name="time-outline" size={20} color={theme.colors.primary.main} />
              <View style={styles.dateTimeText}>
                <Typography variant="body2" color="secondary">Time</Typography>
                <Typography variant="body1" weight="medium">
                  {formatTime(selectedTime)}
                </Typography>
              </View>
            </TouchableOpacity>
          </View>

          {showDatePicker && (
            <DateTimePicker
              value={selectedDate}
              mode="date"
              display={Platform.OS === 'ios' ? 'spinner' : 'default'}
              onChange={handleDateChange}
              minimumDate={new Date()}
            />
          )}

          {showTimePicker && (
            <DateTimePicker
              value={selectedTime}
              mode="time"
              display={Platform.OS === 'ios' ? 'spinner' : 'default'}
              onChange={handleTimeChange}
            />
          )}
        </Card>

        {/* Address */}
        <Card variant="default" padding="md" style={styles.sectionCard}>
          <Typography variant="h6" weight="semibold" style={styles.sectionTitle}>
            Service Address
          </Typography>
          
          <Input
            placeholder="Street address"
            value={address.street}
            onChangeText={(text) => setAddress(prev => ({ ...prev, street: text }))}
            leftIcon="location-outline"
            style={styles.addressInput}
          />
          
          <View style={styles.addressRow}>
            <Input
              placeholder="City"
              value={address.city}
              onChangeText={(text) => setAddress(prev => ({ ...prev, city: text }))}
              containerStyle={styles.cityInput}
              style={styles.addressInput}
            />
            <Input
              placeholder="Postal Code"
              value={address.postalCode}
              onChangeText={(text) => setAddress(prev => ({ ...prev, postalCode: text }))}
              containerStyle={styles.postalInput}
              style={styles.addressInput}
            />
          </View>
        </Card>

        {/* Add-ons */}
        {addOns.length > 0 && (
          <Card variant="default" padding="md" style={styles.sectionCard}>
            <Typography variant="h6" weight="semibold" style={styles.sectionTitle}>
              Add-ons
            </Typography>
            
            {addOns.map((addOn) => (
              <TouchableOpacity
                key={addOn.id}
                style={styles.addOnItem}
                onPress={() => toggleAddOn(addOn.id)}
              >
                <View style={styles.addOnContent}>
                  <View style={styles.addOnInfo}>
                    <Typography variant="body1" weight="medium">
                      {addOn.name}
                    </Typography>
                    <Typography variant="body2" color="secondary">
                      {addOn.description}
                    </Typography>
                  </View>
                  <View style={styles.addOnPrice}>
                    <Typography variant="body1" weight="semibold" color="brand">
                      +${addOn.price}
                    </Typography>
                  </View>
                </View>
                <View style={styles.checkbox}>
                  {selectedAddOns.includes(addOn.id) && (
                    <Ionicons name="checkmark" size={16} color={theme.colors.primary.main} />
                  )}
                </View>
              </TouchableOpacity>
            ))}
          </Card>
        )}

        {/* Special Instructions */}
        <Card variant="default" padding="md" style={styles.sectionCard}>
          <Typography variant="h6" weight="semibold" style={styles.sectionTitle}>
            Special Instructions (Optional)
          </Typography>
          
          <Input
            placeholder="Any specific requirements or notes for the service provider..."
            value={specialInstructions}
            onChangeText={setSpecialInstructions}
            multiline
            numberOfLines={3}
            style={styles.instructionsInput}
          />
        </Card>

        {/* Pricing Summary */}
        <Card variant="default" padding="md" style={styles.pricingCard}>
          <Typography variant="h6" weight="semibold" style={styles.sectionTitle}>
            Pricing Summary
          </Typography>
          
          <View style={styles.pricingRow}>
            <Typography variant="body1">Base Price</Typography>
            <Typography variant="body1">${pricing.basePrice.toFixed(2)}</Typography>
          </View>
          
          {pricing.callOutFee > 0 && (
            <View style={styles.pricingRow}>
              <Typography variant="body1">Call-out Fee</Typography>
              <Typography variant="body1">${pricing.callOutFee.toFixed(2)}</Typography>
            </View>
          )}
          
          {pricing.addOnTotal > 0 && (
            <View style={styles.pricingRow}>
              <Typography variant="body1">Add-ons</Typography>
              <Typography variant="body1">${pricing.addOnTotal.toFixed(2)}</Typography>
            </View>
          )}
          
          <View style={styles.pricingRow}>
            <Typography variant="body1">Subtotal</Typography>
            <Typography variant="body1">${pricing.subtotal.toFixed(2)}</Typography>
          </View>
          
          <View style={styles.pricingRow}>
            <Typography variant="body1">Tax (GST + PST)</Typography>
            <Typography variant="body1">${pricing.tax.toFixed(2)}</Typography>
          </View>
          
          <View style={[styles.pricingRow, styles.totalRow]}>
            <Typography variant="h6" weight="semibold">Total</Typography>
            <Typography variant="h6" weight="semibold" color="brand">
              ${pricing.total.toFixed(2)}
            </Typography>
          </View>
        </Card>
      </ScrollView>

      {/* Continue Button */}
      <View style={styles.footer}>
        <Button
          title="Continue to Confirmation"
          onPress={handleContinue}
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
  serviceHeader: {
    flexDirection: 'row',
    alignItems: 'center',
  },
  serviceIcon: {
    width: 48,
    height: 48,
    borderRadius: 24,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: theme.semanticSpacing.md,
  },
  serviceInfo: {
    flex: 1,
  },
  sectionCard: {
    marginBottom: theme.semanticSpacing.md,
    ...theme.shadows.sm,
  },
  sectionTitle: {
    marginBottom: theme.semanticSpacing.md,
  },
  dateTimeContainer: {
    flexDirection: 'row',
    gap: theme.semanticSpacing.md,
  },
  dateTimeButton: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    padding: theme.semanticSpacing.md,
    backgroundColor: theme.colors.background.secondary,
    borderRadius: theme.borderRadius.md,
    borderWidth: 1,
    borderColor: theme.colors.border.light,
  },
  dateTimeText: {
    marginLeft: theme.semanticSpacing.sm,
    flex: 1,
  },
  addressInput: {
    marginBottom: theme.semanticSpacing.sm,
  },
  addressRow: {
    flexDirection: 'row',
    gap: theme.semanticSpacing.sm,
  },
  cityInput: {
    flex: 1.5,
  },
  postalInput: {
    flex: 1,
    minWidth: 120,
  },
  addOnItem: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: theme.semanticSpacing.sm,
    borderBottomWidth: 1,
    borderBottomColor: theme.colors.border.light,
  },
  addOnContent: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
  },
  addOnInfo: {
    flex: 1,
  },
  addOnPrice: {
    marginLeft: theme.semanticSpacing.md,
  },
  checkbox: {
    width: 24,
    height: 24,
    borderRadius: 12,
    borderWidth: 2,
    borderColor: theme.colors.primary.main,
    justifyContent: 'center',
    alignItems: 'center',
    marginLeft: theme.semanticSpacing.sm,
  },
  instructionsInput: {
    minHeight: 80,
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
