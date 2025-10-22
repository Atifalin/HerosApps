-- Fix all tables to reference profiles instead of users
-- Migration: 20251022_fix_all_user_foreign_keys.sql

-- 1. Fix heros table
ALTER TABLE heros 
DROP CONSTRAINT IF EXISTS heros_user_id_fkey;

ALTER TABLE heros 
ADD CONSTRAINT heros_user_id_fkey 
FOREIGN KEY (user_id) 
REFERENCES profiles(id) 
ON DELETE CASCADE;

-- 2. Fix addresses table
ALTER TABLE addresses 
DROP CONSTRAINT IF EXISTS addresses_user_id_fkey;

ALTER TABLE addresses 
ADD CONSTRAINT addresses_user_id_fkey 
FOREIGN KEY (user_id) 
REFERENCES profiles(id) 
ON DELETE CASCADE;

-- 3. Fix reviews table
ALTER TABLE reviews 
DROP CONSTRAINT IF EXISTS reviews_rater_user_id_fkey;

ALTER TABLE reviews 
ADD CONSTRAINT reviews_rater_user_id_fkey 
FOREIGN KEY (rater_user_id) 
REFERENCES profiles(id) 
ON DELETE CASCADE;

-- 4. Fix cs_notes table
ALTER TABLE cs_notes 
DROP CONSTRAINT IF EXISTS cs_notes_author_user_id_fkey;

ALTER TABLE cs_notes 
ADD CONSTRAINT cs_notes_author_user_id_fkey 
FOREIGN KEY (author_user_id) 
REFERENCES profiles(id) 
ON DELETE CASCADE;

-- Verify all changes
SELECT 
    tc.table_name, 
    kcu.column_name,
    ccu.table_name AS foreign_table_name,
    tc.constraint_name
FROM information_schema.table_constraints AS tc 
JOIN information_schema.key_column_usage AS kcu
  ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage AS ccu
  ON ccu.constraint_name = tc.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY' 
AND ccu.table_name IN ('users', 'profiles')
AND tc.table_name IN ('bookings', 'heros', 'addresses', 'reviews', 'cs_notes')
ORDER BY tc.table_name, kcu.column_name;
