import * as Location from 'expo-location';
import { supabase } from '../lib/supabase';

export interface GPSTrackingConfig {
  bookingId: string;
  heroId: string;
  intervalMs?: number; // Default 30000 (30 seconds)
}

/**
 * GPS Service - Handles background location tracking for heroes
 */
class GPSService {
  private isTracking: boolean = false;
  private trackingInterval: NodeJS.Timeout | null = null;
  private currentConfig: GPSTrackingConfig | null = null;
  private locationSubscription: Location.LocationSubscription | null = null;

  /**
   * Request location permissions
   */
  async requestPermissions(): Promise<{ granted: boolean; error?: string }> {
    try {
      const { status: foregroundStatus } = await Location.requestForegroundPermissionsAsync();
      
      if (foregroundStatus !== 'granted') {
        return { 
          granted: false, 
          error: 'Location permission is required to track your journey' 
        };
      }

      // Request background permissions for iOS
      const { status: backgroundStatus } = await Location.requestBackgroundPermissionsAsync();
      
      if (backgroundStatus !== 'granted') {
        console.warn('Background location permission not granted');
        // Continue anyway - foreground tracking will work
      }

      return { granted: true };
    } catch (error: any) {
      console.error('Error requesting location permissions:', error);
      return { granted: false, error: error.message };
    }
  }

  /**
   * Check if location services are enabled
   */
  async isLocationEnabled(): Promise<boolean> {
    try {
      return await Location.hasServicesEnabledAsync();
    } catch (error) {
      console.error('Error checking location services:', error);
      return false;
    }
  }

  /**
   * Start GPS tracking
   */
  async startTracking(config: GPSTrackingConfig): Promise<{ success: boolean; error?: string }> {
    try {
      // Check if already tracking
      if (this.isTracking) {
        console.warn('GPS tracking already active');
        return { success: false, error: 'Tracking already active' };
      }

      // Check permissions
      const permissionResult = await this.requestPermissions();
      if (!permissionResult.granted) {
        return { success: false, error: permissionResult.error };
      }

      // Check if location services are enabled
      const locationEnabled = await this.isLocationEnabled();
      if (!locationEnabled) {
        return { 
          success: false, 
          error: 'Please enable location services in your device settings' 
        };
      }

      this.currentConfig = config;
      this.isTracking = true;

      // Start location updates
      this.locationSubscription = await Location.watchPositionAsync(
        {
          accuracy: Location.Accuracy.High,
          timeInterval: config.intervalMs || 30000, // 30 seconds
          distanceInterval: 50, // Update every 50 meters
        },
        async (location) => {
          await this.sendLocationPing(location);
        }
      );

      console.log('GPS tracking started for booking:', config.bookingId);
      return { success: true };
    } catch (error: any) {
      console.error('Error starting GPS tracking:', error);
      this.isTracking = false;
      return { success: false, error: error.message };
    }
  }

  /**
   * Stop GPS tracking
   */
  async stopTracking(): Promise<{ success: boolean }> {
    try {
      if (this.locationSubscription) {
        this.locationSubscription.remove();
        this.locationSubscription = null;
      }

      if (this.trackingInterval) {
        clearInterval(this.trackingInterval);
        this.trackingInterval = null;
      }

      this.isTracking = false;
      this.currentConfig = null;

      console.log('GPS tracking stopped');
      return { success: true };
    } catch (error) {
      console.error('Error stopping GPS tracking:', error);
      return { success: false };
    }
  }

  /**
   * Send location ping to database
   */
  private async sendLocationPing(location: Location.LocationObject): Promise<void> {
    if (!this.currentConfig) {
      console.warn('No tracking config available');
      return;
    }

    try {
      const { bookingId, heroId } = this.currentConfig;
      const { latitude, longitude, speed } = location.coords;

      const { error } = await supabase
        .from('gps_pings')
        .insert({
          booking_id: bookingId,
          hero_id: heroId,
          lat: latitude,
          lng: longitude,
          speed: speed || 0,
          ts: new Date().toISOString()
        });

      if (error) {
        console.error('Error sending GPS ping:', error);
      } else {
        console.log('GPS ping sent:', { latitude, longitude, speed });
      }
    } catch (error) {
      console.error('Error in sendLocationPing:', error);
    }
  }

  /**
   * Get current location (one-time)
   */
  async getCurrentLocation(): Promise<{ 
    success: boolean; 
    location?: Location.LocationObject; 
    error?: string 
  }> {
    try {
      const permissionResult = await this.requestPermissions();
      if (!permissionResult.granted) {
        return { success: false, error: permissionResult.error };
      }

      const location = await Location.getCurrentPositionAsync({
        accuracy: Location.Accuracy.High,
      });

      return { success: true, location };
    } catch (error: any) {
      console.error('Error getting current location:', error);
      return { success: false, error: error.message };
    }
  }

  /**
   * Check if currently tracking
   */
  isCurrentlyTracking(): boolean {
    return this.isTracking;
  }

  /**
   * Get current tracking config
   */
  getCurrentConfig(): GPSTrackingConfig | null {
    return this.currentConfig;
  }
}

// Export singleton instance
export const gpsService = new GPSService();
