import React, { useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  Modal,
  TouchableOpacity,
  Image,
  ActivityIndicator,
  Alert,
  ScrollView,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import * as ImagePicker from 'expo-image-picker';
import * as Location from 'expo-location';
import { supabase } from '../lib/supabase';

export type PhotoCheckpoint = 'arrival' | 'before' | 'after';

interface PhotoCaptureModalProps {
  visible: boolean;
  bookingId: string;
  heroId: string;
  photoType: PhotoCheckpoint;
  onClose: () => void;
  onSuccess: (photo: {
    id: string;
    photo_url: string;
    distance_from_address_m: number | null;
    inside_geofence: boolean | null;
  }) => void;
}

const CHECKPOINT_COPY: Record<PhotoCheckpoint, { title: string; subtitle: string; primaryLabel: string }> = {
  arrival: {
    title: 'Proof of Arrival',
    subtitle: 'Take a photo of the property from where you are parked. Your GPS location will be attached.',
    primaryLabel: 'Capture Arrival Photo',
  },
  before: {
    title: 'Before Photo',
    subtitle: 'Take a photo of the area or item before you start the work.',
    primaryLabel: 'Capture Before Photo',
  },
  after: {
    title: 'After Photo',
    subtitle: 'Take a photo of the completed work for the customer.',
    primaryLabel: 'Capture After Photo',
  },
};

export const PhotoCaptureModal: React.FC<PhotoCaptureModalProps> = ({
  visible,
  bookingId,
  heroId,
  photoType,
  onClose,
  onSuccess,
}) => {
  const [photoUri, setPhotoUri] = useState<string | null>(null);
  const [location, setLocation] = useState<{ lat: number; lng: number } | null>(null);
  const [capturing, setCapturing] = useState(false);
  const [uploading, setUploading] = useState(false);

  const copy = CHECKPOINT_COPY[photoType];

  const reset = () => {
    setPhotoUri(null);
    setLocation(null);
    setUploading(false);
    setCapturing(false);
  };

  const handleClose = () => {
    if (uploading) return;
    reset();
    onClose();
  };

  const handleCapture = async () => {
    try {
      setCapturing(true);

      // 1. Camera permission
      const cam = await ImagePicker.requestCameraPermissionsAsync();
      if (cam.status !== 'granted') {
        Alert.alert(
          'Camera Permission Required',
          'HomeHeros Go needs access to your camera to capture job photos. Please enable it in Settings.'
        );
        setCapturing(false);
        return;
      }

      // 2. Location permission (required for arrival geofence; optional but useful for before/after)
      const loc = await Location.requestForegroundPermissionsAsync();
      if (loc.status !== 'granted') {
        if (photoType === 'arrival') {
          Alert.alert(
            'Location Permission Required',
            'Location access is required to verify you are at the customer\'s address. Please enable it in Settings.'
          );
          setCapturing(false);
          return;
        }
        // For before/after, continue without GPS but warn user once
        console.warn('Location denied; photo will upload without GPS metadata.');
      }

      // 3. Grab current location (parallel with camera launch would be nicer but keep it simple)
      let coords: { lat: number; lng: number } | null = null;
      if (loc.status === 'granted') {
        try {
          const pos = await Location.getCurrentPositionAsync({ accuracy: Location.Accuracy.High });
          coords = { lat: pos.coords.latitude, lng: pos.coords.longitude };
        } catch (err) {
          console.warn('Failed to get current location:', err);
        }
      }

      // 4. Launch camera
      const result = await ImagePicker.launchCameraAsync({
        mediaTypes: ImagePicker.MediaTypeOptions.Images,
        allowsEditing: false,
        quality: 0.7,
        exif: false,
      });

      if (result.canceled || !result.assets?.[0]) {
        setCapturing(false);
        return;
      }

      setPhotoUri(result.assets[0].uri);
      setLocation(coords);
      setCapturing(false);
    } catch (err: any) {
      console.error('Photo capture error:', err);
      Alert.alert('Error', err?.message || 'Failed to capture photo.');
      setCapturing(false);
    }
  };

  const handleSubmit = async () => {
    if (!photoUri) {
      Alert.alert('No Photo', 'Please capture a photo first.');
      return;
    }

    setUploading(true);

    try {
      // Upload blob to storage
      const response = await fetch(photoUri);
      const blob = await response.blob();
      const fileExt = (photoUri.split('.').pop() || 'jpg').toLowerCase();
      const fileName = `${bookingId}/${photoType}_${Date.now()}.${fileExt}`;
      const storagePath = fileName;

      const { error: uploadError } = await supabase.storage
        .from('booking_photos')
        .upload(storagePath, blob, {
          contentType: `image/${fileExt === 'jpg' ? 'jpeg' : fileExt}`,
          upsert: false,
        });

      if (uploadError) {
        throw new Error(`Upload failed: ${uploadError.message}`);
      }

      const {
        data: { publicUrl },
      } = supabase.storage.from('booking_photos').getPublicUrl(storagePath);

      // Insert row; trigger fills distance_from_address_m + inside_geofence
      const { data: photoRow, error: insertError } = await supabase
        .from('booking_photos')
        .insert({
          booking_id: bookingId,
          uploaded_by: heroId,
          photo_url: publicUrl,
          photo_type: photoType,
          lat: location?.lat ?? null,
          lng: location?.lng ?? null,
          caption: null,
        })
        .select('id, photo_url, distance_from_address_m, inside_geofence')
        .single();

      if (insertError) {
        throw new Error(`Save failed: ${insertError.message}`);
      }

      setUploading(false);

      // Geofence warning for arrival
      if (
        photoType === 'arrival' &&
        photoRow.distance_from_address_m != null &&
        photoRow.inside_geofence === false
      ) {
        Alert.alert(
          'Outside Geofence',
          `You appear to be ${Math.round(
            photoRow.distance_from_address_m
          )}m from the customer's address. This photo has been flagged for admin review.`,
          [
            {
              text: 'OK',
              onPress: () => {
                reset();
                onSuccess(photoRow);
              },
            },
          ]
        );
      } else {
        reset();
        onSuccess(photoRow);
      }
    } catch (err: any) {
      console.error('Photo submit error:', err);
      Alert.alert('Error', err?.message || 'Failed to upload photo.');
      setUploading(false);
    }
  };

  return (
    <Modal visible={visible} animationType="slide" transparent onRequestClose={handleClose}>
      <View style={styles.backdrop}>
        <View style={styles.sheet}>
          <View style={styles.header}>
            <Text style={styles.title}>{copy.title}</Text>
            <TouchableOpacity onPress={handleClose} disabled={uploading} hitSlop={{ top: 10, bottom: 10, left: 10, right: 10 }}>
              <Ionicons name="close" size={26} color={uploading ? '#ccc' : '#333'} />
            </TouchableOpacity>
          </View>

          <ScrollView contentContainerStyle={styles.scroll}>
            <Text style={styles.subtitle}>{copy.subtitle}</Text>

            {photoUri ? (
              <View style={styles.previewWrap}>
                <Image source={{ uri: photoUri }} style={styles.preview} />
                {location && (
                  <View style={styles.gpsBadge}>
                    <Ionicons name="location" size={14} color="#fff" />
                    <Text style={styles.gpsBadgeText}>GPS attached</Text>
                  </View>
                )}
              </View>
            ) : (
              <View style={styles.placeholder}>
                <Ionicons name="camera-outline" size={64} color="#aaa" />
                <Text style={styles.placeholderText}>No photo yet</Text>
              </View>
            )}

            <View style={styles.actions}>
              <TouchableOpacity
                style={[styles.captureBtn, capturing && styles.btnDisabled]}
                onPress={handleCapture}
                disabled={capturing || uploading}
              >
                {capturing ? (
                  <ActivityIndicator color="#fff" />
                ) : (
                  <>
                    <Ionicons name={photoUri ? 'refresh' : 'camera'} size={20} color="#fff" />
                    <Text style={styles.captureBtnText}>{photoUri ? 'Retake Photo' : copy.primaryLabel}</Text>
                  </>
                )}
              </TouchableOpacity>

              {photoUri && (
                <TouchableOpacity
                  style={[styles.submitBtn, uploading && styles.btnDisabled]}
                  onPress={handleSubmit}
                  disabled={uploading}
                >
                  {uploading ? (
                    <ActivityIndicator color="#fff" />
                  ) : (
                    <>
                      <Ionicons name="cloud-upload" size={20} color="#fff" />
                      <Text style={styles.submitBtnText}>Upload &amp; Continue</Text>
                    </>
                  )}
                </TouchableOpacity>
              )}
            </View>
          </ScrollView>
        </View>
      </View>
    </Modal>
  );
};

const styles = StyleSheet.create({
  backdrop: {
    flex: 1,
    backgroundColor: 'rgba(0,0,0,0.5)',
    justifyContent: 'flex-end',
  },
  sheet: {
    backgroundColor: '#fff',
    borderTopLeftRadius: 16,
    borderTopRightRadius: 16,
    maxHeight: '92%',
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'space-between',
    padding: 16,
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: '#eee',
  },
  title: { fontSize: 18, fontWeight: '600', color: '#222' },
  scroll: { padding: 16, paddingBottom: 32 },
  subtitle: { fontSize: 14, color: '#666', lineHeight: 20, marginBottom: 16 },
  previewWrap: {
    position: 'relative',
    marginBottom: 16,
    borderRadius: 12,
    overflow: 'hidden',
    backgroundColor: '#eee',
  },
  preview: { width: '100%', height: 280 },
  gpsBadge: {
    position: 'absolute',
    top: 12,
    left: 12,
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: 'rgba(0,0,0,0.65)',
    paddingHorizontal: 10,
    paddingVertical: 6,
    borderRadius: 14,
  },
  gpsBadgeText: { color: '#fff', fontSize: 12, fontWeight: '500', marginLeft: 4 },
  placeholder: {
    height: 220,
    borderRadius: 12,
    borderWidth: 2,
    borderColor: '#ddd',
    borderStyle: 'dashed',
    alignItems: 'center',
    justifyContent: 'center',
    marginBottom: 16,
    backgroundColor: '#fafafa',
  },
  placeholderText: { color: '#aaa', marginTop: 8, fontSize: 14 },
  actions: { gap: 12 },
  captureBtn: {
    backgroundColor: '#FF6B35',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 14,
    borderRadius: 10,
    gap: 8,
  },
  captureBtnText: { color: '#fff', fontWeight: '600', fontSize: 15 },
  submitBtn: {
    backgroundColor: '#2E7D32',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    paddingVertical: 14,
    borderRadius: 10,
    gap: 8,
  },
  submitBtnText: { color: '#fff', fontWeight: '600', fontSize: 15 },
  btnDisabled: { opacity: 0.6 },
});
