-- Migration: Job Completion Photos, GPS Tracking, and Notifications System
-- Date: 2025-11-19
-- Purpose: Support hero job management with photos, GPS tracking, and notifications

-- ============================================================================
-- 1. BOOKING PHOTOS TABLE
-- ============================================================================

-- Table for storing job completion and other booking-related photos
CREATE TABLE IF NOT EXISTS booking_photos (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    booking_id UUID NOT NULL REFERENCES bookings(id) ON DELETE CASCADE,
    uploaded_by UUID NOT NULL REFERENCES users(id),
    photo_url TEXT NOT NULL,
    photo_type VARCHAR(50) NOT NULL, -- 'completion', 'arrival', 'in_progress', 'issue'
    caption TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_booking_photos_booking_id ON booking_photos(booking_id);
CREATE INDEX IF NOT EXISTS idx_booking_photos_uploaded_by ON booking_photos(uploaded_by);
CREATE INDEX IF NOT EXISTS idx_booking_photos_created_at ON booking_photos(created_at);

-- Enable RLS
ALTER TABLE booking_photos ENABLE ROW LEVEL SECURITY;

-- RLS Policies for booking_photos
-- Heroes can insert photos for their assigned bookings
CREATE POLICY booking_photos_hero_insert ON booking_photos
    FOR INSERT
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM bookings b
            JOIN heros h ON h.id = b.hero_id
            WHERE b.id = booking_id
            AND h.user_id = auth.uid()
        )
    );

-- Customers can view photos for their bookings
CREATE POLICY booking_photos_customer_read ON booking_photos
    FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM bookings
            WHERE bookings.id = booking_id
            AND bookings.customer_id = auth.uid()
        )
    );

-- Heroes can view photos for their assigned bookings
CREATE POLICY booking_photos_hero_read ON booking_photos
    FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM bookings b
            JOIN heros h ON h.id = b.hero_id
            WHERE b.id = booking_id
            AND h.user_id = auth.uid()
        )
    );

-- Admins can view all photos
CREATE POLICY booking_photos_admin_read ON booking_photos
    FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM users
            WHERE users.id = auth.uid()
            AND users.role = 'admin'
        )
    );

-- ============================================================================
-- 2. GPS TRACKING ENHANCEMENTS
-- ============================================================================

-- Verify gps_pings table exists (it should from initial migration)
-- Add any missing indexes for performance

CREATE INDEX IF NOT EXISTS idx_gps_pings_created_at ON gps_pings(created_at);
CREATE INDEX IF NOT EXISTS idx_gps_pings_booking_hero ON gps_pings(booking_id, hero_id);

-- Enable RLS if not already enabled
ALTER TABLE gps_pings ENABLE ROW LEVEL SECURITY;

-- Drop existing policies to recreate them
DROP POLICY IF EXISTS gps_pings_hero_insert ON gps_pings;
DROP POLICY IF EXISTS gps_pings_customer_read ON gps_pings;
DROP POLICY IF EXISTS gps_pings_hero_read ON gps_pings;

-- Heroes can insert GPS pings for their assigned bookings
CREATE POLICY gps_pings_hero_insert ON gps_pings
    FOR INSERT
    WITH CHECK (
        EXISTS (
            SELECT 1 FROM bookings b
            JOIN heros h ON h.id = b.hero_id
            WHERE b.id = booking_id
            AND h.user_id = auth.uid()
            AND h.id = hero_id
        )
    );

-- Customers can read GPS pings for their bookings (when hero is en route)
CREATE POLICY gps_pings_customer_read ON gps_pings
    FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM bookings
            WHERE bookings.id = booking_id
            AND bookings.customer_id = auth.uid()
            AND bookings.status IN ('enroute', 'arrived')
        )
    );

-- Heroes can read their own GPS pings
CREATE POLICY gps_pings_hero_read ON gps_pings
    FOR SELECT
    USING (
        EXISTS (
            SELECT 1 FROM heros
            WHERE heros.id = hero_id
            AND heros.user_id = auth.uid()
        )
    );

-- ============================================================================
-- 3. NOTIFICATIONS SYSTEM
-- ============================================================================

