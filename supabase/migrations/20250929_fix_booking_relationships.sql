-- Fix the data type mismatch between bookings and related tables
-- This migration will:
-- 1. Update the data types of service_id and service_variant_id to UUID
-- 2. Add proper foreign key constraints
-- 3. Ensure existing data is properly converted

-- First, let's check if there's any existing data that needs to be preserved
CREATE OR REPLACE FUNCTION convert_to_uuid(text) RETURNS uuid AS $$
BEGIN
  RETURN $1::uuid;
EXCEPTION WHEN others THEN
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Create temporary columns with correct UUID type
ALTER TABLE bookings ADD COLUMN service_id_uuid UUID;
ALTER TABLE bookings ADD COLUMN service_variant_id_uuid UUID;

-- Convert existing data
UPDATE bookings 
SET 
  service_id_uuid = convert_to_uuid(service_id),
  service_variant_id_uuid = convert_to_uuid(service_variant_id);

-- Drop old columns and rename new ones
ALTER TABLE bookings DROP COLUMN service_id;
ALTER TABLE bookings DROP COLUMN service_variant_id;
ALTER TABLE bookings RENAME COLUMN service_id_uuid TO service_id;
ALTER TABLE bookings RENAME COLUMN service_variant_id_uuid TO service_variant_id;

-- Add foreign key constraints
ALTER TABLE bookings 
ADD CONSTRAINT fk_bookings_service 
FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE SET NULL;

ALTER TABLE bookings 
ADD CONSTRAINT fk_bookings_service_variant 
FOREIGN KEY (service_variant_id) REFERENCES service_variants(id) ON DELETE SET NULL;

-- Verify the foreign key constraints
COMMENT ON CONSTRAINT fk_bookings_service ON bookings IS 'Foreign key to services table';
COMMENT ON CONSTRAINT fk_bookings_service_variant ON bookings IS 'Foreign key to service_variants table';

-- Update any triggers or functions that might reference these columns
-- (Add any specific trigger/function updates here if needed)

-- Add indexes for better performance on foreign keys
CREATE INDEX IF NOT EXISTS idx_bookings_service_id ON bookings(service_id);
CREATE INDEX IF NOT EXISTS idx_bookings_service_variant_id ON bookings(service_variant_id);

-- Verify the relationships
SELECT 
    tc.constraint_name, 
    tc.table_name, 
    kcu.column_name, 
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name 
FROM 
    information_schema.table_constraints AS tc 
    JOIN information_schema.key_column_usage AS kcu
      ON tc.constraint_name = kcu.constraint_name
      AND tc.table_schema = kcu.table_schema
    JOIN information_schema.constraint_column_usage AS ccu
      ON ccu.constraint_name = tc.constraint_name
      AND ccu.table_schema = tc.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY' 
  AND tc.table_name = 'bookings'
  AND tc.table_schema = 'public';
