-- Create a test user for development and testing

-- Insert a test user into auth.users
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

-- Insert corresponding profile
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

-- Verify the user was created
SELECT 'User created:' as message, email FROM auth.users WHERE email = 'test@homeheros.com';
SELECT 'Profile created:' as message, name, email FROM profiles WHERE email = 'test@homeheros.com';
