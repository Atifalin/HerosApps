-- Add all missing columns needed for booking creation
ALTER TABLE bookings ADD COLUMN IF NOT EXISTS base_price DECIMAL(10,2);
ALTER TABLE bookings ADD COLUMN IF NOT EXISTS call_out_fee DECIMAL(10,2);
ALTER TABLE bookings ADD COLUMN IF NOT EXISTS add_on_total DECIMAL(10,2);
ALTER TABLE bookings ADD COLUMN IF NOT EXISTS subtotal DECIMAL(10,2);
ALTER TABLE bookings ADD COLUMN IF NOT EXISTS tax_amount DECIMAL(10,2);
ALTER TABLE bookings ADD COLUMN IF NOT EXISTS total_amount DECIMAL(10,2);
ALTER TABLE bookings ADD COLUMN IF NOT EXISTS service_variant_id UUID;
ALTER TABLE bookings ADD COLUMN IF NOT EXISTS address_street TEXT;
ALTER TABLE bookings ADD COLUMN IF NOT EXISTS address_city TEXT;
ALTER TABLE bookings ADD COLUMN IF NOT EXISTS address_postal_code TEXT;
ALTER TABLE bookings ADD COLUMN IF NOT EXISTS duration INTEGER;

-- Add foreign key constraint if it doesn't exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint 
    WHERE conname = 'fk_bookings_service_variant' 
    AND conrelid = 'bookings'::regclass
  ) THEN
    ALTER TABLE bookings 
    ADD CONSTRAINT fk_bookings_service_variant 
    FOREIGN KEY (service_variant_id) 
    REFERENCES service_variants(id) 
    ON DELETE SET NULL;
  END IF;
END
$$;