-- Table for in-app notifications
CREATE TABLE IF NOT EXISTS notifications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    booking_id UUID REFERENCES bookings(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    type VARCHAR(50) NOT NULL, -- 'booking_update', 'hero_assigned', 'hero_enroute', 'hero_arrived', 'job_completed', 'payment', 'system'
    is_read BOOLEAN DEFAULT FALSE,
    data JSONB, -- Additional data for the notification
    created_at TIMESTAMPTZ DEFAULT NOW(),
    read_at TIMESTAMPTZ
);

CREATE INDEX IF NOT EXISTS idx_notifications_user_id ON notifications(user_id);
CREATE INDEX IF NOT EXISTS idx_notifications_booking_id ON notifications(booking_id);
CREATE INDEX IF NOT EXISTS idx_notifications_created_at ON notifications(created_at);
CREATE INDEX IF NOT EXISTS idx_notifications_is_read ON notifications(is_read);
CREATE INDEX IF NOT EXISTS idx_notifications_user_unread ON notifications(user_id, is_read) WHERE is_read = FALSE;

-- Enable RLS
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;

-- RLS Policies for notifications
-- Users can read their own notifications
CREATE POLICY notifications_read_own ON notifications
    FOR SELECT
    USING (auth.uid() = user_id);

-- Users can update their own notifications (mark as read)
CREATE POLICY notifications_update_own ON notifications
    FOR UPDATE
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- System can insert notifications (for triggers/functions)
CREATE POLICY notifications_system_insert ON notifications
    FOR INSERT
    WITH CHECK (true);

-- ============================================================================
-- 4. TIPS AND RATINGS ENHANCEMENT
-- ============================================================================

-- Check if reviews table has tip_cents field, add if missing
DO $$ 
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'reviews' AND column_name = 'tip_cents'
    ) THEN
        ALTER TABLE reviews ADD COLUMN tip_cents INTEGER DEFAULT 0;
    END IF;
    
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'reviews' AND column_name = 'customer_confirmed'
    ) THEN
        ALTER TABLE reviews ADD COLUMN customer_confirmed BOOLEAN DEFAULT FALSE;
    END IF;
    
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns 
        WHERE table_name = 'reviews' AND column_name = 'confirmed_at'
    ) THEN
        ALTER TABLE reviews ADD COLUMN confirmed_at TIMESTAMPTZ;
    END IF;
END $$;

-- ============================================================================
-- 5. HELPER FUNCTIONS
-- ============================================================================

-- Function to create notification
CREATE OR REPLACE FUNCTION create_notification(
    p_user_id UUID,
    p_booking_id UUID,
    p_title VARCHAR(255),
    p_message TEXT,
    p_type VARCHAR(50),
    p_data JSONB DEFAULT NULL
)
RETURNS UUID AS $$
DECLARE
    v_notification_id UUID;
BEGIN
    INSERT INTO notifications (user_id, booking_id, title, message, type, data)
    VALUES (p_user_id, p_booking_id, p_title, p_message, p_type, p_data)
    RETURNING id INTO v_notification_id;
    
    RETURN v_notification_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to mark notification as read
CREATE OR REPLACE FUNCTION mark_notification_read(p_notification_id UUID)
RETURNS BOOLEAN AS $$
BEGIN
    UPDATE notifications
    SET is_read = TRUE, read_at = NOW()
    WHERE id = p_notification_id
    AND user_id = auth.uid();
    
    RETURN FOUND;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Function to calculate ETA based on GPS pings
CREATE OR REPLACE FUNCTION calculate_eta(
    p_booking_id UUID
)
RETURNS INTERVAL AS $$
DECLARE
    v_latest_ping RECORD;
    v_booking_location RECORD;
    v_distance_km NUMERIC;
    v_avg_speed_kmh NUMERIC := 40; -- Default average speed
