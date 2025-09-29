-- Insert services
INSERT INTO services (id, category, title, unit, base_price_cents, city, active)
VALUES
  ('a7e4e848-5864-47e4-8ce7-b2ef3735144d', 'Cleaning', 'Maid Services', 'fixed', 6000, 'Kelowna', true),
  ('ee14d670-dc09-462a-8cf9-e976f87b27ef', 'Food', 'Cooks & Chefs', 'hourly', 8000, 'Kelowna', true),
  ('98475f64-5061-46a0-adb7-c71327720cca', 'Events', 'Event Planning', 'fixed', 15000, 'Kelowna', true),
  ('b0a24f12-c493-4c18-8263-7d3bfb0c1b1f', 'Home', 'Handyman', 'hourly', 7500, 'Kelowna', true),
  ('d5f5c7e3-2b88-4b9f-8a47-e91f4c6e2f0d', 'Auto', 'Car Detailing', 'fixed', 12000, 'Kelowna', true),
  ('f8a2b6c1-d7e3-4f9a-b0c5-e1d2c3b4a5f6', 'Beauty', 'Personal Care', 'hourly', 9000, 'Kelowna', true),
  ('a1b2c3d4-e5f6-4a5b-8c7d-9e0f1a2b3c4d', 'Pest', 'Pest Control', 'fixed', 11000, 'Kelowna', true);

-- Insert service variants
INSERT INTO service_variants (id, service_id, name, slug, description, price, duration)
VALUES
  ('435ffb09-41c4-475b-95ab-371c992030a3', 'a7e4e848-5864-47e4-8ce7-b2ef3735144d', 'Deep Cleaning', 'deep-cleaning', 'Thorough cleaning of all areas including hard-to-reach spots', 149.99, 180),
  ('d80fd95a-3142-4715-b1a2-bfae9768ac2e', 'a7e4e848-5864-47e4-8ce7-b2ef3735144d', 'Regular Cleaning', 'regular-cleaning', 'Standard cleaning of visible areas and surfaces', 89.99, 120),
  ('ef97262a-2b18-4d0d-baea-c692fd847a8f', 'a7e4e848-5864-47e4-8ce7-b2ef3735144d', 'Move In/Out Cleaning', 'move-in-out', 'Detailed cleaning for moving in or out of a property', 199.99, 240);

-- Insert heroes
INSERT INTO heros (id, contractor_id, name, rating, review_count, skills, status, verification_status)
VALUES
  ('550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440000', 'Lisa Thompson', 4.8, 94, ARRAY['Cleaning', 'Organization'], 'active', 'verified'),
  ('550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440000', 'Michael Johnson', 4.7, 78, ARRAY['Deep Cleaning', 'Sanitization'], 'active', 'verified'),
  ('550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440000', 'Sarah Williams', 4.9, 112, ARRAY['Cleaning', 'Organization', 'Pet Friendly'], 'active', 'verified');

-- Add service name and variant name columns to bookings if they don't exist
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'bookings' AND column_name = 'service_name') THEN
    ALTER TABLE bookings ADD COLUMN service_name VARCHAR(255);
  END IF;
  
  IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'bookings' AND column_name = 'variant_name') THEN
    ALTER TABLE bookings ADD COLUMN variant_name VARCHAR(255);
  END IF;
END
$$;
