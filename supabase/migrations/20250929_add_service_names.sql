-- Add service_name and variant_name columns to bookings table
-- This will allow us to store the names directly for display purposes

-- Add the columns
ALTER TABLE bookings ADD COLUMN service_name VARCHAR(255);
ALTER TABLE bookings ADD COLUMN variant_name VARCHAR(255);

-- Populate the columns with data from related tables
UPDATE bookings b
SET 
  service_name = s.name
FROM services s
WHERE b.service_id = s.id;

UPDATE bookings b
SET 
  variant_name = sv.name
FROM service_variants sv
WHERE b.service_variant_id = sv.id;

-- Add comment to explain the purpose of these columns
COMMENT ON COLUMN bookings.service_name IS 'Denormalized service name for display purposes';
COMMENT ON COLUMN bookings.variant_name IS 'Denormalized variant name for display purposes';
