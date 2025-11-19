import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  RefreshControl,
  Alert,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useAuth } from '../../contexts/AuthContext';
import { supabase } from '../../lib/supabase';

interface EarningsSummary {
  totalEarnings: number;
  completedJobs: number;
  averageRating: number;
  totalTips: number;
}

const EarningsScreen = () => {
  const { heroProfile } = useAuth();
  const [earnings, setEarnings] = useState<EarningsSummary>({
    totalEarnings: 0,
    completedJobs: 0,
    averageRating: 0,
    totalTips: 0,
  });
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);

  const fetchEarnings = async () => {
    if (!heroProfile) {
      setLoading(false);
      return;
    }

    try {
      // Fetch completed bookings
      const { data: bookings, error: bookingsError } = await supabase
        .from('bookings')
        .select('price_cents, tip_cents')
        .eq('hero_id', heroProfile.id)
        .eq('status', 'completed');

      if (bookingsError) {
        console.error('Error fetching bookings:', bookingsError);
        Alert.alert('Error', 'Failed to load earnings');
      } else {
        const totalEarnings = bookings?.reduce((sum, b) => sum + (b.price_cents || 0), 0) || 0;
        const totalTips = bookings?.reduce((sum, b) => sum + (b.tip_cents || 0), 0) || 0;
        const completedJobs = bookings?.length || 0;

        setEarnings({
          totalEarnings,
          completedJobs,
          averageRating: heroProfile.rating_avg || 0,
          totalTips,
        });
      }
    } catch (error) {
      console.error('Error fetching earnings:', error);
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  };

  useEffect(() => {
    fetchEarnings();
  }, [heroProfile]);

  const onRefresh = () => {
    setRefreshing(true);
    fetchEarnings();
  };

  const formatCurrency = (cents: number) => {
    return `$${(cents / 100).toFixed(2)}`;
  };

  if (!heroProfile) {
    return (
      <View style={styles.emptyContainer}>
        <Ionicons name="alert-circle-outline" size={64} color="#ccc" />
        <Text style={styles.emptyText}>Hero profile not found</Text>
      </View>
    );
  }

  return (
    <ScrollView
      style={styles.container}
      refreshControl={
        <RefreshControl refreshing={refreshing} onRefresh={onRefresh} />
      }
    >
      <View style={styles.header}>
        <Text style={styles.headerTitle}>Your Earnings</Text>
        <Text style={styles.headerSubtitle}>
          Note: Payouts are managed by your contractor
        </Text>
      </View>

      <View style={styles.summaryContainer}>
        <View style={styles.summaryCard}>
          <View style={styles.iconContainer}>
            <Ionicons name="cash" size={32} color="#FF6B35" />
          </View>
          <Text style={styles.summaryValue}>
            {formatCurrency(earnings.totalEarnings)}
          </Text>
          <Text style={styles.summaryLabel}>Total Earnings</Text>
        </View>

        <View style={styles.summaryCard}>
          <View style={styles.iconContainer}>
            <Ionicons name="briefcase" size={32} color="#4CAF50" />
          </View>
          <Text style={styles.summaryValue}>{earnings.completedJobs}</Text>
          <Text style={styles.summaryLabel}>Completed Jobs</Text>
        </View>
      </View>

      <View style={styles.summaryContainer}>
        <View style={styles.summaryCard}>
          <View style={styles.iconContainer}>
            <Ionicons name="star" size={32} color="#FFD700" />
          </View>
          <Text style={styles.summaryValue}>
            {earnings.averageRating.toFixed(1)}
          </Text>
          <Text style={styles.summaryLabel}>Average Rating</Text>
        </View>

        <View style={styles.summaryCard}>
          <View style={styles.iconContainer}>
            <Ionicons name="gift" size={32} color="#9C27B0" />
          </View>
          <Text style={styles.summaryValue}>
            {formatCurrency(earnings.totalTips)}
          </Text>
          <Text style={styles.summaryLabel}>Total Tips</Text>
        </View>
      </View>

      <View style={styles.infoCard}>
        <Ionicons name="information-circle" size={24} color="#2196F3" />
        <View style={styles.infoTextContainer}>
          <Text style={styles.infoTitle}>About Earnings</Text>
          <Text style={styles.infoText}>
            These earnings are informational. Your contractor manages all payouts
            and will compensate you according to your agreement.
          </Text>
        </View>
      </View>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  header: {
    backgroundColor: '#fff',
    padding: 20,
    borderBottomWidth: 1,
    borderBottomColor: '#eee',
  },
  headerTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 4,
  },
  headerSubtitle: {
    fontSize: 14,
    color: '#666',
  },
  summaryContainer: {
    flexDirection: 'row',
    padding: 16,
    gap: 12,
  },
  summaryCard: {
    flex: 1,
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 20,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  iconContainer: {
    marginBottom: 12,
  },
  summaryValue: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 4,
  },
  summaryLabel: {
    fontSize: 12,
    color: '#666',
    textAlign: 'center',
  },
  infoCard: {
    backgroundColor: '#E3F2FD',
    margin: 16,
    padding: 16,
    borderRadius: 12,
    flexDirection: 'row',
    alignItems: 'flex-start',
  },
  infoTextContainer: {
    flex: 1,
    marginLeft: 12,
  },
  infoTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#1976D2',
    marginBottom: 4,
  },
  infoText: {
    fontSize: 14,
    color: '#1565C0',
    lineHeight: 20,
  },
  emptyContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    padding: 20,
  },
  emptyText: {
    fontSize: 18,
    fontWeight: '600',
    color: '#666',
    marginTop: 16,
  },
});

export default EarningsScreen;
