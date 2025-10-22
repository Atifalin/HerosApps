# Fix Booking Creation - Foreign Key Constraints

**Date**: October 22, 2025  
**Issue**: Booking creation failed due to foreign key constraint violation

## Problem

### Error Message
```
Booking creation error: {
  "code": "23503",
  "details": "Key is not present in table \"users\"",
  "message": "insert or update on table \"bookings\" violates foreign key constraint \"bookings_customer_id_fkey\""
}
```

### Root Cause
After migrating to cloud, the app uses `profiles` table for user data, but several tables still had foreign key constraints referencing the old `users` table:

1. **bookings** → `customer_id` referenced `users(id)`
2. **heros** → `user_id` referenced `users(id)`
3. **addresses** → `user_id` referenced `users(id)`
4. **reviews** → `rater_user_id` referenced `users(id)`
5. **cs_notes** → `author_user_id` referenced `users(id)`

## Solution

### Migration Created
Created two migration files to fix all foreign key constraints:

1. **20251022_fix_bookings_foreign_keys.sql** - Fixed bookings table
2. **20251022_fix_all_user_foreign_keys.sql** - Fixed all remaining tables

### Changes Made

#### 1. Bookings Table
```sql
-- Drop old constraint
ALTER TABLE bookings 
DROP CONSTRAINT bookings_customer_id_fkey;

-- Add new constraint referencing profiles
ALTER TABLE bookings 
ADD CONSTRAINT bookings_customer_id_fkey 
FOREIGN KEY (customer_id) 
REFERENCES profiles(id) 
ON DELETE CASCADE;
```

#### 2. Heros Table
```sql
ALTER TABLE heros 
DROP CONSTRAINT heros_user_id_fkey;

ALTER TABLE heros 
ADD CONSTRAINT heros_user_id_fkey 
FOREIGN KEY (user_id) 
REFERENCES profiles(id) 
ON DELETE CASCADE;
```

#### 3. Addresses Table
```sql
ALTER TABLE addresses 
DROP CONSTRAINT addresses_user_id_fkey;

ALTER TABLE addresses 
ADD CONSTRAINT addresses_user_id_fkey 
FOREIGN KEY (user_id) 
REFERENCES profiles(id) 
ON DELETE CASCADE;
```

#### 4. Reviews Table
```sql
ALTER TABLE reviews 
DROP CONSTRAINT reviews_rater_user_id_fkey;

ALTER TABLE reviews 
ADD CONSTRAINT reviews_rater_user_id_fkey 
FOREIGN KEY (rater_user_id) 
REFERENCES profiles(id) 
ON DELETE CASCADE;
```

#### 5. CS Notes Table
```sql
ALTER TABLE cs_notes 
DROP CONSTRAINT cs_notes_author_user_id_fkey;

ALTER TABLE cs_notes 
ADD CONSTRAINT cs_notes_author_user_id_fkey 
FOREIGN KEY (author_user_id) 
REFERENCES profiles(id) 
ON DELETE CASCADE;
```

### RLS Policy Update
Also updated the Row Level Security policy for bookings:

```sql
DROP POLICY "heros_read_assigned_bookings" ON bookings;

CREATE POLICY "heros_read_assigned_bookings" 
ON bookings 
FOR SELECT 
USING (
  EXISTS (
    SELECT 1
    FROM profiles  -- Changed from users
    WHERE profiles.id = auth.uid() 
    AND profiles.role = 'hero'
    AND EXISTS (
      SELECT 1
      FROM heros
      WHERE heros.user_id = auth.uid() 
      AND heros.id = bookings.hero_id
    )
  )
);
```

## Verification

### Before Fix
```sql
-- Foreign keys pointed to users table
bookings.customer_id → users.id ❌
heros.user_id → users.id ❌
addresses.user_id → users.id ❌
reviews.rater_user_id → users.id ❌
cs_notes.author_user_id → users.id ❌
```

### After Fix
```sql
-- All foreign keys now point to profiles table
bookings.customer_id → profiles.id ✅
heros.user_id → profiles.id ✅
addresses.user_id → profiles.id ✅
reviews.rater_user_id → profiles.id ✅
cs_notes.author_user_id → profiles.id ✅
```

## Impact

### Tables Fixed
- ✅ **bookings** - Can now create bookings
- ✅ **heros** - Hero profiles work correctly
- ✅ **addresses** - User addresses link properly
- ✅ **reviews** - Reviews reference correct users
- ✅ **cs_notes** - Customer service notes work

### Cascade Behavior
All constraints now have `ON DELETE CASCADE`, meaning:
- If a profile is deleted, all related records are automatically deleted
- Maintains referential integrity
- Prevents orphaned records

## Testing

### Booking Creation Flow
1. ✅ User selects service
2. ✅ User chooses date/time
3. ✅ User enters address
4. ✅ User selects add-ons
5. ✅ User confirms booking
6. ✅ **Booking is created successfully** (previously failed)

### Database Integrity
```sql
-- Verify all constraints
SELECT table_name, column_name, foreign_table_name
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu USING (constraint_name)
JOIN information_schema.constraint_column_usage ccu USING (constraint_name)
WHERE constraint_type = 'FOREIGN KEY'
AND foreign_table_name = 'profiles';
```

## Files Created

1. ✅ `/supabase/migrations/20251022_fix_bookings_foreign_keys.sql`
2. ✅ `/supabase/migrations/20251022_fix_all_user_foreign_keys.sql`

## Result

✅ **Booking creation now works!**  
✅ **All foreign keys reference profiles table**  
✅ **RLS policies updated**  
✅ **Database integrity maintained**  
✅ **Cascade deletes configured**

**Users can now successfully create bookings in the app!** 🎉
