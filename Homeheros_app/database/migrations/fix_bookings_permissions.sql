-- Make sure bookings table allows insertions
ALTER TABLE bookings DISABLE ROW LEVEL SECURITY;

-- Check if the bookings table has RLS disabled
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE schemaname = 'public' AND tablename = 'bookings';

-- Make sure payments table allows insertions
ALTER TABLE payments DISABLE ROW LEVEL SECURITY;

-- Check if the payments table has RLS disabled
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE schemaname = 'public' AND tablename = 'payments';
