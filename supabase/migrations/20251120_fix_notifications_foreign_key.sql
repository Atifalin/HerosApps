-- Fix notifications foreign key to reference profiles instead of auth.users
-- Date: 2025-11-20
-- Issue: Triggers couldn't insert notifications due to cross-schema foreign key issues

-- Drop the foreign key constraint that references auth.users
ALTER TABLE notifications 
DROP CONSTRAINT IF EXISTS notifications_user_id_fkey;

-- Add new foreign key to profiles table (same schema, same UUIDs)
ALTER TABLE notifications
ADD CONSTRAINT notifications_user_id_fkey 
FOREIGN KEY (user_id) REFERENCES profiles(id) ON DELETE CASCADE;
