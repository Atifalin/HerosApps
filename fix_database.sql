-- Quick fix for missing columns in existing database
-- Run this if the booking_core migration hasn't been applied

-- Add missing columns to bookings table if they don't exist
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'bookings' AND column_name = 'add_on_total') THEN
        ALTER TABLE bookings ADD COLUMN add_on_total DECIMAL(10,2) DEFAULT 0;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'bookings' AND column_name = 'call_out_fee') THEN
        ALTER TABLE bookings ADD COLUMN call_out_fee DECIMAL(10,2) DEFAULT 0;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'bookings' AND column_name = 'base_price') THEN
        ALTER TABLE bookings ADD COLUMN base_price DECIMAL(10,2) NOT NULL DEFAULT 0;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'bookings' AND column_name = 'subtotal') THEN
        ALTER TABLE bookings ADD COLUMN subtotal DECIMAL(10,2) NOT NULL DEFAULT 0;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'bookings' AND column_name = 'tax_amount') THEN
        ALTER TABLE bookings ADD COLUMN tax_amount DECIMAL(10,2) DEFAULT 0;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'bookings' AND column_name = 'total_amount') THEN
        ALTER TABLE bookings ADD COLUMN total_amount DECIMAL(10,2) NOT NULL DEFAULT 0;
    END IF;
END $$;

-- Add missing columns to payments table if they don't exist
DO $$ 
BEGIN
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'payments' AND column_name = 'amount') THEN
        ALTER TABLE payments ADD COLUMN amount DECIMAL(10,2) NOT NULL DEFAULT 0;
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'payments' AND column_name = 'payment_method') THEN
        ALTER TABLE payments ADD COLUMN payment_method VARCHAR(50) DEFAULT 'mock_card';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'payments' AND column_name = 'status') THEN
        ALTER TABLE payments ADD COLUMN status VARCHAR(20) DEFAULT 'pending';
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'payments' AND column_name = 'payment_intent_id') THEN
        ALTER TABLE payments ADD COLUMN payment_intent_id VARCHAR(255);
    END IF;
    
    IF NOT EXISTS (SELECT 1 FROM information_schema.columns WHERE table_name = 'payments' AND column_name = 'mock_card_last4') THEN
        ALTER TABLE payments ADD COLUMN mock_card_last4 VARCHAR(4);
    END IF;
END $$;

-- Create the get_server_timestamp function if it doesn't exist
CREATE OR REPLACE FUNCTION get_server_timestamp()
RETURNS TIMESTAMP WITH TIME ZONE
LANGUAGE SQL
SECURITY DEFINER
AS $$
  SELECT NOW();
$$;
