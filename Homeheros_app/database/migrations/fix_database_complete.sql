-- Fix database schema to match the app's expectations
-- This script adds all necessary columns and functions to make the app work

-- Add missing columns to services table
DO $$ 
BEGIN
    -- Add created_at column if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'services' AND column_name = 'created_at') THEN
        ALTER TABLE services ADD COLUMN created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW();
    END IF;

    -- Add name column if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'services' AND column_name = 'name') THEN
        ALTER TABLE services ADD COLUMN name TEXT;
        -- Update name from title
        UPDATE services SET name = title;
    END IF;

    -- Add description column if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'services' AND column_name = 'description') THEN
        ALTER TABLE services ADD COLUMN description TEXT;
    END IF;

    -- Add icon column if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'services' AND column_name = 'icon') THEN
        ALTER TABLE services ADD COLUMN icon TEXT;
    END IF;

    -- Add color column if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'services' AND column_name = 'color') THEN
        ALTER TABLE services ADD COLUMN color TEXT;
    END IF;
END $$;

-- Add missing columns to service_variants table
DO $$ 
BEGIN
    -- Add base_price column if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'service_variants' AND column_name = 'base_price') THEN
        ALTER TABLE service_variants ADD COLUMN base_price DECIMAL(10,2);
        -- Copy from price column
        UPDATE service_variants SET base_price = price;
    END IF;

    -- Add default_duration column if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'service_variants' AND column_name = 'default_duration') THEN
        ALTER TABLE service_variants ADD COLUMN default_duration INTEGER;
        -- Copy from duration column
        UPDATE service_variants SET default_duration = duration;
    END IF;
END $$;

-- Add missing columns to bookings table
DO $$ 
BEGIN
    -- Add scheduled_date column if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'bookings' AND column_name = 'scheduled_date') THEN
        ALTER TABLE bookings ADD COLUMN scheduled_date DATE;
        -- Extract date from scheduled_at
        UPDATE bookings SET scheduled_date = scheduled_at::DATE;
    END IF;

    -- Add scheduled_time column if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'bookings' AND column_name = 'scheduled_time') THEN
        ALTER TABLE bookings ADD COLUMN scheduled_time TEXT;
        -- Extract time from scheduled_at
        UPDATE bookings SET scheduled_time = to_char(scheduled_at, 'HH24:MI');
    END IF;

    -- Add duration column if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'bookings' AND column_name = 'duration') THEN
        ALTER TABLE bookings ADD COLUMN duration INTEGER;
        -- Copy from duration_min
        UPDATE bookings SET duration = duration_min;
    END IF;

    -- Add address columns if they don't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'bookings' AND column_name = 'address_street') THEN
        ALTER TABLE bookings ADD COLUMN address_street TEXT;
        ALTER TABLE bookings ADD COLUMN address_city TEXT;
        ALTER TABLE bookings ADD COLUMN address_postal_code TEXT;
    END IF;

    -- Add pricing columns if they don't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'bookings' AND column_name = 'base_price') THEN
        ALTER TABLE bookings ADD COLUMN base_price DECIMAL(10,2) DEFAULT 0;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'bookings' AND column_name = 'call_out_fee') THEN
        ALTER TABLE bookings ADD COLUMN call_out_fee DECIMAL(10,2) DEFAULT 0;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'bookings' AND column_name = 'add_on_total') THEN
        ALTER TABLE bookings ADD COLUMN add_on_total DECIMAL(10,2) DEFAULT 0;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'bookings' AND column_name = 'subtotal') THEN
        ALTER TABLE bookings ADD COLUMN subtotal DECIMAL(10,2) DEFAULT 0;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'bookings' AND column_name = 'tax_amount') THEN
        ALTER TABLE bookings ADD COLUMN tax_amount DECIMAL(10,2) DEFAULT 0;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'bookings' AND column_name = 'special_instructions') THEN
        ALTER TABLE bookings ADD COLUMN special_instructions TEXT;
    END IF;

    -- Add denormalized name columns if they don't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'bookings' AND column_name = 'service_name') THEN
        ALTER TABLE bookings ADD COLUMN service_name VARCHAR(255);
    END IF;

    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'bookings' AND column_name = 'variant_name') THEN
        ALTER TABLE bookings ADD COLUMN variant_name VARCHAR(255);
    END IF;
END $$;

-- Add missing columns to heros table
DO $$ 
BEGIN
    -- Add rating_avg column if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'heros' AND column_name = 'rating_avg') THEN
        ALTER TABLE heros ADD COLUMN rating_avg NUMERIC(3,2) DEFAULT 0;
    END IF;

    -- Add rating_count column if it doesn't exist
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns 
                   WHERE table_name = 'heros' AND column_name = 'rating_count') THEN
        ALTER TABLE heros ADD COLUMN rating_count INTEGER DEFAULT 0;
    END IF;
END $$;

-- Create get_server_timestamp function if it doesn't exist
CREATE OR REPLACE FUNCTION get_server_timestamp()
RETURNS TIMESTAMP WITH TIME ZONE
LANGUAGE SQL
SECURITY DEFINER
AS $$
  SELECT NOW();
$$;

-- Create update_updated_at_column function if it doesn't exist
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create booking_event function if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_proc WHERE proname = 'create_booking_event') THEN
        CREATE FUNCTION create_booking_event()
        RETURNS TRIGGER AS $$
        BEGIN
            INSERT INTO booking_events (booking_id, type, meta_json)
            VALUES (NEW.id, 'status_change', json_build_object('old_status', OLD.status, 'new_status', NEW.status));
            RETURN NEW;
        END;
        $$ LANGUAGE plpgsql;
    END IF;
END $$;

-- Create booking_status_change trigger if it doesn't exist
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_trigger WHERE tgname = 'booking_status_change') THEN
        CREATE TRIGGER booking_status_change
        AFTER UPDATE ON bookings
        FOR EACH ROW
        WHEN (OLD.status IS NULL OR NEW.status <> OLD.status)
        EXECUTE FUNCTION create_booking_event();
    END IF;
END $$;

-- Update service names and icons
UPDATE services SET 
    name = 'Maid Services',
    description = 'Professional cleaning services for your home',
    icon = 'home-outline',
    color = '#4CAF50'
WHERE id = 'a7e4e848-5864-47e4-8ce7-b2ef3735144d';

UPDATE services SET 
    name = 'Cooks & Chefs',
    description = 'Professional cooking services for events and daily meals',
    icon = 'restaurant-outline',
    color = '#FF9800'
WHERE id = 'ee14d670-dc09-462a-8cf9-e976f87b27ef';

UPDATE services SET 
    name = 'Event Planning',
    description = 'Professional event planning and coordination services',
    icon = 'calendar-outline',
    color = '#2196F3'
WHERE id = '98475f64-5061-46a0-adb7-c71327720cca';

-- Update service variant details
UPDATE service_variants SET
    description = 'Thorough cleaning of all areas including hard-to-reach spots'
WHERE id = '435ffb09-41c4-475b-95ab-371c992030a3';

UPDATE service_variants SET
    description = 'Standard cleaning of visible areas and surfaces'
WHERE id = 'd80fd95a-3142-4715-b1a2-bfae9768ac2e';

UPDATE service_variants SET
    description = 'Detailed cleaning for moving in or out of a property'
WHERE id = 'ef97262a-2b18-4d0d-baea-c692fd847a8f';
