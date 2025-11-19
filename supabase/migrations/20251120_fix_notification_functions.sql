-- Fix notification functions to use correct column names
-- Date: 2025-11-20
-- Issue: Notification trigger was failing with foreign key constraint error

-- Fix the create_notification function to use related_booking_id
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
    -- Use related_booking_id instead of booking_id (correct column name)
    INSERT INTO notifications (user_id, related_booking_id, title, message, type, data)
    VALUES (p_user_id, p_booking_id, p_title, p_message, p_type, p_data)
    RETURNING id INTO v_notification_id;
    
    RETURN v_notification_id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Fix mark_notification_read to use 'read' instead of 'is_read'
CREATE OR REPLACE FUNCTION mark_notification_read(p_notification_id UUID)
RETURNS BOOLEAN AS $$
BEGIN
    UPDATE notifications
    SET read = TRUE, read_at = NOW()
    WHERE id = p_notification_id
    AND user_id = auth.uid();
    
    RETURN FOUND;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
