-- Make sure all required columns are nullable to allow booking creation
ALTER TABLE bookings ALTER COLUMN address_id DROP NOT NULL;
ALTER TABLE bookings ALTER COLUMN contractor_id DROP NOT NULL;

-- Add a policy to allow customers to create bookings
CREATE POLICY customers_create_bookings ON bookings
  FOR INSERT
  TO authenticated
  WITH CHECK (auth.uid() = customer_id);

-- Make sure the Supabase RLS is enabled but allows our test operations
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;

-- Allow authenticated users to create payments
CREATE POLICY payments_insert ON payments
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

-- Allow authenticated users to update payments
CREATE POLICY payments_update ON payments
  FOR UPDATE
  TO authenticated
  USING (true);

-- Allow authenticated users to read payments
CREATE POLICY payments_select ON payments
  FOR SELECT
  TO authenticated
  USING (true);
