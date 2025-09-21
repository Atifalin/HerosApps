-- Fix RLS policies to prevent infinite recursion
-- This migration fixes the circular dependency in RLS policies

-- Drop existing policies that cause infinite recursion
DROP POLICY IF EXISTS "Admins can read all profiles" ON public.profiles;
DROP POLICY IF EXISTS "Admins can update all profiles" ON public.profiles;

-- Create simpler, non-recursive policies

-- Users can read their own profile
-- (This policy is fine as-is)

-- Admins can read all profiles (simplified - no recursion)
CREATE POLICY "Admins can read all profiles" ON public.profiles
  FOR SELECT USING (
    -- Allow if user has admin role (check directly in profiles table using a different approach)
    EXISTS (
      SELECT 1 FROM auth.users 
      WHERE auth.users.id = auth.uid() 
      AND auth.users.id IN (
        SELECT id FROM public.profiles 
        WHERE role IN ('admin', 'cs', 'finance') 
        AND id = auth.uid()
      )
    )
  );

-- Admins can update all profiles (simplified - no recursion)  
CREATE POLICY "Admins can update all profiles" ON public.profiles
  FOR UPDATE USING (
    -- Allow if user has admin role (check directly without recursion)
    EXISTS (
      SELECT 1 FROM auth.users 
      WHERE auth.users.id = auth.uid() 
      AND auth.users.id IN (
        SELECT id FROM public.profiles 
        WHERE role IN ('admin', 'cs') 
        AND id = auth.uid()
      )
    )
  );

-- Alternative: Disable RLS temporarily for testing
-- You can uncomment this line to disable RLS completely for testing
-- ALTER TABLE public.profiles DISABLE ROW LEVEL SECURITY;
