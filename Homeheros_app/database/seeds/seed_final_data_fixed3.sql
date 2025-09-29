-- Final comprehensive seeding script for HomeHeros database

-- Create address for test booking
INSERT INTO addresses (user_id, line1, line2, city, postal_code, province, lat, lng)
VALUES
  ('cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31', '123 Main Street', NULL, 'Kelowna', 'V1Y 2A3', 'BC', 49.8801, -119.4436);

-- Check if we can create a booking with the address
DO $$
DECLARE
  address_id UUID;
BEGIN
  -- Get the address ID
  SELECT id INTO address_id FROM addresses WHERE user_id = 'cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31' LIMIT 1;
  
  -- If we have an address, create a booking
  IF address_id IS NOT NULL THEN
    -- Insert using price_cents
    INSERT INTO bookings (
      customer_id, 
      contractor_id, 
      hero_id, 
      service_id, 
      service_variant_id,
      service_name,
      variant_name,
      status, 
      scheduled_at,
      scheduled_date, 
      scheduled_time, 
      duration_min, 
      address_id,
      price_cents,
      currency,
      special_instructions
    )
    VALUES
      (
        'cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31', 
        '550e8400-e29b-41d4-a716-446655440000', 
        '550e8400-e29b-41d4-a716-446655440001',
        'a7e4e848-5864-47e4-8ce7-b2ef3735144d',
        '435ffb09-41c4-475b-95ab-371c992030a3',
        'Maid Services',
        'Deep Cleaning',
        'requested',
        '2025-10-15 14:30:00',
        '2025-10-15',
        '14:30',
        180,
        address_id,
        18374,
        'CAD',
        'Please focus on kitchen and bathrooms'
      );
  END IF;
END
$$;
