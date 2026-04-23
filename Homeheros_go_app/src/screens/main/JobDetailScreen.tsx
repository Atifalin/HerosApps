import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  Alert,
  ActivityIndicator,
  Linking,
  RefreshControl,
  Dimensions,
  Platform,
  StatusBar,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import MapView, { Marker, PROVIDER_DEFAULT } from 'react-native-maps';
import { supabase } from '../../lib/supabase';
import { jobService } from '../../services/jobService';
import { gpsService } from '../../services/gpsService';
import { useAuth } from '../../contexts/AuthContext';
import { PhotoCaptureModal, PhotoCheckpoint } from '../../components/PhotoCaptureModal';

const { width } = Dimensions.get('window');
const STATUSBAR_HEIGHT = Platform.OS === 'ios' ? 44 : StatusBar.currentHeight || 0;

interface JobDetailScreenProps {
  route: any;
  navigation: any;
}

interface AddOn {
  id: string;
  name: string;
  price: number;
}

interface JobDetail {
  id: string;
  customer_name: string;
  customer_phone: string;
  customer_email: string;
  service_title: string;
  variant_name: string;
  scheduled_at: string;
  duration_min: number;
  status: string;
  address_line1: string;
  address_city: string;
  address_province: string;
  address_postal_code: string;
  address_lat: number;
  address_lng: number;
  notes: string;
  add_ons: AddOn[];
}