BEGIN
    -- Get latest GPS ping
    SELECT lat, lng, speed INTO v_latest_ping
    FROM gps_pings
    WHERE booking_id = p_booking_id
    ORDER BY created_at DESC
    LIMIT 1;
    
    IF NOT FOUND THEN
        RETURN NULL;
    END IF;
    
    -- Get booking address location (assuming addresses table has lat/lng)
    SELECT a.lat, a.lng INTO v_booking_location
    FROM bookings b
    JOIN addresses a ON a.id = b.address_id
    WHERE b.id = p_booking_id;
    
    IF NOT FOUND THEN
        RETURN NULL;
    END IF;
    
    -- Calculate distance using Haversine formula (simplified)
    v_distance_km := (
        6371 * acos(
            cos(radians(v_booking_location.lat)) * 
            cos(radians(v_latest_ping.lat)) * 
            cos(radians(v_latest_ping.lng) - radians(v_booking_location.lng)) + 
            sin(radians(v_booking_location.lat)) * 
            sin(radians(v_latest_ping.lat))
        )
    );
    
    -- Use actual speed if available and reasonable
    IF v_latest_ping.speed IS NOT NULL AND v_latest_ping.speed > 0 AND v_latest_ping.speed < 120 THEN
        v_avg_speed_kmh := v_latest_ping.speed;
    END IF;
    
    -- Calculate ETA in minutes
    RETURN (v_distance_km / v_avg_speed_kmh * 60)::INTEGER * INTERVAL '1 minute';
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- 6. TRIGGERS FOR AUTOMATIC NOTIFICATIONS
-- ============================================================================

-- Trigger to create notification when booking status changes
CREATE OR REPLACE FUNCTION notify_booking_status_change()
RETURNS TRIGGER AS $$
DECLARE
    v_customer_id UUID;
    v_hero_user_id UUID;
    v_title VARCHAR(255);
    v_message TEXT;
BEGIN
    -- Get customer and hero user IDs
    SELECT customer_id INTO v_customer_id FROM bookings WHERE id = NEW.id;
    SELECT h.user_id INTO v_hero_user_id 
    FROM bookings b 
    JOIN heros h ON h.id = b.hero_id 
    WHERE b.id = NEW.id;
    
    -- Determine notification based on status
    CASE NEW.status
        WHEN 'awaiting_hero_accept' THEN
            v_title := 'Hero Assigned';
            v_message := 'A service provider has been assigned to your booking.';
            PERFORM create_notification(v_customer_id, NEW.id, v_title, v_message, 'hero_assigned');
            
        WHEN 'enroute' THEN
            v_title := 'Hero On The Way';
            v_message := 'Your service provider is on the way to your location.';
            PERFORM create_notification(v_customer_id, NEW.id, v_title, v_message, 'hero_enroute');
            
        WHEN 'arrived' THEN
            v_title := 'Hero Arrived';
            v_message := 'Your service provider has arrived at your location.';
            PERFORM create_notification(v_customer_id, NEW.id, v_title, v_message, 'hero_arrived');
            
        WHEN 'in_progress' THEN
            v_title := 'Job Started';
            v_message := 'Your service has started.';
            PERFORM create_notification(v_customer_id, NEW.id, v_title, v_message, 'booking_update');
            
        WHEN 'completed' THEN
            v_title := 'Job Completed';
            v_message := 'Your service has been completed. Please rate your experience.';
            PERFORM create_notification(v_customer_id, NEW.id, v_title, v_message, 'job_completed');
            
        WHEN 'declined' THEN
            v_title := 'Booking Declined';
            v_message := 'The service provider declined your booking. We are finding another provider.';
            PERFORM create_notification(v_customer_id, NEW.id, v_title, v_message, 'booking_update');
            
        ELSE
            -- Other status changes
            NULL;
    END CASE;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Drop existing trigger if exists
DROP TRIGGER IF EXISTS trigger_notify_booking_status_change ON bookings;

-- Create trigger
CREATE TRIGGER trigger_notify_booking_status_change
    AFTER UPDATE OF status ON bookings
    FOR EACH ROW
    WHEN (OLD.status IS DISTINCT FROM NEW.status)
    EXECUTE FUNCTION notify_booking_status_change();

-- ============================================================================
-- MIGRATION COMPLETE
-- ============================================================================

-- Grant necessary permissions
GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL TABLES IN SCHEMA public TO anon, authenticated;
GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO anon, authenticated;
