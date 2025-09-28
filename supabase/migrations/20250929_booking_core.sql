-- HomeHeros Booking System Core Schema
-- This migration creates the core tables for the booking management system

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Services table (master catalog)
CREATE TABLE IF NOT EXISTS services (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    icon VARCHAR(100),
    color VARCHAR(7), -- hex color
    image_url TEXT,
    call_out_fee DECIMAL(10,2) DEFAULT 0,
    min_duration INTEGER DEFAULT 60, -- minutes
    max_duration INTEGER DEFAULT 480, -- minutes
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Service subcategories/variants
CREATE TABLE IF NOT EXISTS service_variants (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    service_id UUID REFERENCES services(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL,
    description TEXT,
    base_price DECIMAL(10,2),
    price_type VARCHAR(20) DEFAULT 'fixed', -- fixed, hourly, tiered
    default_duration INTEGER DEFAULT 120, -- minutes
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(service_id, slug)
);

-- Add-ons catalog
CREATE TABLE IF NOT EXISTS add_ons (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    service_id UUID REFERENCES services(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(100),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Heroes (service providers)
CREATE TABLE IF NOT EXISTS heroes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(20),
    avatar_url TEXT,
    rating DECIMAL(3,2) DEFAULT 0,
    review_count INTEGER DEFAULT 0,
    is_active BOOLEAN DEFAULT true,
    is_verified BOOLEAN DEFAULT false,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Hero skills/services mapping
CREATE TABLE IF NOT EXISTS hero_services (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    hero_id UUID REFERENCES heroes(id) ON DELETE CASCADE,
    service_id UUID REFERENCES services(id) ON DELETE CASCADE,
    price_multiplier DECIMAL(3,2) DEFAULT 1.0,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(hero_id, service_id)
);

-- Hero availability
CREATE TABLE IF NOT EXISTS hero_availability (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    hero_id UUID REFERENCES heroes(id) ON DELETE CASCADE,
    day_of_week INTEGER NOT NULL, -- 0=Sunday, 1=Monday, etc.
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Hero service areas (cities they cover)
CREATE TABLE IF NOT EXISTS hero_service_areas (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    hero_id UUID REFERENCES heroes(id) ON DELETE CASCADE,
    city VARCHAR(100) NOT NULL,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(hero_id, city)
);

-- Bookings table
CREATE TABLE IF NOT EXISTS bookings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    customer_id UUID REFERENCES profiles(id) ON DELETE CASCADE,
    service_id UUID REFERENCES services(id),
    service_variant_id UUID REFERENCES service_variants(id),
    hero_id UUID REFERENCES heroes(id),
    
    -- Booking details
    status VARCHAR(20) DEFAULT 'draft', -- draft, requested, confirmed, en_route, in_progress, completed, cancelled, no_show
    scheduled_date DATE NOT NULL,
    scheduled_time TIME NOT NULL,
    duration INTEGER NOT NULL, -- minutes
    
    -- Address
    address_street VARCHAR(255) NOT NULL,
    address_city VARCHAR(100) NOT NULL,
    address_postal_code VARCHAR(20),
    address_coordinates POINT,
    
    -- Pricing
    base_price DECIMAL(10,2) NOT NULL,
    call_out_fee DECIMAL(10,2) DEFAULT 0,
    add_on_total DECIMAL(10,2) DEFAULT 0,
    subtotal DECIMAL(10,2) NOT NULL,
    tax_amount DECIMAL(10,2) DEFAULT 0,
    promo_discount DECIMAL(10,2) DEFAULT 0,
    total_amount DECIMAL(10,2) NOT NULL,
    
    -- Additional info
    special_instructions TEXT,
    promo_code VARCHAR(50),
    
    -- Timestamps
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    confirmed_at TIMESTAMP WITH TIME ZONE,
    started_at TIMESTAMP WITH TIME ZONE,
    completed_at TIMESTAMP WITH TIME ZONE,
    cancelled_at TIMESTAMP WITH TIME ZONE
);

-- Booking add-ons (many-to-many)
CREATE TABLE IF NOT EXISTS booking_add_ons (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID REFERENCES bookings(id) ON DELETE CASCADE,
    add_on_id UUID REFERENCES add_ons(id),
    quantity INTEGER DEFAULT 1,
    unit_price DECIMAL(10,2) NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Booking status history
CREATE TABLE IF NOT EXISTS booking_status_history (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID REFERENCES bookings(id) ON DELETE CASCADE,
    status VARCHAR(20) NOT NULL,
    notes TEXT,
    created_by UUID REFERENCES profiles(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Payment records (mock system)
CREATE TABLE IF NOT EXISTS payments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID REFERENCES bookings(id) ON DELETE CASCADE,
    payment_method VARCHAR(50) DEFAULT 'mock_card', -- mock_card, mock_apple_pay, etc.
    amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'pending', -- pending, authorized, captured, failed, refunded
    payment_intent_id VARCHAR(255), -- for future Stripe integration
    mock_card_last4 VARCHAR(4), -- for mock system
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Promo codes
CREATE TABLE IF NOT EXISTS promo_codes (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    code VARCHAR(50) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    discount_type VARCHAR(20) NOT NULL, -- percentage, fixed_amount
    discount_value DECIMAL(10,2) NOT NULL,
    min_order_amount DECIMAL(10,2) DEFAULT 0,
    max_discount_amount DECIMAL(10,2),
    usage_limit INTEGER,
    usage_count INTEGER DEFAULT 0,
    cities TEXT[], -- array of cities where valid
    valid_from TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    valid_until TIMESTAMP WITH TIME ZONE,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for performance
CREATE INDEX IF NOT EXISTS idx_bookings_customer_id ON bookings(customer_id);
CREATE INDEX IF NOT EXISTS idx_bookings_hero_id ON bookings(hero_id);
CREATE INDEX IF NOT EXISTS idx_bookings_status ON bookings(status);
CREATE INDEX IF NOT EXISTS idx_bookings_scheduled_date ON bookings(scheduled_date);
CREATE INDEX IF NOT EXISTS idx_bookings_city ON bookings(address_city);
CREATE INDEX IF NOT EXISTS idx_hero_services_hero_id ON hero_services(hero_id);
CREATE INDEX IF NOT EXISTS idx_hero_availability_hero_id ON hero_availability(hero_id);
CREATE INDEX IF NOT EXISTS idx_booking_status_history_booking_id ON booking_status_history(booking_id);

-- Functions for booking management
CREATE OR REPLACE FUNCTION update_booking_status(
    booking_id UUID,
    new_status VARCHAR(20),
    notes TEXT DEFAULT NULL,
    user_id UUID DEFAULT NULL
)
RETURNS BOOLEAN AS $$
BEGIN
    -- Update booking status
    UPDATE bookings 
    SET 
        status = new_status,
        updated_at = NOW(),
        confirmed_at = CASE WHEN new_status = 'confirmed' THEN NOW() ELSE confirmed_at END,
        started_at = CASE WHEN new_status = 'in_progress' THEN NOW() ELSE started_at END,
        completed_at = CASE WHEN new_status = 'completed' THEN NOW() ELSE completed_at END,
        cancelled_at = CASE WHEN new_status IN ('cancelled', 'no_show') THEN NOW() ELSE cancelled_at END
    WHERE id = booking_id;
    
    -- Insert status history record
    INSERT INTO booking_status_history (booking_id, status, notes, created_by)
    VALUES (booking_id, new_status, notes, user_id);
    
    RETURN TRUE;
END;
$$ LANGUAGE plpgsql;

-- Function to get available heroes for a booking
CREATE OR REPLACE FUNCTION get_available_heroes(
    service_id UUID,
    city VARCHAR(100),
    booking_date DATE,
    booking_time TIME,
    duration_minutes INTEGER
)
RETURNS TABLE (
    hero_id UUID,
    hero_name VARCHAR(255),
    rating DECIMAL(3,2),
    review_count INTEGER,
    price_multiplier DECIMAL(3,2)
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        h.id,
        h.name,
        h.rating,
        h.review_count,
        hs.price_multiplier
    FROM heroes h
    JOIN hero_services hs ON h.id = hs.hero_id
    JOIN hero_service_areas hsa ON h.id = hsa.hero_id
    WHERE 
        h.is_active = true 
        AND h.is_verified = true
        AND hs.service_id = get_available_heroes.service_id
        AND hs.is_active = true
        AND hsa.city = get_available_heroes.city
        AND hsa.is_active = true
        -- Add availability check logic here
    ORDER BY h.rating DESC, h.review_count DESC;
END;
$$ LANGUAGE plpgsql;

-- Trigger to update booking updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_bookings_updated_at 
    BEFORE UPDATE ON bookings 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_heroes_updated_at 
    BEFORE UPDATE ON heroes 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_services_updated_at 
    BEFORE UPDATE ON services 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();
