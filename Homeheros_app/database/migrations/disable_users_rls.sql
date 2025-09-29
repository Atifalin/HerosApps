-- Completely disable RLS on users table temporarily
ALTER TABLE users DISABLE ROW LEVEL SECURITY;

-- Drop all policies on users table
DROP POLICY IF EXISTS admin_all ON users;
DROP POLICY IF EXISTS users_read_own ON users;
DROP POLICY IF EXISTS admin_temp_access ON users;

-- Check if the users table has RLS disabled
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE schemaname = 'public' AND tablename = 'users';
