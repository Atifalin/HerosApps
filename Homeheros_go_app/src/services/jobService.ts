import { supabase } from '../lib/supabase';
import { Alert } from 'react-native';

export interface JobStatusUpdate {
  bookingId: string;
  newStatus: string;
  notes?: string;
}

export interface DeclineJobParams {
  bookingId: string;
  reason?: string;
}

/**
 * Job Service - Handles all job-related operations for heroes
 */
export const jobService = {
  /**
   * Update job status
   */
  async updateJobStatus(params: JobStatusUpdate): Promise<{ success: boolean; error?: string }> {
    try {
      const { bookingId, newStatus, notes } = params;

      const { error } = await supabase
        .from('bookings')
        .update({ status: newStatus })
        .eq('id', bookingId);

      if (error) {
        console.error('Error updating job status:', error);
        return { success: false, error: error.message };
      }

      // Status history is automatically created by trigger
      return { success: true };
    } catch (error: any) {
      console.error('Error in updateJobStatus:', error);
      return { success: false, error: error.message };
    }
  },

  /**
   * Accept a job - just marks internally that hero accepted, doesn't change status
   * Status stays as 'awaiting_hero_accept' until hero starts journey
   */
  async acceptJob(bookingId: string): Promise<{ success: boolean; error?: string }> {
    // Don't change status, just return success
    // The UI will show "Start Journey" button after accepting
    return { success: true };
  },

  /**
   * Decline a job
   */
  async declineJob(params: DeclineJobParams): Promise<{ success: boolean; error?: string }> {
    try {
      const { bookingId, reason } = params;

      const { error } = await supabase
        .from('bookings')
        .update({ 
          status: 'declined',
          notes: reason ? `Hero declined: ${reason}` : 'Hero declined the job'
        })
        .eq('id', bookingId);

      if (error) {
        console.error('Error declining job:', error);
        return { success: false, error: error.message };
      }

      return { success: true };
    } catch (error: any) {
      console.error('Error in declineJob:', error);
      return { success: false, error: error.message };
    }
  },

  /**
   * Start en route to job
   */
  async startEnRoute(bookingId: string): Promise<{ success: boolean; error?: string }> {
    return await jobService.updateJobStatus({
      bookingId,
      newStatus: 'enroute',
      notes: 'Hero started journey to customer location'
    });
  },

  /**
   * Mark as arrived at job location
   */
  async markArrived(bookingId: string): Promise<{ success: boolean; error?: string }> {
    return await jobService.updateJobStatus({
      bookingId,
      newStatus: 'arrived',
      notes: 'Hero arrived at customer location'
    });
  },

  /**
   * Start working on the job
   */
  async startJob(bookingId: string): Promise<{ success: boolean; error?: string }> {
    return await jobService.updateJobStatus({
      bookingId,
      newStatus: 'in_progress',
      notes: 'Hero started working on the job'
    });
  },

  /**
   * Complete the job (requires photo upload first)
   */
  async completeJob(bookingId: string, photoUrl: string): Promise<{ success: boolean; error?: string }> {
    try {
      // First, verify photo was uploaded
      if (!photoUrl) {
        return { success: false, error: 'Photo is required to complete the job' };
      }

      // Update job status to completed
      const statusResult = await jobService.updateJobStatus({
        bookingId,
        newStatus: 'completed',
        notes: 'Hero completed the job'
      });

      if (!statusResult.success) {
        return statusResult;
      }

      return { success: true };
    } catch (error: any) {
      console.error('Error in completeJob:', error);
      return { success: false, error: error.message };
    }
  },

  /**
   * Upload job completion photo
   */
  async uploadJobPhoto(params: {
    bookingId: string;
    heroId: string;
    photoUri: string;
    photoType: 'completion' | 'arrival' | 'in_progress' | 'issue';
    caption?: string;
  }): Promise<{ success: boolean; photoUrl?: string; error?: string }> {
    try {
      const { bookingId, heroId, photoUri, photoType, caption } = params;

      // Convert URI to blob for upload
      const response = await fetch(photoUri);
      const blob = await response.blob();
      
      // Generate unique filename
      const fileExt = photoUri.split('.').pop();
      const fileName = `${bookingId}/${photoType}_${Date.now()}.${fileExt}`;
      const filePath = `job-photos/${fileName}`;

      // Upload to Supabase storage
      const { data: uploadData, error: uploadError } = await supabase.storage
        .from('booking_photos')
        .upload(filePath, blob, {
          contentType: `image/${fileExt}`,
          upsert: false
        });

      if (uploadError) {
        console.error('Error uploading photo:', uploadError);
        return { success: false, error: uploadError.message };
      }

      // Get public URL
      const { data: { publicUrl } } = supabase.storage
        .from('booking_photos')
        .getPublicUrl(filePath);

      // Get current user ID
      const { data: { user } } = await supabase.auth.getUser();
      if (!user) {
        return { success: false, error: 'User not authenticated' };
      }

      // Save photo record to database
      const { error: dbError } = await supabase
        .from('booking_photos')
        .insert({
          booking_id: bookingId,
          uploaded_by: user.id,
          photo_url: publicUrl,
          photo_type: photoType,
          caption: caption || null
        });

      if (dbError) {
        console.error('Error saving photo record:', dbError);
        return { success: false, error: dbError.message };
      }

      return { success: true, photoUrl: publicUrl };
    } catch (error: any) {
      console.error('Error in uploadJobPhoto:', error);
      return { success: false, error: error.message };
    }
  },

  /**
   * Get job photos
   */
  async getJobPhotos(bookingId: string): Promise<{ success: boolean; photos?: any[]; error?: string }> {
    try {
      const { data, error } = await supabase
        .from('booking_photos')
        .select('*')
        .eq('booking_id', bookingId)
        .order('created_at', { ascending: false });

      if (error) {
        console.error('Error fetching job photos:', error);
        return { success: false, error: error.message };
      }

      return { success: true, photos: data || [] };
    } catch (error: any) {
      console.error('Error in getJobPhotos:', error);
      return { success: false, error: error.message };
    }
  }
};
