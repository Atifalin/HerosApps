-- Fix database relationships and create test user

-- 1. Add missing foreign key constraint between bookings and heroes
ALTER TABLE bookings 
ADD CONSTRAINT fk_bookings_hero 
FOREIGN KEY (hero_id) REFERENCES heroes(id) ON DELETE SET NULL;

-- 2. Create a test user in auth.users (for development)
INSERT INTO auth.users (
    id,
    instance_id,
    aud,
    role,
    email,
    encrypted_password,
    email_confirmed_at,
    created_at,
    updated_at,
    confirmation_token,
    email_change,
    email_change_token_new,
    recovery_token
) VALUES (
    '550e8400-e29b-41d4-a716-446655440000',
    '00000000-0000-0000-0000-000000000000',
    'authenticated',
    'authenticated',
    'test@homeheros.com',
    '$2a$10$8K1p/a0dhrxSHxN1nByqhOxF7uL6P4T7z.rCVzoxeQPHh8kJjjgaa', -- password: 'password123'
    NOW(),
    NOW(),
    NOW(),
    '',
    '',
    '',
    ''
) ON CONFLICT (id) DO NOTHING;

-- 3. Create corresponding profile
INSERT INTO profiles (
    id,
    role,
    name,
    email,
    status
) VALUES (
    '550e8400-e29b-41d4-a716-446655440000',
    'customer',
    'Test User',
    'test@homeheros.com',
    'active'
) ON CONFLICT (id) DO NOTHING;

-- 4. Verify the relationships
SELECT 'Foreign key constraints:' as info;
SELECT 
    tc.constraint_name, 
    tc.table_name, 
    kcu.column_name, 
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name 
FROM 
    information_schema.table_constraints AS tc 
    JOIN information_schema.key_column_usage AS kcu
      ON tc.constraint_name = kcu.constraint_name
      AND tc.table_schema = kcu.table_schema
    JOIN information_schema.constraint_column_usage AS ccu
      ON ccu.constraint_name = tc.constraint_name
      AND ccu.table_schema = tc.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY' 
  AND tc.table_name = 'bookings'
  AND tc.table_schema = 'public';

-- 5. Show test user created
SELECT 'Test user created:' as info, email FROM auth.users WHERE email = 'test@homeheros.com';
SELECT 'Test profile created:' as info, name, email FROM profiles WHERE email = 'test@homeheros.com';
