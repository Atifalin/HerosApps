-- Fix RLS policy for booking_events to allow trigger inserts
-- The booking_status_change trigger needs to insert into booking_events
-- but RLS was blocking it

-- Drop existing policies if any
DROP POLICY IF EXISTS booking_events_insert_on_trigger ON booking_events;
DROP POLICY IF EXISTS booking_events_read_own ON booking_events;

-- Allow inserts from triggers (system context)
-- This allows the booking_status_change trigger to insert events
CREATE POLICY booking_events_insert_on_trigger ON booking_events
  FOR INSERT
  WITH CHECK (true);

-- Allow users to read events for their own bookings
CREATE POLICY booking_events_read_own ON booking_events
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM bookings
      WHERE bookings.id = booking_events.booking_id
      AND (
        bookings.customer_id = auth.uid()
        OR EXISTS (
          SELECT 1 FROM heros
          WHERE heros.id = bookings.hero_id
          AND heros.user_id = auth.uid()
        )
      )
    )
  );

-- Allow admins to read all booking events
CREATE POLICY booking_events_admin_read ON booking_events
  FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM users
      WHERE users.id = auth.uid()
      AND users.role = 'admin'
    )
  );
