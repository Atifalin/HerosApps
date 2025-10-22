-- Fix bookings table to reference profiles instead of users
-- Migration: 20251022_fix_bookings_foreign_keys.sql

-- Drop the old foreign key constraint
ALTER TABLE bookings 
DROP CONSTRAINT IF EXISTS bookings_customer_id_fkey;

-- Add new foreign key constraint referencing profiles
ALTER TABLE bookings 
ADD CONSTRAINT bookings_customer_id_fkey 
FOREIGN KEY (customer_id) 
REFERENCES profiles(id) 
ON DELETE CASCADE;

-- Update the RLS policy that references users table
DROP POLICY IF EXISTS "heros_read_assigned_bookings" ON bookings;

CREATE POLICY "heros_read_assigned_bookings" 
ON bookings 
FOR SELECT 
USING (
  EXISTS (
    SELECT 1
    FROM profiles
    WHERE profiles.id = auth.uid() 
    AND profiles.role = 'hero'
    AND EXISTS (
      SELECT 1
      FROM heros
      WHERE heros.user_id = auth.uid() 
      AND heros.id = bookings.hero_id
    )
  )
);

-- Verify the changes
SELECT 
    conname as constraint_name,
    conrelid::regclass as table_name,
    confrelid::regclass as referenced_table
FROM pg_constraint
WHERE conname = 'bookings_customer_id_fkey';
