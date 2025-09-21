-- Simple RLS policies without recursion
-- This migration replaces complex policies with simple ones

-- Drop all existing policies
DROP POLICY IF EXISTS "Users can read own profile" ON public.profiles;
DROP POLICY IF EXISTS "Users can update own profile" ON public.profiles;
DROP POLICY IF EXISTS "Admins can read all profiles" ON public.profiles;
DROP POLICY IF EXISTS "Admins can update all profiles" ON public.profiles;

-- Create simple policies

-- 1. Users can read their own profile
CREATE POLICY "Users can read own profile" ON public.profiles
  FOR SELECT USING (auth.uid() = id);

-- 2. Users can update their own profile
CREATE POLICY "Users can update own profile" ON public.profiles
  FOR UPDATE USING (auth.uid() = id);

-- 3. Allow INSERT for new profiles (needed for the trigger)
CREATE POLICY "Allow profile creation" ON public.profiles
  FOR INSERT WITH CHECK (auth.uid() = id);

-- For now, let's keep admin policies simple or disable them
-- We can add them back later with proper implementation

-- Optional: If you want to test without any admin restrictions, 
-- you can temporarily disable RLS:
-- ALTER TABLE public.profiles DISABLE ROW LEVEL SECURITY;
