import React, { useState, useEffect } from 'react';
import { View, StyleSheet, ActivityIndicator } from 'react-native';
import MapView, { Marker, PROVIDER_DEFAULT } from 'react-native-maps';
import { Ionicons } from '@expo/vector-icons';
import { Typography } from './ui';
import { supabase } from '../lib/supabase';
import { theme } from '../theme';

interface LiveMapProps {
  bookingId: string;
  customerLat: number;
  customerLng: number;
  customerAddress: string;
}

interface GPSPing {
  lat: number;
  lng: number;
  speed: number | null;
  ts: string;
}

export const LiveMap: React.FC<LiveMapProps> = ({
  bookingId,
  customerLat,
  customerLng,
  customerAddress,
}) => {
  const [heroLocation, setHeroLocation] = useState<GPSPing | null>(null);
  const [loading, setLoading] = useState(true);
  const [eta, setEta] = useState<string | null>(null);

  useEffect(() => {
    // Fetch latest GPS ping
    fetchLatestLocation();

    // Subscribe to real-time GPS updates
    const subscription = supabase
      .channel(`gps-${bookingId}`)
      .on('postgres_changes', {
        event: 'INSERT',
        schema: 'public',
        table: 'gps_pings',
        filter: `booking_id=eq.${bookingId}`
      }, (payload) => {
        console.log('GPS ping received:', payload);
        const newPing = payload.new as any;
        setHeroLocation({
          lat: parseFloat(newPing.lat),
          lng: parseFloat(newPing.lng),
          speed: newPing.speed,
          ts: newPing.ts
        });
        calculateETA(parseFloat(newPing.lat), parseFloat(newPing.lng), newPing.speed);
      })
      .subscribe();

    return () => {
      subscription.unsubscribe();
    };
  }, [bookingId]);

  const fetchLatestLocation = async () => {
    try {
      const { data, error } = await supabase
        .from('gps_pings')
        .select('lat, lng, speed, ts')
        .eq('booking_id', bookingId)
        .order('ts', { ascending: false })
        .limit(1)
        .single();

      if (error) {
        console.error('Error fetching GPS location:', error);
        setLoading(false);
        return;
      }

      if (data) {
        const location = {
          lat: parseFloat(data.lat),
          lng: parseFloat(data.lng),
          speed: data.speed,
          ts: data.ts
        };
        setHeroLocation(location);
        calculateETA(location.lat, location.lng, location.speed);
      }
    } catch (error) {
      console.error('Error:', error);
    } finally {
      setLoading(false);
    }
  };

  const calculateETA = (heroLat: number, heroLng: number, speed: number | null) => {
    // Calculate distance using Haversine formula
    const R = 6371; // Earth's radius in km
    const dLat = toRad(customerLat - heroLat);
    const dLng = toRad(customerLng - heroLng);
    
    const a = 
      Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.cos(toRad(heroLat)) * Math.cos(toRad(customerLat)) *
      Math.sin(dLng / 2) * Math.sin(dLng / 2);
    
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    const distance = R * c; // Distance in km

    // Estimate time (use speed if available, otherwise assume 40 km/h)
    const avgSpeed = speed && speed > 0 ? speed * 3.6 : 40; // Convert m/s to km/h or use default
    const timeInHours = distance / avgSpeed;
    const timeInMinutes = Math.round(timeInHours * 60);

    if (timeInMinutes < 1) {
      setEta('Arriving now');
    } else if (timeInMinutes === 1) {
      setEta('1 min');
    } else {
      setEta(`${timeInMinutes} mins`);
    }
  };

  const toRad = (degrees: number) => {
    return degrees * (Math.PI / 180);
  };

  if (loading) {
    return (
      <View style={styles.loadingContainer}>
        <ActivityIndicator size="large" color={theme.colors.primary.main} />
        <Typography variant="body2" color="secondary" style={styles.loadingText}>
          Loading map...
        </Typography>
      </View>
    );
  }

  if (!heroLocation) {
    return (
      <View style={styles.noLocationContainer}>
        <Ionicons name="location-outline" size={48} color={theme.colors.neutral[400]} />
        <Typography variant="body2" color="secondary" align="center">
          Waiting for hero location...
        </Typography>
      </View>
    );
  }

  // Calculate map region to show both markers
  const midLat = (heroLocation.lat + customerLat) / 2;
  const midLng = (heroLocation.lng + customerLng) / 2;
  const latDelta = Math.abs(heroLocation.lat - customerLat) * 2.5 || 0.02;
  const lngDelta = Math.abs(heroLocation.lng - customerLng) * 2.5 || 0.02;

  return (
    <View style={styles.container}>
      {/* ETA Badge */}
      {eta && (
        <View style={styles.etaBadge}>
          <Ionicons name="time-outline" size={16} color="#fff" />
          <Typography variant="body2" style={styles.etaText}>
            ETA: {eta}
          </Typography>
        </View>
      )}

      <MapView
        style={styles.map}
        provider={PROVIDER_DEFAULT}
        initialRegion={{
          latitude: midLat,
          longitude: midLng,
          latitudeDelta: latDelta,
          longitudeDelta: lngDelta,
        }}
        showsUserLocation={false}
        showsMyLocationButton={false}
      >
        {/* Hero Marker */}
        <Marker
          coordinate={{
            latitude: heroLocation.lat,
            longitude: heroLocation.lng,
          }}
          title="Service Provider"
          description="On the way"
        >
          <View style={styles.heroMarker}>
            <Ionicons name="car" size={24} color="#fff" />
          </View>
        </Marker>

        {/* Customer Location Marker */}
        <Marker
          coordinate={{
            latitude: customerLat,
            longitude: customerLng,
          }}
          title="Your Location"
          description={customerAddress}
        >
          <View style={styles.customerMarker}>
            <Ionicons name="home" size={24} color="#fff" />
          </View>
        </Marker>
      </MapView>

      {/* Map Legend */}
      <View style={styles.legend}>
        <View style={styles.legendItem}>
          <View style={styles.heroMarkerSmall}>
            <Ionicons name="car" size={12} color="#fff" />
          </View>
          <Typography variant="caption" style={styles.legendText}>
            Provider
          </Typography>
        </View>
        <View style={styles.legendItem}>
          <View style={styles.customerMarkerSmall}>
            <Ionicons name="home" size={12} color="#fff" />
          </View>
          <Typography variant="caption" style={styles.legendText}>
            You
          </Typography>
        </View>
      </View>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    height: 300,
    borderRadius: theme.borderRadius.lg,
    overflow: 'hidden',
    position: 'relative',
  },
  map: {
    width: '100%',
    height: '100%',
  },
  loadingContainer: {
    height: 300,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: theme.colors.neutral[100],
    borderRadius: theme.borderRadius.lg,
  },
  loadingText: {
    marginTop: theme.semanticSpacing.sm,
  },
  noLocationContainer: {
    height: 300,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: theme.colors.neutral[100],
    borderRadius: theme.borderRadius.lg,
    padding: theme.semanticSpacing.lg,
  },
  etaBadge: {
    position: 'absolute',
    top: theme.semanticSpacing.md,
    right: theme.semanticSpacing.md,
    backgroundColor: theme.colors.primary.main,
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: theme.semanticSpacing.md,
    paddingVertical: theme.semanticSpacing.sm,
    borderRadius: theme.borderRadius.full,
    zIndex: 10,
    ...theme.shadows.md,
    gap: 6,
  },
  etaText: {
    color: '#fff',
    fontWeight: '600',
  },
  heroMarker: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: theme.colors.primary.main,
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 3,
    borderColor: '#fff',
    ...theme.shadows.lg,
  },
  customerMarker: {
    width: 40,
    height: 40,
    borderRadius: 20,
    backgroundColor: theme.colors.success.main,
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 3,
    borderColor: '#fff',
    ...theme.shadows.lg,
  },
  legend: {
    position: 'absolute',
    bottom: theme.semanticSpacing.md,
    left: theme.semanticSpacing.md,
    backgroundColor: 'rgba(255, 255, 255, 0.95)',
    flexDirection: 'row',
    paddingHorizontal: theme.semanticSpacing.md,
    paddingVertical: theme.semanticSpacing.sm,
    borderRadius: theme.borderRadius.lg,
    gap: theme.semanticSpacing.md,
    ...theme.shadows.md,
  },
  legendItem: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 6,
  },
  heroMarkerSmall: {
    width: 24,
    height: 24,
    borderRadius: 12,
    backgroundColor: theme.colors.primary.main,
    justifyContent: 'center',
    alignItems: 'center',
  },
  customerMarkerSmall: {
    width: 24,
    height: 24,
    borderRadius: 12,
    backgroundColor: theme.colors.success.main,
    justifyContent: 'center',
    alignItems: 'center',
  },
  legendText: {
    fontSize: 12,
  },
});
