-- Comprehensive seeding script for HomeHeros database
-- Handles existing records and adds all necessary test data

-- Services with ON CONFLICT handling
INSERT INTO services (id, category, title, unit, base_price_cents, city, active, slug, name, description, icon, color, is_active)
VALUES
  ('a7e4e848-5864-47e4-8ce7-b2ef3735144d', 'Cleaning', 'Maid Services', 'fixed', 6000, 'Kelowna', true, 'maid-services', 'Maid Services', 'Professional cleaning services for your home', 'home-outline', '#4CAF50', true),
  ('ee14d670-dc09-462a-8cf9-e976f87b27ef', 'Food', 'Cooks & Chefs', 'hourly', 8000, 'Kelowna', true, 'cooks-chefs', 'Cooks & Chefs', 'Professional cooking services', 'restaurant-outline', '#FF9800', true),
  ('98475f64-5061-46a0-adb7-c71327720cca', 'Events', 'Event Planning', 'fixed', 15000, 'Kelowna', true, 'event-planning', 'Event Planning', 'Professional event planning services', 'calendar-outline', '#2196F3', true),
  ('b0a24f12-c493-4c18-8263-7d3bfb0c1b1f', 'Home', 'Handyman', 'hourly', 7500, 'Kelowna', true, 'handyman', 'Handyman', 'Professional handyman services', 'hammer-outline', '#795548', true),
  ('d5f5c7e3-2b88-4b9f-8a47-e91f4c6e2f0d', 'Auto', 'Car Detailing', 'fixed', 12000, 'Kelowna', true, 'car-detailing', 'Car Detailing', 'Professional car detailing services', 'car-outline', '#607D8B', true),
  ('f8a2b6c1-d7e3-4f9a-b0c5-e1d2c3b4a5f6', 'Beauty', 'Personal Care', 'hourly', 9000, 'Kelowna', true, 'personal-care', 'Personal Care', 'Professional personal care services', 'person-outline', '#9C27B0', true),
  ('a1b2c3d4-e5f6-4a5b-8c7d-9e0f1a2b3c4d', 'Pest', 'Pest Control', 'fixed', 11000, 'Kelowna', true, 'pest-control', 'Pest Control', 'Professional pest control services', 'bug-outline', '#F44336', true)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  icon = EXCLUDED.icon,
  color = EXCLUDED.color,
  slug = EXCLUDED.slug,
  is_active = EXCLUDED.is_active;

-- Service variants with ON CONFLICT handling
INSERT INTO service_variants (id, service_id, name, slug, description, price, duration, base_price, default_duration)
VALUES
  ('435ffb09-41c4-475b-95ab-371c992030a3', 'a7e4e848-5864-47e4-8ce7-b2ef3735144d', 'Deep Cleaning', 'deep-cleaning', 'Thorough cleaning of all areas including hard-to-reach spots', 149.99, 180, 149.99, 180),
  ('d80fd95a-3142-4715-b1a2-bfae9768ac2e', 'a7e4e848-5864-47e4-8ce7-b2ef3735144d', 'Regular Cleaning', 'regular-cleaning', 'Standard cleaning of visible areas and surfaces', 89.99, 120, 89.99, 120),
  ('ef97262a-2b18-4d0d-baea-c692fd847a8f', 'a7e4e848-5864-47e4-8ce7-b2ef3735144d', 'Move In/Out Cleaning', 'move-in-out', 'Detailed cleaning for moving in or out of a property', 199.99, 240, 199.99, 240),
  ('1a2b3c4d-5e6f-7a8b-9c0d-1e2f3a4b5c6d', 'ee14d670-dc09-462a-8cf9-e976f87b27ef', 'Personal Chef', 'personal-chef', 'Professional chef cooking in your home', 120.00, 180, 120.00, 180),
  ('2b3c4d5e-6f7a-8b9c-0d1e-2f3a4b5c6d7e', 'ee14d670-dc09-462a-8cf9-e976f87b27ef', 'Event Catering', 'event-catering', 'Catering for special events', 200.00, 240, 200.00, 240),
  ('3c4d5e6f-7a8b-9c0d-1e2f-3a4b5c6d7e8f', '98475f64-5061-46a0-adb7-c71327720cca', 'Birthday Party', 'birthday-party', 'Birthday party planning and coordination', 250.00, 300, 250.00, 300),
  ('4d5e6f7a-8b9c-0d1e-2f3a-4b5c6d7e8f9a', '98475f64-5061-46a0-adb7-c71327720cca', 'Wedding Planning', 'wedding-planning', 'Complete wedding planning services', 500.00, 480, 500.00, 480)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  price = EXCLUDED.price,
  duration = EXCLUDED.duration,
  base_price = EXCLUDED.base_price,
  default_duration = EXCLUDED.default_duration;

-- Create test contractor if it doesn't exist
INSERT INTO contractors (id, name, status, city_coverage, categories)
VALUES
  ('550e8400-e29b-41d4-a716-446655440000', 'CleanPro Services', 'active', ARRAY['Kelowna', 'Vernon'], ARRAY['Cleaning', 'Home'])
ON CONFLICT (id) DO NOTHING;

-- Insert hero with existing user
INSERT INTO heros (id, contractor_id, user_id, name, alias, skills, categories, bio, badges, status, verification_status)
VALUES
  ('550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440000', 'cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31', 'Lisa Thompson', 'Lisa T.', ARRAY['Cleaning', 'Organization'], ARRAY['Cleaning'], 'Professional cleaner with 5+ years of experience', ARRAY['Insured', 'Background Check'], 'active', 'verified')
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  alias = EXCLUDED.alias,
  skills = EXCLUDED.skills,
  categories = EXCLUDED.categories,
  bio = EXCLUDED.bio,
  badges = EXCLUDED.badges,
  status = EXCLUDED.status,
  verification_status = EXCLUDED.verification_status;

-- Check if total_amount column exists and create sample booking
DO $$
BEGIN
  -- Check if the column exists
  IF EXISTS (SELECT 1 FROM information_schema.columns 
             WHERE table_name = 'bookings' AND column_name = 'price_cents') THEN
    
    -- Insert using price_cents
    INSERT INTO bookings (
      id, 
      customer_id, 
      contractor_id, 
      hero_id, 
      service_id, 
      service_variant_id,
      service_name,
      variant_name,
      status, 
      scheduled_date, 
      scheduled_time, 
      duration, 
      address_street, 
      address_city, 
      address_postal_code,
      price_cents,
      currency,
      special_instructions
    )
    VALUES
      (
        'b1c2d3e4-f5a6-b7c8-d9e0-f1a2b3c4d5e6', 
        'cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31', 
        '550e8400-e29b-41d4-a716-446655440000', 
        '550e8400-e29b-41d4-a716-446655440001',
        'a7e4e848-5864-47e4-8ce7-b2ef3735144d',
        '435ffb09-41c4-475b-95ab-371c992030a3',
        'Maid Services',
        'Deep Cleaning',
        'requested',
        '2025-10-15',
        '14:30',
        180,
        '123 Main Street',
        'Kelowna',
        'V1Y 2A3',
        18374,
        'CAD',
        'Please focus on kitchen and bathrooms'
      )
    ON CONFLICT (id) DO UPDATE SET
      status = EXCLUDED.status,
      service_name = EXCLUDED.service_name,
      variant_name = EXCLUDED.variant_name;
  END IF;
END
$$;
