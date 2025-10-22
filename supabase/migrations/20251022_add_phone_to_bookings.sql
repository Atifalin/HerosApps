-- Add phone number to bookings table
-- Migration: 20251022_add_phone_to_bookings.sql

-- Add customer_phone column to bookings
ALTER TABLE bookings 
ADD COLUMN IF NOT EXISTS customer_phone VARCHAR(20);

-- Add index for phone lookups
CREATE INDEX IF NOT EXISTS idx_bookings_customer_phone ON bookings(customer_phone);

-- Add comment
COMMENT ON COLUMN bookings.customer_phone IS 'Customer contact phone number for this booking';

-- Verify the change
SELECT column_name, data_type, character_maximum_length
FROM information_schema.columns
WHERE table_name = 'bookings' AND column_name = 'customer_phone';
