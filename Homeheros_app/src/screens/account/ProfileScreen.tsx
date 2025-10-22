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

interface ProfileScreenProps {
  navigation: any;
}

export const ProfileScreen: React.FC<ProfileScreenProps> = ({ navigation }) => {
  const { user, profile, signOut } = useAuth();
  const [loading, setLoading] = useState(false);
  const [editing, setEditing] = useState(false);
  const [formData, setFormData] = useState({
    name: profile?.name || '',
    phone: profile?.phone || '',
    email: user?.email || '',
  });

  useEffect(() => {
    if (profile) {
      setFormData({
        name: profile.name || '',
        phone: profile.phone || '',
        email: user?.email || '',
      });
    }
  }, [profile, user]);

  const handleSave = async () => {
    if (!user?.id) return;

    if (!formData.name.trim()) {
      Alert.alert('Error', 'Please enter your name');
      return;
    }

    setLoading(true);
    try {
      const { error } = await supabase
        .from('profiles')
        .update({
          name: formData.name.trim(),
          phone: formData.phone.trim() || null,
        })
        .eq('id', user.id);

      if (error) {
        console.error('Error updating profile:', error);
        Alert.alert('Error', 'Failed to update profile');
        return;
      }

      Alert.alert('Success', 'Profile updated successfully');
      setEditing(false);
    } catch (error) {
      console.error('Error:', error);
      Alert.alert('Error', 'Something went wrong');
    } finally {
      setLoading(false);
    }
  };

  const handleCancel = () => {
    setFormData({
      name: profile?.name || '',
      phone: profile?.phone || '',
      email: user?.email || '',
    });
    setEditing(false);
  };

  const handleSignOut = () => {
    Alert.alert(
      'Sign Out',
      'Are you sure you want to sign out?',
      [
        { text: 'Cancel', style: 'cancel' },
        {
          text: 'Sign Out',
          style: 'destructive',
          onPress: async () => {
            await signOut();
            navigation.replace('Login');
          },
        },
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
        <Typography variant="h5" weight="semibold">
          My Profile
        </Typography>
        <View style={styles.headerRight} />
      </View>

      <ScrollView
        style={styles.scrollView}
        contentContainerStyle={styles.scrollContent}
        showsVerticalScrollIndicator={false}
      >
        {/* Profile Avatar */}
        <View style={styles.avatarSection}>
          <View style={styles.avatar}>
            <Typography variant="h3" color="inverse" weight="semibold">
              {formData.name ? formData.name.charAt(0).toUpperCase() : user?.email?.charAt(0).toUpperCase() || 'U'}
            </Typography>
          </View>
          <Typography variant="h6" weight="semibold" style={styles.userName}>
            {formData.name || 'User'}
          </Typography>
          <Typography variant="body2" color="secondary">
            {formData.email}
          </Typography>
        </View>

        {/* Profile Information */}
        <Card variant="default" padding="md" style={styles.infoCard}>
          <View style={styles.cardHeader}>
            <Typography variant="h6" weight="semibold">
              Personal Information
            </Typography>
            {!editing && (
              <TouchableOpacity onPress={() => setEditing(true)}>
                <Ionicons name="create-outline" size={20} color={theme.colors.primary.main} />
              </TouchableOpacity>
            )}
          </View>

          <View style={styles.infoSection}>
            <Typography variant="body2" color="secondary" style={styles.label}>
              Full Name
            </Typography>
            {editing ? (
              <Input
                value={formData.name}
                onChangeText={(text) => setFormData({ ...formData, name: text })}
                placeholder="Enter your name"
                style={styles.input}
              />
            ) : (
              <Typography variant="body1" weight="medium">
                {formData.name || 'Not set'}
              </Typography>
            )}
          </View>

          <View style={styles.infoSection}>
            <Typography variant="body2" color="secondary" style={styles.label}>
              Email
            </Typography>
            <Typography variant="body1" weight="medium">
              {formData.email}
            </Typography>
            <Typography variant="caption" color="secondary">
              Email cannot be changed
            </Typography>
          </View>

          <View style={styles.infoSection}>
            <Typography variant="body2" color="secondary" style={styles.label}>
              Phone Number
            </Typography>
            {editing ? (
              <Input
                value={formData.phone}
                onChangeText={(text) => setFormData({ ...formData, phone: text })}
                placeholder="Enter your phone number"
                keyboardType="phone-pad"
                style={styles.input}
              />
            ) : (
              <Typography variant="body1" weight="medium">
                {formData.phone || 'Not set'}
              </Typography>
            )}
          </View>

          {editing && (
            <View style={styles.editButtons}>
              <Button
                title="Cancel"
                variant="outline"
                onPress={handleCancel}
                style={styles.editButton}
              />
              <Button
                title={loading ? 'Saving...' : 'Save Changes'}
                onPress={handleSave}
                disabled={loading}
                style={styles.editButton}
              />
            </View>
          )}
        </Card>

        {/* Account Actions */}
        <Card variant="default" padding="md" style={styles.actionsCard}>
          <Typography variant="h6" weight="semibold" style={styles.sectionTitle}>
            Account
          </Typography>

          <TouchableOpacity
            style={styles.actionItem}
            onPress={() => navigation.navigate('SavedAddresses')}
          >
            <View style={styles.actionLeft}>
              <Ionicons name="location-outline" size={20} color={theme.colors.text.primary} />
              <Typography variant="body1" style={styles.actionText}>
                Saved Addresses
              </Typography>
            </View>
            <Ionicons name="chevron-forward" size={20} color={theme.colors.text.secondary} />
          </TouchableOpacity>

          <TouchableOpacity
            style={styles.actionItem}
            onPress={() => navigation.navigate('BookingHistory')}
          >
            <View style={styles.actionLeft}>
              <Ionicons name="time-outline" size={20} color={theme.colors.text.primary} />
              <Typography variant="body1" style={styles.actionText}>
                Booking History
              </Typography>
            </View>
            <Ionicons name="chevron-forward" size={20} color={theme.colors.text.secondary} />
          </TouchableOpacity>

          <TouchableOpacity
            style={[styles.actionItem, styles.signOutItem]}
            onPress={handleSignOut}
          >
            <View style={styles.actionLeft}>
              <Ionicons name="log-out-outline" size={20} color={theme.colors.error.main} />
              <Typography variant="body1" color="error" style={styles.actionText}>
                Sign Out
              </Typography>
            </View>
            <Ionicons name="chevron-forward" size={20} color={theme.colors.error.main} />
          </TouchableOpacity>
        </Card>

        {/* App Version */}
        <Typography variant="caption" color="secondary" align="center" style={styles.version}>
          HomeHeros v1.0.0
        </Typography>
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
    paddingBottom: theme.semanticSpacing.xl,
  },
  avatarSection: {
    alignItems: 'center',
    paddingVertical: theme.semanticSpacing.xl,
  },
  avatar: {
    width: 100,
    height: 100,
    borderRadius: 50,
    backgroundColor: theme.colors.primary.main,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: theme.semanticSpacing.md,
  },
  userName: {
    marginBottom: 4,
  },
  infoCard: {
    marginBottom: theme.semanticSpacing.md,
  },
  cardHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: theme.semanticSpacing.md,
  },
  infoSection: {
    marginBottom: theme.semanticSpacing.md,
  },
  label: {
    marginBottom: 4,
  },
  input: {
    marginTop: 4,
  },
  editButtons: {
    flexDirection: 'row',
    gap: theme.semanticSpacing.sm,
    marginTop: theme.semanticSpacing.md,
  },
  editButton: {
    flex: 1,
  },
  actionsCard: {
    marginBottom: theme.semanticSpacing.md,
  },
  sectionTitle: {
    marginBottom: theme.semanticSpacing.md,
  },
  actionItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: theme.semanticSpacing.sm,
    borderBottomWidth: 1,
    borderBottomColor: theme.colors.border.light,
  },
  actionLeft: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: theme.semanticSpacing.sm,
  },
  actionText: {
    marginLeft: theme.semanticSpacing.xs,
  },
  signOutItem: {
    borderBottomWidth: 0,
  },
  version: {
    marginTop: theme.semanticSpacing.lg,
  },
});
