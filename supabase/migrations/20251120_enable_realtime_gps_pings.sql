-- Enable Realtime for gps_pings table
-- Date: 2025-11-20
-- Issue: Customer app needs real-time GPS updates to show hero location on map

-- Add gps_pings table to the realtime publication
ALTER PUBLICATION supabase_realtime ADD TABLE gps_pings;

-- This enables real-time subscriptions for:
-- - New GPS pings when hero is en route
-- - Live location updates on customer map
-- - ETA calculations
