import React, { useEffect, useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  Image,
  TouchableOpacity,
  Modal,
  Dimensions,
  ActivityIndicator,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { supabase } from '../lib/supabase';
import { theme } from '../theme';

type PhotoType = 'arrival' | 'before' | 'after' | 'issue' | 'other';

interface BookingPhoto {
  id: string;
  photo_url: string;
  photo_type: PhotoType;
  taken_at: string | null;
  created_at: string;
  distance_from_address_m: number | null;
  inside_geofence: boolean | null;
}

interface BookingPhotoTimelineProps {
  bookingId: string;
}

const CHECKPOINT_ORDER: PhotoType[] = ['arrival', 'before', 'after'];

const CHECKPOINT_LABEL: Record<PhotoType, string> = {
  arrival: 'Arrival',
  before: 'Before',
  after: 'After',
  issue: 'Issue Reported',
  other: 'Photo',
};

const CHECKPOINT_ICON: Record<PhotoType, keyof typeof Ionicons.glyphMap> = {
  arrival: 'location',
  before: 'camera-outline',
  after: 'checkmark-done',
  issue: 'alert-circle',
  other: 'image',
};

const { width: SCREEN_WIDTH } = Dimensions.get('window');

export const BookingPhotoTimeline: React.FC<BookingPhotoTimelineProps> = ({ bookingId }) => {
  const [photos, setPhotos] = useState<BookingPhoto[]>([]);
  const [loading, setLoading] = useState(true);
  const [activePhoto, setActivePhoto] = useState<BookingPhoto | null>(null);

  const load = async () => {
    const { data, error } = await supabase
      .from('booking_photos')
      .select(
        'id, photo_url, photo_type, taken_at, created_at, distance_from_address_m, inside_geofence'
      )
      .eq('booking_id', bookingId)
      .order('created_at', { ascending: true });

    if (error) {
      console.error('Error loading booking photos:', error);
    } else {
      setPhotos((data || []) as BookingPhoto[]);
    }
    setLoading(false);
  };

  useEffect(() => {
    load();

    // Realtime subscription for new photos
    const channel = supabase
      .channel(`booking_photos-${bookingId}`)
      .on(
        'postgres_changes',
        {
          event: 'INSERT',
          schema: 'public',
          table: 'booking_photos',
          filter: `booking_id=eq.${bookingId}`,
        },
        () => {
          load();
        }
      )
      .subscribe();

    return () => {
      supabase.removeChannel(channel);
    };
  }, [bookingId]);

  const formatTime = (iso: string) => {
    const d = new Date(iso);
    return d.toLocaleTimeString('en-US', { hour: 'numeric', minute: '2-digit' });
  };

  // Map checkpoint -> photo (if uploaded)
  const photoByType: Partial<Record<PhotoType, BookingPhoto>> = {};
  photos.forEach((p) => {
    // Prefer the first photo of each type
    if (!photoByType[p.photo_type]) photoByType[p.photo_type] = p;
  });

  if (loading) {
    return (
      <View style={styles.loading}>
        <ActivityIndicator color={theme?.colors?.primary || '#FF6B35'} />
      </View>
    );
  }

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Job Progress Photos</Text>

      <View style={styles.timeline}>
        {CHECKPOINT_ORDER.map((type, idx) => {
          const photo = photoByType[type];
          const done = !!photo;
          return (
            <View key={type} style={styles.step}>
              <View style={styles.stepHeader}>
                <View
                  style={[
                    styles.bullet,
                    done ? styles.bulletDone : styles.bulletPending,
                  ]}
                >
                  <Ionicons
                    name={done ? 'checkmark' : CHECKPOINT_ICON[type]}
                    size={14}
                    color="#fff"
                  />
                </View>
                <Text style={styles.stepLabel}>{CHECKPOINT_LABEL[type]}</Text>
                {photo && (
                  <Text style={styles.stepTime}>{formatTime(photo.taken_at || photo.created_at)}</Text>
                )}
              </View>

              {photo ? (
                <TouchableOpacity
                  style={styles.thumbWrap}
                  onPress={() => setActivePhoto(photo)}
                  activeOpacity={0.85}
                >
                  <Image source={{ uri: photo.photo_url }} style={styles.thumb} />
                  {photo.distance_from_address_m != null && (
                    <View
                      style={[
                        styles.geoBadge,
                        photo.inside_geofence
                          ? styles.geoBadgeOk
                          : styles.geoBadgeWarn,
                      ]}
                    >
                      <Ionicons
                        name={photo.inside_geofence ? 'shield-checkmark' : 'warning'}
                        size={12}
                        color="#fff"
                      />
                      <Text style={styles.geoBadgeText}>
                        {Math.round(photo.distance_from_address_m)}m
                      </Text>
                    </View>
                  )}
                </TouchableOpacity>
              ) : (
                <View style={styles.pendingWrap}>
                  <Text style={styles.pendingText}>Pending…</Text>
                </View>
              )}

              {idx < CHECKPOINT_ORDER.length - 1 && <View style={styles.connector} />}
            </View>
          );
        })}
      </View>

      {/* Full-screen image viewer */}
      <Modal
        visible={!!activePhoto}
        transparent
        animationType="fade"
        onRequestClose={() => setActivePhoto(null)}
      >
        <View style={styles.viewerBackdrop}>
          <TouchableOpacity
            style={styles.viewerClose}
            onPress={() => setActivePhoto(null)}
            hitSlop={{ top: 12, bottom: 12, left: 12, right: 12 }}
          >
            <Ionicons name="close" size={30} color="#fff" />
          </TouchableOpacity>
          {activePhoto && (
            <Image
              source={{ uri: activePhoto.photo_url }}
              style={styles.viewerImage}
              resizeMode="contain"
            />
          )}
          {activePhoto && (
            <View style={styles.viewerMeta}>
              <Text style={styles.viewerMetaLabel}>
                {CHECKPOINT_LABEL[activePhoto.photo_type]}
              </Text>
              <Text style={styles.viewerMetaTime}>
                {new Date(activePhoto.taken_at || activePhoto.created_at).toLocaleString()}
              </Text>
              {activePhoto.distance_from_address_m != null && (
                <Text style={styles.viewerMetaTime}>
                  {Math.round(activePhoto.distance_from_address_m)}m from address •{' '}
                  {activePhoto.inside_geofence ? 'Inside geofence' : 'Outside geofence'}
                </Text>
              )}
            </View>
          )}
        </View>
      </Modal>
    </View>
  );
};

