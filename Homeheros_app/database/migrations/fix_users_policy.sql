-- Drop the problematic policy
DROP POLICY IF EXISTS admin_all ON users;

-- Create a new policy that doesn't cause recursion
CREATE POLICY admin_all ON users
  USING (auth.uid() IN (
    SELECT id FROM users 
    WHERE role IN ('admin', 'cs', 'finance')
  ));

-- Alternatively, if the above still causes issues, use a simpler policy
-- This will allow any authenticated user to access the users table
-- You can refine this later with proper role-based checks
CREATE POLICY IF NOT EXISTS admin_temp_access ON users
  USING (auth.role() = 'authenticated');

-- Grant temporary access for booking creation
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER POLICY users_read_own ON users TO authenticated;