const JobDetailScreen: React.FC<JobDetailScreenProps> = ({ route, navigation }) => {
  const { jobId } = route.params;
  const { heroProfile } = useAuth();
  const [job, setJob] = useState<JobDetail | null>(null);
  const [loading, setLoading] = useState(true);
  const [refreshing, setRefreshing] = useState(false);
  const [updating, setUpdating] = useState(false);
  const [isTracking, setIsTracking] = useState(false);
  const [photoCheckpoint, setPhotoCheckpoint] = useState<PhotoCheckpoint | null>(null);
  const [hasAccepted, setHasAccepted] = useState(false);

  useEffect(() => {
    loadJobDetails();
    
    // Set up real-time subscription
    const subscription = supabase
      .channel(`job-${jobId}`)
      .on('postgres_changes', {
        event: 'UPDATE',
        schema: 'public',
        table: 'bookings',
        filter: `id=eq.${jobId}`
      }, () => {
        loadJobDetails();
      })
      .subscribe();

    // Check if GPS tracking is active for this job
    const trackingConfig = gpsService.getCurrentConfig();
    if (trackingConfig && trackingConfig.bookingId === jobId) {
      setIsTracking(true);
    }

    return () => {
      subscription.unsubscribe();
    };
  }, [jobId]);

  const loadJobDetails = async () => {
    try {
      // Fetch booking
      const { data: booking, error: bookingError } = await supabase
        .from('bookings')
        .select('*')
        .eq('id', jobId)
        .single();

      if (bookingError) {
        console.error('Error loading booking:', bookingError);
        Alert.alert('Error', 'Failed to load job details');
        return;
      }

      // Fetch customer profile
      const { data: customer } = await supabase
        .from('profiles')
        .select('name, phone, email')
        .eq('id', booking.customer_id)
        .single();

      // Fetch service
      const { data: service } = await supabase
        .from('services')
        .select('title')
        .eq('id', booking.service_id)
        .single();

      // Fetch address
      const { data: address } = await supabase
        .from('addresses')
        .select('line1, city, province, postal_code, lat, lng')
        .eq('id', booking.address_id)
        .single();

      // Fetch service variant
      const { data: variant } = await supabase
        .from('service_variants')
        .select('name')
        .eq('id', booking.service_variant_id)
        .single();

      // Fetch add-ons
      const { data: bookingAddOns } = await supabase
        .from('booking_add_ons')
        .select(`
          add_on_id,
          add_ons (
            id,
            name,
            price
          )
        `)
        .eq('booking_id', booking.id);

      console.log('Customer:', customer);
      console.log('Address:', address);
      console.log('Variant:', variant);
      console.log('Add-ons:', bookingAddOns);

      const addOns: AddOn[] = bookingAddOns?.map((ba: any) => ({
        id: ba.add_ons?.id || ba.add_on_id,
        name: ba.add_ons?.name || 'Unknown Add-on',
        price: parseFloat(ba.add_ons?.price || 0)
      })) || [];

      const transformedJob: JobDetail = {
        id: booking.id,
        customer_name: customer?.name || customer?.email?.split('@')[0] || 'Customer',
        customer_phone: customer?.phone || '',
        customer_email: customer?.email || '',
        service_title: service?.title || booking.service_name || 'Service',
        variant_name: variant?.name || booking.variant_name || 'Standard',
        scheduled_at: booking.scheduled_at,
        duration_min: booking.duration_min,
        status: booking.status,
        address_line1: address?.line1 || '',
        address_city: address?.city || '',
        address_province: address?.province || '',
        address_postal_code: address?.postal_code || '',
        address_lat: parseFloat(address?.lat) || 49.8951,
        address_lng: parseFloat(address?.lng) || -119.2945,
        notes: booking.notes || '',
        add_ons: addOns,
      };

      console.log('Transformed job:', transformedJob);

      setJob(transformedJob);
    } catch (error) {
      console.error('Error:', error);
    } finally {
      setLoading(false);
      setRefreshing(false);
    }
  };

  const handleRefresh = () => {
    setRefreshing(true);
    loadJobDetails();
  };

  const handleCallCustomer = () => {
    if (!job?.customer_phone) {
      Alert.alert('No Phone Number', 'Customer phone number is not available');
      return;
    }

    Alert.alert(
      'Call Customer',
      `Call ${job.customer_name}?`,
      [
        { text: 'Cancel', style: 'cancel' },
        {
          text: 'Call',
          onPress: () => Linking.openURL(`tel:${job.customer_phone}`)
        }
      ]
    );
  };

  const handleNavigate = () => {
    if (!job) return;

    const address = `${job.address_line1}, ${job.address_city}, ${job.address_province} ${job.address_postal_code}`;
    const url = `https://maps.apple.com/?daddr=${encodeURIComponent(address)}`;
    
    Linking.openURL(url).catch(() => {
      Alert.alert('Error', 'Could not open maps');
    });
  };

  // Accept job
  const handleAcceptJob = () => {
    Alert.alert(
      'Accept Job',
      'Accept this job and notify the customer?',
      [
        { text: 'Cancel', style: 'cancel' },
        { text: 'Accept', onPress: async () => {
          setUpdating(true);
          const result = await jobService.acceptJob(jobId);
          setUpdating(false);
          
          if (result.success) {
            setHasAccepted(true);
            Alert.alert('Success', 'Job accepted! You can now start your journey.');
          } else {
            Alert.alert('Error', result.error || 'Failed to accept job');
          }
        }}
      ]
    );
  };

  // Decline job
  const handleDeclineJob = () => {
    Alert.alert(
      'Decline Job',
      'Are you sure you want to decline this job? The customer will be notified.',
      [
        { text: 'Cancel', style: 'cancel' },
        { text: 'Decline', style: 'destructive', onPress: async () => {
          setUpdating(true);
          const result = await jobService.declineJob({ bookingId: jobId });
          setUpdating(false);
          
          if (result.success) {
            Alert.alert('Job Declined', 'The job has been declined and will be reassigned.');
            navigation.goBack();
          } else {
            Alert.alert('Error', result.error || 'Failed to decline job');
          }
        }}
      ]
    );
  };

  // Start en route with GPS tracking
  const handleStartEnRoute = async () => {
    if (!heroProfile) {
      Alert.alert('Error', 'Hero profile not found');
      return;
    }

    setUpdating(true);

    // Start GPS tracking
    const gpsResult = await gpsService.startTracking({
      bookingId: jobId,
      heroId: heroProfile.id,
      intervalMs: 30000 // 30 seconds
    });

    if (!gpsResult.success) {
      setUpdating(false);
      Alert.alert('GPS Error', gpsResult.error || 'Failed to start GPS tracking');
      return;
    }

    // Update job status
    const statusResult = await jobService.startEnRoute(jobId);
    setUpdating(false);

    if (statusResult.success) {
      setIsTracking(true);
      Alert.alert('En Route', 'GPS tracking started. Customer can see your location.');
      loadJobDetails();
    } else {
      // Stop GPS if status update failed
      await gpsService.stopTracking();
      Alert.alert('Error', statusResult.error || 'Failed to update status');
    }
  };

  // Each status transition (arrived/in_progress/completed) opens the
  // PhotoCaptureModal. The status is then updated only after the photo is
  // successfully uploaded, since the DB trigger will otherwise reject it.
  const handleMarkArrived = () => setPhotoCheckpoint('arrival');
  const handleStartJob = () => setPhotoCheckpoint('before');
  const handleCompleteJob = () => setPhotoCheckpoint('after');

  const handlePhotoSuccess = async (photo: {
    id: string;
    distance_from_address_m: number | null;
    inside_geofence: boolean | null;
  }) => {
    const checkpoint = photoCheckpoint;
    setPhotoCheckpoint(null);

    if (!checkpoint) return;

    setUpdating(true);

    let result: { success: boolean; error?: string };
    if (checkpoint === 'arrival') {
      // Stop enroute GPS tracking
      await gpsService.stopTracking();
      setIsTracking(false);
      result = await jobService.markArrived(jobId);
    } else if (checkpoint === 'before') {
      result = await jobService.startJob(jobId);
    } else {
      // 'after'
      result = await jobService.updateJobStatus({
        bookingId: jobId,
        newStatus: 'completed',
        notes: 'Hero completed the job',
      });
    }

    setUpdating(false);

    if (result.success) {
      const successMsg =
        checkpoint === 'arrival'
          ? 'Customer has been notified of your arrival.'
          : checkpoint === 'before'
          ? 'Timer started. Good luck!'
          : 'Great work! The customer will be notified.';
      Alert.alert(
        checkpoint === 'arrival' ? 'Arrived' : checkpoint === 'before' ? 'Job Started' : 'Job Completed',
        successMsg,
      );
      loadJobDetails();
    } else {
      Alert.alert('Error', result.error || 'Failed to update status');
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
      case 'declined':
        return '#F44336';
      default:
        return '#999';
    }
  };

  const getStatusActions = () => {
    if (!job) return null;

    switch (job.status) {
      case 'awaiting_hero_accept':
        // If hero has accepted, show Start Journey button
        if (hasAccepted) {
          return (
            <TouchableOpacity 
              style={[styles.actionButton, styles.startButton]} 
              onPress={handleStartEnRoute}
            >
              <Ionicons name="car" size={20} color="#fff" />
              <Text style={styles.actionButtonText}>Start Journey</Text>
            </TouchableOpacity>
          );
        }
        
        // Otherwise show Accept/Decline buttons
        return (
          <View style={styles.actionButtonsContainer}>
            <TouchableOpacity 
              style={[styles.actionButton, styles.declineButton]} 
              onPress={handleDeclineJob}
            >
              <Ionicons name="close-circle" size={20} color="#fff" />
              <Text style={styles.actionButtonText}>Decline</Text>
            </TouchableOpacity>
            <TouchableOpacity 
              style={[styles.actionButton, styles.acceptButton]} 
              onPress={handleAcceptJob}
            >
              <Ionicons name="checkmark-circle" size={20} color="#fff" />
              <Text style={styles.actionButtonText}>Accept Job</Text>
            </TouchableOpacity>
          </View>
        );
      
      case 'requested':
        // After accepting, hero can start en route
        return (
          <TouchableOpacity 
            style={[styles.actionButton, styles.startButton]} 
            onPress={handleStartEnRoute}
          >
            <Ionicons name="car" size={20} color="#fff" />
            <Text style={styles.actionButtonText}>Start Journey</Text>
          </TouchableOpacity>
        );
      
      case 'enroute':
        return (
          <View>
            {isTracking && (
              <View style={styles.trackingIndicator}>
                <Ionicons name="radio-button-on" size={16} color="#4CAF50" />
                <Text style={styles.trackingText}>GPS Tracking Active</Text>
              </View>
            )}
            <TouchableOpacity 
              style={[styles.actionButton, styles.arrivedButton]} 
              onPress={handleMarkArrived}
            >
              <Ionicons name="location" size={20} color="#fff" />
              <Text style={styles.actionButtonText}>I've Arrived</Text>
            </TouchableOpacity>
          </View>
        );
      
      case 'arrived':
        return (
          <TouchableOpacity 
            style={[styles.actionButton, styles.workButton]} 
            onPress={handleStartJob}
          >
            <Ionicons name="construct" size={20} color="#fff" />
            <Text style={styles.actionButtonText}>Start Work</Text>
          </TouchableOpacity>
        );
      
      case 'in_progress':
        return (
          <TouchableOpacity 
            style={[styles.actionButton, styles.completeButton]} 
            onPress={handleCompleteJob}
          >
            <Ionicons name="checkmark-done" size={20} color="#fff" />
            <Text style={styles.actionButtonText}>Complete Job</Text>
          </TouchableOpacity>
        );
      
      case 'completed':
        return (
          <View style={styles.completedBadge}>
            <Ionicons name="checkmark-circle" size={24} color="#4CAF50" />
            <Text style={styles.completedText}>Job Completed</Text>
          </View>
        );
      
      default:
        return null;
    }
  };

  if (loading) {
    return (
      <View style={styles.loadingContainer}>
        <ActivityIndicator size="large" color="#FF6B35" />
        <Text style={styles.loadingText}>Loading job details...</Text>
      </View>
    );
  }

  if (!job) {
    return (
      <View style={styles.errorContainer}>
        <Ionicons name="alert-circle" size={64} color="#ccc" />
        <Text style={styles.errorText}>Job not found</Text>
        <TouchableOpacity style={styles.backButton} onPress={() => navigation.goBack()}>
          <Text style={styles.backButtonText}>Go Back</Text>
        </TouchableOpacity>
      </View>
    );
  }

  const formatDate = (dateString: string) => {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', {
      weekday: 'long',
      month: 'long',
      day: 'numeric',
      year: 'numeric'
    });
  };

  const formatTime = (dateString: string) => {
    const date = new Date(dateString);
    return date.toLocaleTimeString('en-US', {
      hour: 'numeric',
      minute: '2-digit'
    });
  };

  const formatPrice = (cents: number) => {
    return `$${(cents / 100).toFixed(2)}`;
  };

  return (
    <View style={styles.container}>
      <StatusBar barStyle="dark-content" backgroundColor="#fff" />
      
      {/* Header with Safe Area */}
      <View style={styles.headerContainer}>
        <View style={styles.header}>
          <View style={styles.backButtonContainer}>
            <TouchableOpacity onPress={() => navigation.goBack()} activeOpacity={0.6} hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}>
              <Ionicons name="arrow-back" size={26} color="#007AFF" />
            </TouchableOpacity>
          </View>
          <View style={styles.headerCenter}>
            <Text style={styles.headerTitle}>Job Details</Text>
            <Text style={styles.headerSubtitle}>#{job.id.slice(-8)}</Text>
          </View>
          <View style={styles.refreshButtonContainer}>
            <TouchableOpacity onPress={handleRefresh} activeOpacity={0.6} hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}>
              <Ionicons name="ellipsis-horizontal" size={24} color="#007AFF" />
            </TouchableOpacity>
          </View>
        </View>
      </View>

      <ScrollView
        style={styles.scrollView}
        refreshControl={
          <RefreshControl refreshing={refreshing} onRefresh={handleRefresh} />
        }
      >
        {/* Status Card */}
        <View style={styles.statusCard}>
          <View style={[styles.statusBadge, { backgroundColor: getStatusColor(job.status) }]}>
            <Text style={styles.statusText}>{job.status.replace(/_/g, ' ').toUpperCase()}</Text>
          </View>
          <Text style={styles.serviceTitle}>{job.service_title}</Text>
          <Text style={styles.variantName}>{job.variant_name}</Text>
        </View>

        {/* Service Details */}
        {job.add_ons.length > 0 && (
          <View style={styles.card}>
            <Text style={styles.cardTitle}>Service Add-ons</Text>
            {job.add_ons.map((addOn) => (
              <View key={addOn.id} style={styles.addOnRow}>
                <View style={styles.addOnInfo}>
                  <Ionicons name="checkmark-circle" size={18} color="#4CAF50" />
                  <Text style={styles.addOnName}>{addOn.name}</Text>
                </View>
                <Text style={styles.addOnPrice}>+${addOn.price.toFixed(2)}</Text>
              </View>
            ))}
          </View>
        )}

        {/* Customer Info */}
        <View style={styles.card}>
          <Text style={styles.cardTitle}>Customer Information</Text>
          
          <View style={styles.infoRow}>
            <Ionicons name="person" size={20} color="#666" />
            <Text style={styles.infoText}>{job.customer_name}</Text>
          </View>

          {job.customer_phone && (
            <TouchableOpacity style={styles.infoRow} onPress={handleCallCustomer}>
              <Ionicons name="call" size={20} color="#FF6B35" />
              <Text style={[styles.infoText, styles.linkText]}>{job.customer_phone}</Text>
            </TouchableOpacity>
          )}

          {job.customer_email && (
            <View style={styles.infoRow}>
              <Ionicons name="mail" size={20} color="#666" />
              <Text style={styles.infoText}>{job.customer_email}</Text>
            </View>
          )}
        </View>

        {/* Schedule */}
        <View style={styles.card}>
          <Text style={styles.cardTitle}>Schedule</Text>
          
          <View style={styles.infoRow}>
            <Ionicons name="calendar" size={20} color="#666" />
            <Text style={styles.infoText}>{formatDate(job.scheduled_at)}</Text>
          </View>

          <View style={styles.infoRow}>
            <Ionicons name="time" size={20} color="#666" />
            <Text style={styles.infoText}>{formatTime(job.scheduled_at)}</Text>
          </View>

          <View style={styles.infoRow}>
            <Ionicons name="hourglass" size={20} color="#666" />
            <Text style={styles.infoText}>{job.duration_min} minutes</Text>
          </View>
        </View>

        {/* Map */}
        <View style={styles.mapCard}>
          <MapView
            style={styles.map}
            provider={PROVIDER_DEFAULT}
            initialRegion={{
              latitude: job.address_lat,
              longitude: job.address_lng,
              latitudeDelta: 0.01,
              longitudeDelta: 0.01,
            }}
            scrollEnabled={false}
            zoomEnabled={false}
            pitchEnabled={false}
            rotateEnabled={false}
          >
            <Marker
              coordinate={{
                latitude: job.address_lat,
                longitude: job.address_lng,
              }}
              title={job.customer_name}
              description={job.address_line1}
            />
          </MapView>
          <TouchableOpacity style={styles.mapOverlay} onPress={handleNavigate}>
            <Ionicons name="navigate" size={24} color="#fff" />
            <Text style={styles.mapOverlayText}>Tap to Navigate</Text>
          </TouchableOpacity>
        </View>

        {/* Location */}
        <View style={styles.card}>
          <View style={styles.cardHeader}>
            <Text style={styles.cardTitle}>Location</Text>
            <TouchableOpacity onPress={handleNavigate} style={styles.navigateButton}>
              <Ionicons name="navigate" size={18} color="#fff" />
              <Text style={styles.navigateText}>Navigate</Text>
            </TouchableOpacity>
          </View>
          
          <View style={styles.addressContainer}>
            <Ionicons name="location" size={20} color="#FF6B35" />
            <View style={styles.addressText}>
              <Text style={styles.addressLine}>{job.address_line1}</Text>
              <Text style={styles.addressLine}>
                {job.address_city}, {job.address_province} {job.address_postal_code}
              </Text>
            </View>
          </View>
        </View>

        {/* Special Instructions */}
        {job.notes && (
          <View style={styles.card}>
            <Text style={styles.cardTitle}>Special Instructions</Text>
            <Text style={styles.notesText}>{job.notes}</Text>
          </View>
        )}

        {/* Quick Actions */}
        <View style={styles.quickActions}>
          <TouchableOpacity style={styles.quickActionButton} onPress={handleCallCustomer}>
            <Ionicons name="call" size={24} color="#FF6B35" />
            <Text style={styles.quickActionText}>Call</Text>
          </TouchableOpacity>

          <TouchableOpacity style={styles.quickActionButton} onPress={handleNavigate}>
            <Ionicons name="navigate" size={24} color="#FF6B35" />
            <Text style={styles.quickActionText}>Navigate</Text>
          </TouchableOpacity>

          <TouchableOpacity style={styles.quickActionButton}>
            <Ionicons name="chatbubble" size={24} color="#FF6B35" />
            <Text style={styles.quickActionText}>Message</Text>
          </TouchableOpacity>
        </View>

        {/* Status Action Button */}
        <View style={styles.actionContainer}>
          {updating ? (
            <ActivityIndicator size="large" color="#FF6B35" />
          ) : (
            getStatusActions()
          )}
        </View>
      </ScrollView>

      {/* Photo Capture Modal (arrival / before / after) */}
      {photoCheckpoint && heroProfile && (
        <PhotoCaptureModal
          visible={true}
          bookingId={jobId}
          heroId={heroProfile.user_id}
          photoType={photoCheckpoint}
          onClose={() => setPhotoCheckpoint(null)}
          onSuccess={handlePhotoSuccess}
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
  headerContainer: {
    backgroundColor: '#fff',
    paddingTop: STATUSBAR_HEIGHT,
    borderBottomWidth: 0,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    height: 56,
    paddingHorizontal: 16,
  },
  backButtonContainer: {
    width: 44,
    justifyContent: 'center',
    alignItems: 'flex-start',
  },
  refreshButtonContainer: {
    width: 44,
    justifyContent: 'center',
    alignItems: 'flex-end',
  },
  headerCenter: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  headerTitle: {
    fontSize: 17,
    fontWeight: '600',
    color: '#000',
    letterSpacing: -0.4,
  },
  headerSubtitle: {
    fontSize: 11,
    color: '#8E8E93',
    marginTop: 1,
  },
  scrollView: {
    flex: 1,
  },
  statusCard: {
    backgroundColor: '#fff',
    padding: 20,
    margin: 16,
    marginBottom: 8,
    borderRadius: 12,
    alignItems: 'center',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  statusBadge: {
    paddingHorizontal: 16,
    paddingVertical: 8,
    borderRadius: 20,
    marginBottom: 12,
  },
  statusText: {
    color: '#fff',
    fontSize: 12,
    fontWeight: '600',
  },
  serviceTitle: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
    textAlign: 'center',
  },
  variantName: {
    fontSize: 16,
    color: '#666',
    textAlign: 'center',
    marginTop: 4,
  },
  card: {
    backgroundColor: '#fff',
    padding: 16,
    margin: 16,
    marginTop: 8,
    marginBottom: 8,
    borderRadius: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  cardHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 12,
  },
  cardTitle: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
    marginBottom: 12,
  },
  infoRow: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: 8,
  },
  infoText: {
    marginLeft: 12,
    fontSize: 14,
    color: '#666',
    flex: 1,
  },
  linkText: {
    color: '#FF6B35',
    fontWeight: '500',
  },
  addressContainer: {
    flexDirection: 'row',
    alignItems: 'flex-start',
  },
  addressText: {
    marginLeft: 12,
    flex: 1,
  },
  addressLine: {
    fontSize: 14,
    color: '#666',
    marginBottom: 4,
  },
  navigateButton: {
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: '#FF6B35',
    paddingHorizontal: 12,
    paddingVertical: 6,
    borderRadius: 8,
  },
  navigateText: {
    color: '#fff',
    fontSize: 12,
    fontWeight: '600',
    marginLeft: 4,
  },
  notesText: {
    fontSize: 14,
    color: '#666',
    lineHeight: 20,
  },
  paymentRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    paddingVertical: 8,
  },
  paymentLabel: {
    fontSize: 14,
    color: '#666',
  },
  paymentValue: {
    fontSize: 14,
    fontWeight: '500',
    color: '#333',
  },
  tipValue: {
    color: '#4CAF50',
  },
  totalRow: {
    borderTopWidth: 2,
    borderTopColor: '#FF6B35',
    marginTop: 8,
    paddingTop: 12,
  },
  totalLabel: {
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
  },
  totalValue: {
    fontSize: 18,
    fontWeight: 'bold',
    color: '#FF6B35',
  },
  quickActions: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    backgroundColor: '#fff',
    margin: 16,
    marginTop: 8,
    padding: 16,
    borderRadius: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  quickActionButton: {
    alignItems: 'center',
  },
  quickActionText: {
    marginTop: 4,
    fontSize: 12,
    color: '#666',
  },
  actionContainer: {
    padding: 16,
    paddingBottom: 32,
  },
  actionButton: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 16,
    borderRadius: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.2,
    shadowRadius: 4,
    elevation: 4,
  },
  actionButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '600',
    marginLeft: 8,
  },
  acceptButton: {
    backgroundColor: '#4CAF50',
  },
  startButton: {
    backgroundColor: '#2196F3',
  },
  arrivedButton: {
    backgroundColor: '#9C27B0',
  },
  workButton: {
    backgroundColor: '#FF9800',
  },
  completeButton: {
    backgroundColor: '#4CAF50',
  },
  completedBadge: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 16,
    backgroundColor: '#E8F5E9',
    borderRadius: 12,
  },
  completedText: {
    marginLeft: 8,
    fontSize: 16,
    fontWeight: '600',
    color: '#4CAF50',
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f5f5f5',
  },
  loadingText: {
    marginTop: 16,
    fontSize: 16,
    color: '#666',
  },
  errorContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#f5f5f5',
    padding: 20,
  },
  errorText: {
    fontSize: 18,
    color: '#666',
    marginTop: 16,
    marginBottom: 24,
  },
  backButton: {
    backgroundColor: '#FF6B35',
    paddingHorizontal: 24,
    paddingVertical: 12,
    borderRadius: 8,
  },
  backButtonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '600',
  },
  mapCard: {
    margin: 16,
    marginTop: 8,
    marginBottom: 8,
    borderRadius: 12,
    overflow: 'hidden',
    height: 200,
    position: 'relative',
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 3,
  },
  map: {
    width: '100%',
    height: '100%',
  },
  mapOverlay: {
    position: 'absolute',
    bottom: 16,
    right: 16,
    backgroundColor: '#FF6B35',
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 16,
    paddingVertical: 10,
    borderRadius: 20,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.3,
    shadowRadius: 4,
    elevation: 5,
  },
  mapOverlayText: {
    color: '#fff',
    fontSize: 14,
    fontWeight: '600',
    marginLeft: 8,
  },
  addOnRow: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 10,
    borderBottomWidth: 1,
    borderBottomColor: '#f0f0f0',
  },
  addOnInfo: {
    flexDirection: 'row',
    alignItems: 'center',
    flex: 1,
  },
  addOnName: {
    fontSize: 15,
    color: '#333',
    marginLeft: 10,
    flex: 1,
  },
  addOnPrice: {
    fontSize: 15,
    fontWeight: '600',
    color: '#4CAF50',
  },
  actionButtonsContainer: {
    flexDirection: 'row',
    gap: 12,
  },
  declineButton: {
    flex: 1,
    backgroundColor: '#F44336',
  },
  trackingIndicator: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 12,
    backgroundColor: '#E8F5E9',
    borderRadius: 8,
    marginBottom: 12,
  },
  trackingText: {
    marginLeft: 8,
    color: '#4CAF50',
    fontWeight: '600',
  },
  modalContainer: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.5)',
    justifyContent: 'center',
    alignItems: 'center',
  },
  modalContent: {
    backgroundColor: '#fff',
    borderRadius: 16,
    padding: 24,
    width: '90%',
    maxWidth: 400,
  },
  modalTitle: {
    fontSize: 20,
    fontWeight: 'bold',
    marginBottom: 8,
    textAlign: 'center',
  },
  modalSubtitle: {
    fontSize: 14,
    color: '#666',
    marginBottom: 24,
    textAlign: 'center',
  },
  takePhotoButton: {
    alignItems: 'center',
    padding: 40,
    backgroundColor: '#f5f5f5',
    borderRadius: 12,
    marginBottom: 24,
  },
  takePhotoText: {
    marginTop: 12,
    fontSize: 16,
    color: '#FF6B35',
    fontWeight: '600',
  },
  photoPreview: {
    marginBottom: 24,
  },
  photoImage: {
    width: '100%',
    height: 200,
    borderRadius: 12,
    marginBottom: 12,
  },
  retakeButton: {
    padding: 12,
    backgroundColor: '#f5f5f5',
    borderRadius: 8,
    alignItems: 'center',
  },
  retakeButtonText: {
    color: '#FF6B35',
    fontWeight: '600',
  },
  modalButtons: {
    flexDirection: 'row',
    gap: 12,
  },
  modalButton: {
    flex: 1,
    padding: 16,
    borderRadius: 8,
    alignItems: 'center',
  },
  modalCancelButton: {
    backgroundColor: '#f5f5f5',
  },
  modalCancelText: {
    color: '#666',
    fontWeight: '600',
  },
  modalConfirmButton: {
    backgroundColor: '#FF6B35',
  },
  modalConfirmText: {
    color: '#fff',
    fontWeight: '600',
  },
});

export default JobDetailScreen;