const PRIMARY = '#4B5D2F'; // HomeHeros military green fallback

const styles = StyleSheet.create({
  loading: { padding: 24, alignItems: 'center' },
  container: {
    backgroundColor: '#fff',
    borderRadius: 12,
    padding: 16,
    marginHorizontal: 16,
    marginVertical: 8,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.06,
    shadowRadius: 3,
    elevation: 2,
  },
  title: {
    fontSize: 16,
    fontWeight: '600',
    color: '#222',
    marginBottom: 12,
  },
  timeline: { gap: 12 },
  step: { position: 'relative' },
  stepHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
    marginBottom: 6,
  },
  bullet: {
    width: 22,
    height: 22,
    borderRadius: 11,
    alignItems: 'center',
    justifyContent: 'center',
  },
  bulletDone: { backgroundColor: PRIMARY },
  bulletPending: { backgroundColor: '#bbb' },
  stepLabel: { flex: 1, fontSize: 14, fontWeight: '500', color: '#333' },
  stepTime: { fontSize: 12, color: '#888' },
  thumbWrap: {
    position: 'relative',
    borderRadius: 10,
    overflow: 'hidden',
    marginLeft: 30,
    height: 160,
  },
  thumb: { width: '100%', height: '100%' },
  geoBadge: {
    position: 'absolute',
    bottom: 8,
    right: 8,
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: 8,
    paddingVertical: 4,
    borderRadius: 10,
    gap: 4,
  },
  geoBadgeOk: { backgroundColor: 'rgba(46,125,50,0.9)' },
  geoBadgeWarn: { backgroundColor: 'rgba(255,152,0,0.95)' },
  geoBadgeText: { color: '#fff', fontSize: 11, fontWeight: '600' },
  pendingWrap: {
    marginLeft: 30,
    height: 60,
    borderRadius: 10,
    borderWidth: 1,
    borderColor: '#e5e5e5',
    borderStyle: 'dashed',
    alignItems: 'center',
    justifyContent: 'center',
    backgroundColor: '#fafafa',
  },
  pendingText: { color: '#aaa', fontSize: 13 },
  connector: {
    position: 'absolute',
    left: 10,
    top: 28,
    bottom: -12,
    width: 2,
    backgroundColor: '#e5e5e5',
  },
  viewerBackdrop: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.95)',
    alignItems: 'center',
    justifyContent: 'center',
  },
  viewerClose: { position: 'absolute', top: 50, right: 20, zIndex: 2 },
  viewerImage: { width: SCREEN_WIDTH, height: SCREEN_WIDTH * 1.25 },
  viewerMeta: {
    position: 'absolute',
    bottom: 40,
    left: 20,
    right: 20,
    padding: 12,
    backgroundColor: 'rgba(0,0,0,0.55)',
    borderRadius: 10,
  },
  viewerMetaLabel: { color: '#fff', fontSize: 16, fontWeight: '600' },
  viewerMetaTime: { color: '#ddd', fontSize: 12, marginTop: 4 },
});
