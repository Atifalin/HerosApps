-- Enable Realtime for bookings table
-- Date: 2025-11-20
-- Issue: Customer app wasn't receiving real-time updates when hero changed status

-- Add bookings table to the realtime publication
ALTER PUBLICATION supabase_realtime ADD TABLE bookings;

-- This enables real-time subscriptions for:
-- - Status changes (enroute, arrived, in_progress, completed)
-- - Hero assignment updates
-- - Any other booking field changes
