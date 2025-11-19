-- Setup storage bucket and policies for booking photos
-- Date: 2025-11-20
-- Issue: Photo upload was failing due to missing storage policies

-- Make booking_photos bucket public
UPDATE storage.buckets
SET public = true
WHERE name = 'booking_photos';

-- Allow authenticated users to upload photos
CREATE POLICY "Authenticated users can upload photos"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'booking_photos');

-- Allow anyone to view photos (public bucket)
CREATE POLICY "Anyone can view photos"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'booking_photos');
