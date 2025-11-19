# JobDetailScreen Update Guide
**Date:** November 19, 2025

## Overview
Complete rewrite of JobDetailScreen.tsx to implement:
1. Correct status action flow
2. GPS tracking integration
3. Photo upload for job completion
4. Hide pricing
5. Accept/Decline functionality

---

## Key Changes Required

### 1. Add Imports
```typescript
import * as ImagePicker from 'expo-image-picker';
import { jobService } from '../../services/jobService';
import { gpsService } from '../../services/gpsService';
import { useAuth } from '../../contexts/AuthContext';
import { Modal, Image } from 'react-native';
```

### 2. Add State Variables
```typescript
const { heroProfile } = useAuth();
const [isTracking, setIsTracking] = useState(false);
const [showPhotoModal, setShowPhotoModal] = useState(false);
const [selectedPhoto, setSelectedPhoto] = useState<string | null>(null);
const [uploadingPhoto, setUploadingPhoto] = useState(false);
```

### 3. Remove Price Display
- Remove `price_cents` and `tip_cents` from JobDetail interface
- Remove payment section from UI
- Remove formatPrice function

### 4. Update Status Actions (getStatusActions function)

**Replace entire function with:**

```typescript
const getStatusActions = () => {
  if (!job) return null;

  switch (job.status) {
    case 'awaiting_hero_accept':
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
```

### 5. Add New Handler Functions

**Accept Job:**
```typescript
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
          Alert.alert('Success', 'Job accepted! You can now start your journey.');
          loadJobDetails();
        } else {
          Alert.alert('Error', result.error || 'Failed to accept job');
        }
      }}
    ]
  );
};
```

**Decline Job:**
```typescript
const handleDeclineJob = () => {
  Alert.alert(
    'Decline Job',
    'Are you sure you want to decline this job?',
    [
      { text: 'Cancel', style: 'cancel' },
      { text: 'Decline', style: 'destructive', onPress: async () => {
        setUpdating(true);
        const result = await jobService.declineJob({ bookingId: jobId });
        setUpdating(false);
        
        if (result.success) {
          Alert.alert('Job Declined', 'The job has been declined.');
          navigation.goBack();
        } else {
          Alert.alert('Error', result.error || 'Failed to decline job');
        }
      }}
    ]
  );
};
```

**Start En Route with GPS:**
```typescript
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
    intervalMs: 30000
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
    Alert.alert('En Route', 'GPS tracking started.');
    loadJobDetails();
  } else {
    await gpsService.stopTracking();
    Alert.alert('Error', statusResult.error || 'Failed to update status');
  }
};
```

**Mark Arrived:**
```typescript
const handleMarkArrived = async () => {
  setUpdating(true);
  await gpsService.stopTracking();
  setIsTracking(false);

  const result = await jobService.markArrived(jobId);
  setUpdating(false);

  if (result.success) {
    Alert.alert('Arrived', 'Customer has been notified.');
    loadJobDetails();
  } else {
    Alert.alert('Error', result.error || 'Failed to update status');
  }
};
```

**Start Job:**
```typescript
const handleStartJob = async () => {
  setUpdating(true);
  const result = await jobService.startJob(jobId);
  setUpdating(false);

  if (result.success) {
    Alert.alert('Job Started', 'Timer started. Good luck!');
    loadJobDetails();
  } else {
    Alert.alert('Error', result.error || 'Failed to start job');
  }
};
```

