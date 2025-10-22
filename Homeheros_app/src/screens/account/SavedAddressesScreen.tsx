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
import { Typography, Button, Card, Input } from '../../components/ui';
import { theme } from '../../theme';
import { useAuth } from '../../contexts/AuthContext';
import { supabase } from '../../lib/supabase';

interface Address {
  id: string;
  label: string;
  street: string;
  city: string;
  province: string;
  postal_code: string;
  is_default: boolean;
  created_at: string;
}

interface SavedAddressesScreenProps {
  navigation: any;
}

export const SavedAddressesScreen: React.FC<SavedAddressesScreenProps> = ({ navigation }) => {
  const { user } = useAuth();
  const [addresses, setAddresses] = useState<Address[]>([]);
  const [loading, setLoading] = useState(true);
  const [showAddForm, setShowAddForm] = useState(false);
  const [newAddress, setNewAddress] = useState({
    label: '',
    street: '',
    city: '',
    province: 'ON',
    postal_code: '',
  });

  useEffect(() => {
    fetchAddresses();
  }, []);

  const fetchAddresses = async () => {
    if (!user?.id) return;

    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('addresses')
        .select('*')
        .eq('user_id', user.id)
        .order('created_at', { ascending: false });

      if (error) {
        // Gracefully handle missing column error
        if (error.code === '42703') {
          console.log('Addresses table schema needs update. Please restart the app.');
          Alert.alert(
            'Update Required',
            'Please restart the app to use saved addresses feature.',
            [{ text: 'OK' }]
          );
          setAddresses([]);
          return;
        }
        console.error('Error fetching addresses:', error);
        Alert.alert('Error', 'Failed to load addresses');
        return;
      }

      setAddresses(data || []);
    } catch (error) {
      console.error('Error:', error);
      setAddresses([]);
    } finally {
      setLoading(false);
    }
  };

  const handleAddAddress = async () => {
    if (!user?.id) return;

    // Validation
    if (!newAddress.street.trim() || !newAddress.city.trim() || !newAddress.postal_code.trim()) {
      Alert.alert('Error', 'Please fill in all required fields');
      return;
    }

    try {
      const { data, error } = await supabase
        .from('addresses')
        .insert({
          user_id: user.id,
          label: newAddress.label || 'Home',
          street: newAddress.street,
          city: newAddress.city,
          province: newAddress.province,
          postal_code: newAddress.postal_code,
          is_default: addresses.length === 0, // First address is default
        })
        .select()
        .single();

      if (error) {
        console.error('Error adding address:', error);
        Alert.alert('Error', 'Failed to add address');
        return;
      }

      setAddresses([data, ...addresses]);
      setShowAddForm(false);
      setNewAddress({
        label: '',
        street: '',
        city: '',
        province: 'ON',
        postal_code: '',
      });
      Alert.alert('Success', 'Address added successfully');
    } catch (error) {
      console.error('Error:', error);
    }
  };

  const handleSetDefault = async (addressId: string) => {
    if (!user?.id) return;

    try {
      // First, unset all defaults
      await supabase
        .from('addresses')
        .update({ is_default: false })
        .eq('user_id', user.id);

      // Then set the selected one as default
      const { error } = await supabase
        .from('addresses')
        .update({ is_default: true })
        .eq('id', addressId);

      if (error) {
        console.error('Error setting default:', error);
        Alert.alert('Error', 'Failed to set default address');
        return;
      }

      fetchAddresses();
    } catch (error) {
      console.error('Error:', error);
    }
  };

  const handleDeleteAddress = async (addressId: string) => {
    Alert.alert(
      'Delete Address',
      'Are you sure you want to delete this address?',
      [
        { text: 'Cancel', style: 'cancel' },
        {
          text: 'Delete',
          style: 'destructive',
          onPress: async () => {
            try {
              const { error } = await supabase
                .from('addresses')
                .delete()
                .eq('id', addressId);

              if (error) {
                console.error('Error deleting address:', error);
                Alert.alert('Error', 'Failed to delete address');
                return;
              }

              setAddresses(addresses.filter(a => a.id !== addressId));
            } catch (error) {
              console.error('Error:', error);
            }
          },
        },
      ]
    );
  };

  const renderAddress = (address: Address) => (
    <Card key={address.id} variant="default" padding="md" style={styles.addressCard}>
      <View style={styles.addressHeader}>
        <View style={styles.addressLabelContainer}>
          <Ionicons 
            name={address.is_default ? 'star' : 'star-outline'} 
            size={20} 
            color={address.is_default ? theme.colors.status.warning : theme.colors.text.secondary} 
          />
          <Typography variant="h6" weight="semibold" style={styles.addressLabel}>
            {address.label || 'Address'}
          </Typography>
        </View>
        <TouchableOpacity onPress={() => handleDeleteAddress(address.id)}>
          <Ionicons name="trash-outline" size={20} color={theme.colors.status.error} />
        </TouchableOpacity>
      </View>

      <View style={styles.addressDetails}>
        <Typography variant="body1">{address.street}</Typography>
        <Typography variant="body2" color="secondary">
          {address.city}, {address.province} {address.postal_code}
        </Typography>
      </View>

      {!address.is_default && (
        <Button
          title="Set as Default"
          variant="outline"
          size="sm"
          onPress={() => handleSetDefault(address.id)}
          style={styles.setDefaultButton}
        />
      )}
      {address.is_default && (
        <View style={styles.defaultBadge}>
          <Typography variant="caption" color="inverse">
            Default
          </Typography>
        </View>
      )}
    </Card>
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
        <Typography variant="h5" weight="semibold">
          Saved Addresses
        </Typography>
        <View style={styles.headerRight} />
      </View>

      <ScrollView
        style={styles.scrollView}
        contentContainerStyle={styles.scrollContent}
        showsVerticalScrollIndicator={false}
      >
        {loading ? (
          <View style={styles.loadingContainer}>
            <ActivityIndicator size="large" color={theme.colors.primary.main} />
          </View>
        ) : (
          <>
            {/* Add New Address Form */}
            {showAddForm ? (
              <Card variant="default" padding="md" style={styles.formCard}>
                <Typography variant="h6" weight="semibold" style={styles.formTitle}>
                  Add New Address
                </Typography>

                <Input
                  placeholder="Label (e.g., Home, Work)"
                  value={newAddress.label}
                  onChangeText={(text) => setNewAddress({ ...newAddress, label: text })}
                  leftIcon="pricetag-outline"
                  style={styles.input}
                />

                <Input
                  placeholder="Street Address *"
                  value={newAddress.street}
                  onChangeText={(text) => setNewAddress({ ...newAddress, street: text })}
                  leftIcon="location-outline"
                  style={styles.input}
                />

                <Input
                  placeholder="City *"
                  value={newAddress.city}
                  onChangeText={(text) => setNewAddress({ ...newAddress, city: text })}
                  style={styles.input}
                />

                <View style={styles.row}>
                  <Input
                    placeholder="Province"
                    value={newAddress.province}
                    onChangeText={(text) => setNewAddress({ ...newAddress, province: text })}
                    containerStyle={styles.halfInput}
                    style={styles.input}
                  />
                  <Input
                    placeholder="Postal Code *"
                    value={newAddress.postal_code}
                    onChangeText={(text) => setNewAddress({ ...newAddress, postal_code: text })}
                    containerStyle={styles.halfInput}
                    style={styles.input}
                  />
                </View>

                <View style={styles.formButtons}>
                  <Button
                    title="Cancel"
                    variant="outline"
                    onPress={() => setShowAddForm(false)}
                    style={styles.formButton}
                  />
                  <Button
                    title="Save Address"
                    onPress={handleAddAddress}
                    style={styles.formButton}
                  />
                </View>
              </Card>
            ) : (
              <Button
                title="Add New Address"
                onPress={() => setShowAddForm(true)}
                style={styles.addButton}
                fullWidth
              />
            )}

            {/* Address List */}
            {addresses.length === 0 && !showAddForm ? (
              <View style={styles.emptyContainer}>
                <Ionicons name="location-outline" size={64} color={theme.colors.text.tertiary} />
                <Typography variant="h6" weight="medium" style={styles.emptyTitle}>
                  No Saved Addresses
                </Typography>
                <Typography variant="body2" color="secondary" align="center">
                  Add your addresses to make booking faster
                </Typography>
              </View>
            ) : (
              <View style={styles.addressList}>
                {addresses.map(renderAddress)}
              </View>
            )}
          </>
        )}
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
    justifyContent: 'space-between',
    paddingHorizontal: theme.semanticSpacing.screenPadding,
    paddingVertical: theme.semanticSpacing.md,
    borderBottomWidth: 1,
    borderBottomColor: theme.colors.border.light,
  },
  backButton: {
    padding: theme.semanticSpacing.xs,
  },
  headerRight: {
    width: 40,
  },
  scrollView: {
    flex: 1,
  },
  scrollContent: {
    padding: theme.semanticSpacing.screenPadding,
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingVertical: theme.semanticSpacing.xl,
  },
  addButton: {
    marginBottom: theme.semanticSpacing.md,
  },
  formCard: {
    marginBottom: theme.semanticSpacing.md,
  },
  formTitle: {
    marginBottom: theme.semanticSpacing.md,
  },
  input: {
    marginBottom: theme.semanticSpacing.sm,
  },
  row: {
    flexDirection: 'row',
    gap: theme.semanticSpacing.sm,
  },
  halfInput: {
    flex: 1,
  },
  formButtons: {
    flexDirection: 'row',
    gap: theme.semanticSpacing.sm,
    marginTop: theme.semanticSpacing.md,
  },
  formButton: {
    flex: 1,
  },
  addressList: {
    gap: theme.semanticSpacing.md,
  },
  addressCard: {
    marginBottom: theme.semanticSpacing.sm,
  },
  addressHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: theme.semanticSpacing.sm,
  },
  addressLabelContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: theme.semanticSpacing.xs,
  },
  addressLabel: {
    marginLeft: theme.semanticSpacing.xs,
  },
  addressDetails: {
    marginBottom: theme.semanticSpacing.sm,
  },
  setDefaultButton: {
    marginTop: theme.semanticSpacing.sm,
  },
  defaultBadge: {
    backgroundColor: theme.colors.status.success,
    paddingHorizontal: theme.semanticSpacing.sm,
    paddingVertical: 4,
    borderRadius: 12,
    alignSelf: 'flex-start',
    marginTop: theme.semanticSpacing.sm,
  },
  emptyContainer: {
    alignItems: 'center',
    paddingVertical: theme.semanticSpacing['3xl'],
  },
  emptyTitle: {
    marginTop: theme.semanticSpacing.md,
    marginBottom: theme.semanticSpacing.xs,
  },
});
