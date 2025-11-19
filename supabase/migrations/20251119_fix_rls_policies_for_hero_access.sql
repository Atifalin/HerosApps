-- Fix RLS policies for hero and customer access to bookings
-- Date: 2025-11-19
-- Issue: Heroes and customers couldn't load their bookings due to overly restrictive RLS policies

-- ============================================================================
-- 1. FIX HERO ACCESS TO BOOKINGS
-- ============================================================================

-- Drop and recreate the hero read policy (simplified, no role check)
DROP POLICY IF EXISTS heros_read_assigned_bookings ON bookings;

CREATE POLICY heros_read_assigned_bookings ON bookings
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM heros
      WHERE heros.user_id = auth.uid()
      AND heros.id = bookings.hero_id
    )
  );

-- Add UPDATE policy for heroes to update their assigned bookings
DROP POLICY IF EXISTS heros_update_assigned_bookings ON bookings;

CREATE POLICY heros_update_assigned_bookings ON bookings
  FOR UPDATE
  USING (
    EXISTS (
      SELECT 1 FROM heros
      WHERE heros.user_id = auth.uid()
      AND heros.id = bookings.hero_id
    )
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM heros
      WHERE heros.user_id = auth.uid()
      AND heros.id = bookings.hero_id
    )
  );

-- ============================================================================
-- 2. FIX HERO ACCESS TO CUSTOMER PROFILES
-- ============================================================================

-- Enable RLS on profiles
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;

-- Drop and recreate policy for heroes to read customer profiles
DROP POLICY IF EXISTS "Heroes can read customer profiles for their bookings" ON profiles;

CREATE POLICY "Heroes can read customer profiles for their bookings" ON profiles
  FOR SELECT
  USING (
    id IN (
      SELECT bookings.customer_id
      FROM bookings
      WHERE bookings.hero_id IN (
        SELECT heros.id
        FROM heros
        WHERE heros.user_id = auth.uid()
      )
    )
  );

-- ============================================================================
-- VERIFICATION QUERIES (for testing)
-- ============================================================================

-- Test hero can read their assigned bookings:
-- SELECT * FROM bookings WHERE hero_id = '<hero_id>';

-- Test customer can read their bookings:
-- SELECT * FROM bookings WHERE customer_id = auth.uid();

-- Test hero can read customer profile for their booking:
-- SELECT p.* FROM profiles p 
-- JOIN bookings b ON b.customer_id = p.id 
-- WHERE b.hero_id IN (SELECT id FROM heros WHERE user_id = auth.uid());
