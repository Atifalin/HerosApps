import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  StyleSheet,
  FlatList,
  TouchableOpacity,
  RefreshControl,
  Alert,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { useAuth } from '../../contexts/AuthContext';
import { supabase } from '../../lib/supabase';

interface Job {
  id: string;
  customer_name: string;
  service_title: string;
  scheduled_at: string;
  status: string;
  address: string;
}

interface JobsScreenProps {
  navigation: any;
}

type SortOption = 'date_desc' | 'date_asc' | 'status' | 'service';

const JobsScreen: React.FC<JobsScreenProps> = ({ navigation }) => {
  const { heroProfile } = useAuth();
  const [jobs, setJobs] = useState<Job[]>([]);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);
  const [sortBy, setSortBy] = useState<SortOption>('date_desc');
  const [showSortMenu, setShowSortMenu] = useState(false);

  const fetchJobs = async () => {
    if (!heroProfile) {
      setLoading(false);
      return;
    }

    try {
      const { data, error } = await supabase
        .from('bookings')
        .select(`
          id,
          scheduled_at,
          status,
          notes,
          profiles:customer_id (name),
          services (title),
          addresses (line1, city)
        `)
        .eq('hero_id', heroProfile.id)
        .order('scheduled_at', { ascending: false })
        .limit(20);

      if (error) {
        console.error('Error fetching jobs:', error);
        Alert.alert('Error', 'Failed to load jobs');
      } else {
        // Transform data for display
        const transformedJobs = (data || []).map((booking: any) => ({
          id: booking.id,
          customer_name: booking.profiles?.name || 'Customer',
          service_title: booking.services?.title || 'Service',
          scheduled_at: booking.scheduled_at,
          status: booking.status,
          address: `${booking.addresses?.line1}, ${booking.addresses?.city}`,
        }));
        setJobs(transformedJobs);
      }
    } catch (error) {
      console.error('Error fetching jobs:', error);
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  };

  useEffect(() => {
    fetchJobs();
  }, [heroProfile]);

  const onRefresh = () => {
    setRefreshing(true);
    fetchJobs();
  };

  const sortJobs = (jobsToSort: Job[], sortOption: SortOption): Job[] => {
    const sorted = [...jobsToSort];
    
    switch (sortOption) {
      case 'date_desc':
        return sorted.sort((a, b) => new Date(b.scheduled_at).getTime() - new Date(a.scheduled_at).getTime());
      case 'date_asc':
        return sorted.sort((a, b) => new Date(a.scheduled_at).getTime() - new Date(b.scheduled_at).getTime());
      case 'status':
        const statusOrder = { 'requested': 0, 'in_progress': 1, 'completed': 2, 'cancelled': 3 };
        return sorted.sort((a, b) => {
          const aOrder = statusOrder[a.status as keyof typeof statusOrder] ?? 99;
          const bOrder = statusOrder[b.status as keyof typeof statusOrder] ?? 99;
          return aOrder - bOrder;
        });
      case 'service':
        return sorted.sort((a, b) => a.service_title.localeCompare(b.service_title));
      default:
        return sorted;
    }
  };

  const handleSortChange = (option: SortOption) => {
    setSortBy(option);
    setShowSortMenu(false);
    setJobs(prevJobs => sortJobs(prevJobs, option));
  };

  const getSortLabel = (option: SortOption): string => {
    switch (option) {
      case 'date_desc': return 'Newest First';
      case 'date_asc': return 'Oldest First';
      case 'status': return 'By Status';
      case 'service': return 'By Service';
    }
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'requested':
      case 'awaiting_hero_accept':
        return '#FFA500';
      case 'enroute':
      case 'arrived':
      case 'in_progress':
        return '#4CAF50';
      case 'completed':
        return '#2196F3';
      case 'cancelled_by_customer':
      case 'cancelled_by_admin':
      case 'declined':
        return '#F44336';
      default:
        return '#999';
    }
  };

  const formatDate = (dateString: string) => {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
      month: 'short',
      day: 'numeric',
      hour: 'numeric',
      minute: '2-digit',
    });
  };


  const renderJob = ({ item }: { item: Job }) => (
    <TouchableOpacity 
      style={styles.jobCard}
      onPress={() => navigation.navigate('JobDetail', { jobId: item.id })}
    >
      <View style={styles.jobHeader}>
        <Text style={styles.serviceTitle}>{item.service_title}</Text>
        <View style={[styles.statusBadge, { backgroundColor: getStatusColor(item.status) }]}>
          <Text style={styles.statusText}>{item.status.replace(/_/g, ' ')}</Text>
        </View>
      </View>
      
      <View style={styles.jobDetails}>
        <View style={styles.detailRow}>
          <Ionicons name="person-outline" size={16} color="#666" />
          <Text style={styles.detailText}>{item.customer_name}</Text>
        </View>
        
        <View style={styles.detailRow}>
          <Ionicons name="location-outline" size={16} color="#666" />
          <Text style={styles.detailText}>{item.address}</Text>
        </View>
        
        <View style={styles.detailRow}>
          <Ionicons name="time-outline" size={16} color="#666" />
          <Text style={styles.detailText}>{formatDate(item.scheduled_at)}</Text>
        </View>
      </View>
    </TouchableOpacity>
  );

  if (!heroProfile) {
    return (
      <View style={styles.emptyContainer}>
        <Ionicons name="alert-circle-outline" size={64} color="#ccc" />
        <Text style={styles.emptyText}>Hero profile not found</Text>
        <Text style={styles.emptySubtext}>Please complete your profile setup</Text>
      </View>
    );
  }

  return (
    <View style={styles.container}>
      {/* Header */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>My Jobs</Text>
        <TouchableOpacity 
          style={styles.sortButton}
          onPress={() => setShowSortMenu(!showSortMenu)}
        >
          <Ionicons name="funnel-outline" size={20} color="#fff" />
          <Text style={styles.sortButtonText}>{getSortLabel(sortBy)}</Text>
        </TouchableOpacity>
      </View>

      {/* Sort Menu */}
      {showSortMenu && (
        <View style={styles.sortMenu}>
          {(['date_desc', 'date_asc', 'status', 'service'] as SortOption[]).map((option) => (
            <TouchableOpacity
              key={option}
              style={[styles.sortOption, sortBy === option && styles.sortOptionActive]}
              onPress={() => handleSortChange(option)}
            >
              <Text style={[styles.sortOptionText, sortBy === option && styles.sortOptionTextActive]}>
                {getSortLabel(option)}
              </Text>
              {sortBy === option && <Ionicons name="checkmark" size={20} color="#FF6B35" />}
            </TouchableOpacity>
          ))}
        </View>
      )}

      {loading && !refreshing ? (
        <View style={styles.emptyContainer}>
          <Text>Loading jobs...</Text>
        </View>
      ) : jobs.length === 0 ? (
        <View style={styles.emptyContainer}>
          <Ionicons name="briefcase-outline" size={64} color="#ccc" />
          <Text style={styles.emptyText}>No jobs yet</Text>
          <Text style={styles.emptySubtext}>Jobs will appear here when customers book you</Text>
        </View>
      ) : (
        <FlatList
          data={jobs}
          renderItem={renderJob}
          keyExtractor={(item) => item.id}
          contentContainerStyle={styles.listContent}
          refreshControl={
            <RefreshControl refreshing={refreshing} onRefresh={onRefresh} />
          }
        />
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  header: {
    backgroundColor: '#FF6B35',
    padding: 20,
    paddingTop: 60,
    paddingBottom: 20,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  headerTitle: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#fff',
    flex: 1,
  },
  sortButton: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: 'rgba(255, 255, 255, 0.2)',
    paddingHorizontal: 12,
    paddingVertical: 8,
    borderRadius: 20,
    gap: 6,
  },
  sortButtonText: {
    color: '#fff',
    fontSize: 14,
    fontWeight: '600',
  },
  sortMenu: {
    backgroundColor: '#fff',
    marginHorizontal: 16,
    marginTop: 8,
    borderRadius: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
    overflow: 'hidden',
  },
  sortOption: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: 16,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  sortOptionActive: {
    backgroundColor: '#FFF5F2',
  },
  sortOptionText: {
    fontSize: 16,
    color: '#333',
  },
  sortOptionTextActive: {
    color: '#FF6B35',
    fontWeight: '600',
  },
  listContent: {
    padding: 16,
  },
  jobCard: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    marginBottom: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  jobHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 12,
  },
  serviceTitle: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#333',
    flex: 1,
  },
  statusBadge: {
    paddingHorizontal: 12,
    paddingVertical: 4,
    borderRadius: 12,
  },
  statusText: {
    color: '#fff',
    fontSize: 12,
    fontWeight: '600',
    textTransform: 'capitalize',
  },
  jobDetails: {
    marginBottom: 12,
  },
  detailRow: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
  },
  detailText: {
    marginLeft: 8,
    fontSize: 14,
    color: '#666',
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
  emptySubtext: {
    fontSize: 14,
    color: '#999',
    marginTop: 8,
    textAlign: 'center',
  },
});

export default JobsScreen;
