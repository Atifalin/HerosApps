-- Create essential tables for booking system to work

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create bookings table with all required columns
CREATE TABLE IF NOT EXISTS bookings (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    customer_id UUID, -- Will reference profiles when that table exists
    service_id VARCHAR(255),
    service_variant_id VARCHAR(255),
    hero_id UUID,
    
    -- Booking details
    status VARCHAR(20) DEFAULT 'draft',
    scheduled_date DATE NOT NULL,
    scheduled_time TIME NOT NULL,
    duration INTEGER NOT NULL,
    
    -- Address
    address_street VARCHAR(255) NOT NULL,
    address_city VARCHAR(100) NOT NULL,
    address_postal_code VARCHAR(20),
    
    -- Pricing
    base_price DECIMAL(10,2) NOT NULL DEFAULT 0,
    call_out_fee DECIMAL(10,2) DEFAULT 0,
    add_on_total DECIMAL(10,2) DEFAULT 0,
    subtotal DECIMAL(10,2) NOT NULL DEFAULT 0,
    tax_amount DECIMAL(10,2) DEFAULT 0,
    promo_discount DECIMAL(10,2) DEFAULT 0,
    total_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    
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

-- Create payments table
CREATE TABLE IF NOT EXISTS payments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID REFERENCES bookings(id) ON DELETE CASCADE,
    payment_method VARCHAR(50) DEFAULT 'mock_card',
    amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    status VARCHAR(20) DEFAULT 'pending',
    payment_intent_id VARCHAR(255),
    mock_card_last4 VARCHAR(4),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create booking status history table
CREATE TABLE IF NOT EXISTS booking_status_history (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID REFERENCES bookings(id) ON DELETE CASCADE,
    status VARCHAR(20) NOT NULL,
    notes TEXT,
    created_by UUID, -- Will reference profiles when available
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Create the get_server_timestamp function
CREATE OR REPLACE FUNCTION get_server_timestamp()
RETURNS TIMESTAMP WITH TIME ZONE
LANGUAGE SQL
SECURITY DEFINER
AS $$
  SELECT NOW();
$$;

-- Create update_booking_status function
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

-- Create indexes for performance
CREATE INDEX IF NOT EXISTS idx_bookings_status ON bookings(status);
CREATE INDEX IF NOT EXISTS idx_bookings_scheduled_date ON bookings(scheduled_date);
CREATE INDEX IF NOT EXISTS idx_bookings_city ON bookings(address_city);
CREATE INDEX IF NOT EXISTS idx_booking_status_history_booking_id ON booking_status_history(booking_id);