**Complete Job with Photo:**
```typescript
const handleCompleteJob = () => {
  Alert.alert(
    'Complete Job',
    'Please take a photo of the completed work.',
    [
      { text: 'Cancel', style: 'cancel' },
      { text: 'Take Photo', onPress: () => setShowPhotoModal(true) }
    ]
  );
};

const handleTakePhoto = async () => {
  const { status } = await ImagePicker.requestCameraPermissionsAsync();
  
  if (status !== 'granted') {
    Alert.alert('Permission Required', 'Camera permission is required');
    return;
  }

  const result = await ImagePicker.launchCameraAsync({
    mediaTypes: ImagePicker.MediaTypeOptions.Images,
    allowsEditing: true,
    aspect: [4, 3],
    quality: 0.8,
  });

  if (!result.canceled && result.assets[0]) {
    setSelectedPhoto(result.assets[0].uri);
  }
};

const handleUploadAndComplete = async () => {
  if (!selectedPhoto || !heroProfile) {
    Alert.alert('Error', 'Please take a photo first');
    return;
  }

  setUploadingPhoto(true);

  const uploadResult = await jobService.uploadJobPhoto({
    bookingId: jobId,
    heroId: heroProfile.id,
    photoUri: selectedPhoto,
    photoType: 'completion',
  });

  if (!uploadResult.success) {
    setUploadingPhoto(false);
    Alert.alert('Upload Error', uploadResult.error);
    return;
  }

  const completeResult = await jobService.completeJob(jobId, uploadResult.photoUrl!);
  setUploadingPhoto(false);

  if (completeResult.success) {
    setShowPhotoModal(false);
    setSelectedPhoto(null);
    Alert.alert('Job Completed', 'Great work!');
    loadJobDetails();
  } else {
    Alert.alert('Error', completeResult.error);
  }
};
```

### 6. Add Photo Modal UI

Add before closing `</View>` tag:

```typescript
<Modal
  visible={showPhotoModal}
  animationType="slide"
  transparent={true}
  onRequestClose={() => setShowPhotoModal(false)}
>
  <View style={styles.modalContainer}>
    <View style={styles.modalContent}>
      <Text style={styles.modalTitle}>Job Completion Photo</Text>
      
      {selectedPhoto ? (
        <View style={styles.photoPreview}>
          <Image source={{ uri: selectedPhoto }} style={styles.photoImage} />
          <TouchableOpacity style={styles.retakeButton} onPress={handleTakePhoto}>
            <Text style={styles.retakeButtonText}>Retake Photo</Text>
          </TouchableOpacity>
        </View>
      ) : (
        <TouchableOpacity style={styles.takePhotoButton} onPress={handleTakePhoto}>
          <Ionicons name="camera" size={48} color="#FF6B35" />
          <Text style={styles.takePhotoText}>Take Photo</Text>
        </TouchableOpacity>
      )}

      <View style={styles.modalButtons}>
        <TouchableOpacity 
          style={[styles.modalButton, styles.modalCancelButton]}
          onPress={() => {
            setShowPhotoModal(false);
            setSelectedPhoto(null);
          }}
        >
          <Text style={styles.modalCancelText}>Cancel</Text>
        </TouchableOpacity>

        {selectedPhoto && (
          <TouchableOpacity 
            style={[styles.modalButton, styles.modalConfirmButton]}
            onPress={handleUploadAndComplete}
            disabled={uploadingPhoto}
          >
            {uploadingPhoto ? (
              <ActivityIndicator color="#fff" />
            ) : (
              <Text style={styles.modalConfirmText}>Complete Job</Text>
            )}
          </TouchableOpacity>
        )}
      </View>
    </View>
  </View>
</Modal>
```

### 7. Add New Styles

```typescript
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
```

---

## Installation Requirements

Add to `package.json`:
```json
"expo-image-picker": "~14.3.2",
"expo-location": "~16.1.0"
```

Run:
```bash
cd Homeheros_go_app
npm install
```

---

## Testing Checklist

- [ ] Accept job from `awaiting_hero_accept` status
- [ ] Decline job and verify navigation back
- [ ] Start en route and verify GPS tracking starts
- [ ] Mark arrived and verify GPS stops
- [ ] Start job
- [ ] Take photo and complete job
- [ ] Verify photo uploads to Supabase
- [ ] Verify status updates in real-time
- [ ] Verify customer sees status changes in main app

---

## Notes

- GPS tracking runs in background every 30 seconds
- Photo is required for job completion
- All status changes trigger notifications to customer
- Pricing is hidden from hero view
- Real-time updates via Supabase subscriptions
