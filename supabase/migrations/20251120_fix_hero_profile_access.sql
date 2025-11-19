-- Fix hero profile access - heroes couldn't read their own profile
-- Date: 2025-11-20
-- Issue: GO app stuck at "fetching profile" because heroes couldn't read from heros table

-- Add policy for heroes to read their own profile
CREATE POLICY "Heroes can read own profile" ON heros
  FOR SELECT
  USING (auth.uid() = user_id);

-- Add policy for heroes to update their own profile
CREATE POLICY "Heroes can update own profile" ON heros
  FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);
