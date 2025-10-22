# Supabase Cloud Migration Guide

## Overview
This guide walks you through migrating your local Supabase database to Supabase Cloud.

**Project Details:**
- **Cloud URL**: https://vttzuaerdwagipyocpha.supabase.co
- **Project Ref**: vttzuaerdwagipyocpha
- **Backup File**: `database_backups/homeheros_db_backup_20251002_183513.sql`

---

## ✅ Pre-Migration Checklist

- [x] Supabase Cloud project created
- [x] Project credentials obtained
- [x] Local backup created (20251002_183513.sql)
- [x] App environment updated (.env)

---

## 🚀 Migration Steps

### Step 1: Link Local Project to Cloud

```bash
cd "/Users/atifali/Code/Paid Apps/Homeheros/supabase"
supabase link --project-ref vttzuaerdwagipyocpha
```

**You'll be prompted for:**
- Database password (from Supabase Dashboard → Settings → Database)

---

### Step 2: Push Database Schema (Migrations)

```bash
supabase db push
```

This will:
- ✅ Create all tables (bookings, profiles, services, etc.)
- ✅ Set up RLS policies
- ✅ Create functions and triggers
- ✅ Apply all 8 migration files

**Expected output:**
```
Applying migration 20250101000000_initial.sql...
Applying migration 20250122000001_auth_and_profiles.sql...
...
Finished supabase db push.
```

---

### Step 3: Restore Data from Backup

**Option A: Using psql (Recommended)**

```bash
# Get your database password from Supabase Dashboard
# Settings → Database → Connection String

psql "postgresql://postgres:[YOUR_PASSWORD]@db.vttzuaerdwagipyocpha.supabase.co:5432/postgres" \
  < "/Users/atifali/Code/Paid Apps/Homeheros/database_backups/homeheros_db_backup_20251002_183513.sql"
```

**Option B: Using the migration script**

```bash
chmod +x migrate_to_cloud.sh
./migrate_to_cloud.sh
```

---

### Step 4: Create Auth Users

Your backup has profiles but not auth.users. Create test users:

**Method 1: Using the sync script**

```bash
chmod +x sync_auth_users.sh
./sync_auth_users.sh
```

**Method 2: Manual creation in Supabase Dashboard**

1. Go to: https://vttzuaerdwagipyocpha.supabase.co/project/vttzuaerdwagipyocpha/auth/users
2. Click "Add user" → "Create new user"
3. Create users:
   - Email: `test@test.com`, Password: `Test123!`
   - Email: `hero1@example.com`, Password: `Test123!`

**Method 3: Using SQL (Advanced)**

```sql
-- Run in SQL Editor on Supabase Dashboard

-- Create test@test.com
INSERT INTO auth.users (
  id,
  instance_id,
  email,
  encrypted_password,
  email_confirmed_at,
  created_at,
  updated_at,
  raw_app_meta_data,
  raw_user_meta_data,
  is_super_admin,
  role
) VALUES (
  'cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31',
  '00000000-0000-0000-0000-000000000000',
  'test@test.com',
  crypt('Test123!', gen_salt('bf')),
  now(),
  now(),
  now(),
  '{"provider":"email","providers":["email"]}',
  '{}',
  false,
  'authenticated'
);

-- Create hero1@example.com
INSERT INTO auth.users (
  id,
  instance_id,
  email,
  encrypted_password,
  email_confirmed_at,
  created_at,
  updated_at,
  raw_app_meta_data,
  raw_user_meta_data,
  is_super_admin,
  role
) VALUES (
  '550e8400-e29b-41d4-a716-446655441001',
  '00000000-0000-0000-0000-000000000000',
  'hero1@example.com',
  crypt('Test123!', gen_salt('bf')),
  now(),
  now(),
  now(),
  '{"provider":"email","providers":["email"]}',
  '{}',
  false,
  'authenticated'
);
```

---

### Step 5: Verify Migration

**Check Tables:**
```bash
supabase db diff --linked
```

**Check Data in Dashboard:**
1. Go to: https://vttzuaerdwagipyocpha.supabase.co/project/vttzuaerdwagipyocpha/editor
2. Verify tables have data:
   - `profiles` (2 rows)
   - `bookings` (3 rows)
   - `contractors` (1 row)
   - `heros` (1 row)
   - `services` (multiple rows)

**Test Authentication:**
```bash
# In your app, try logging in with:
# Email: test@test.com
# Password: Test123!
```

---

## 📊 Data Summary

Your migration will include:

| Table | Rows | Description |
|-------|------|-------------|
| profiles | 2 | test@test.com, hero1@example.com |
| addresses | 1 | Kelowna address |
| bookings | 3 | Maid service bookings |
| booking_status_history | 3 | Status tracking |
| contractors | 1 | CleanPro Services |
| heros | 1 | Lisa Thompson |
| payments | 2 | Mock payment records |
| promo_codes | 1 | WELCOME25 |
| services | Multiple | Service catalog |
| service_variants | Multiple | Service variants |

---

## ⚠️ Important Notes

### Auth Users vs Profiles
- Your backup has `profiles` table data
- But NOT `auth.users` (Supabase's authentication table)
- You MUST create auth users separately (Step 4)
- The profile IDs should match auth.users IDs

### RLS Policies
- Your migrations include RLS policies
- Test that users can only access their own data
- Admin/CS roles should have broader access

### Environment Variables
- ✅ `.env` updated with cloud credentials
- ✅ `supabase.ts` has cloud URL as fallback
- Restart your app after migration

---

## 🧪 Testing Checklist

After migration, test:

- [ ] User can sign in (test@test.com / Test123!)
- [ ] User can view their profile
- [ ] User can view their bookings
- [ ] User can create new booking
- [ ] Services load correctly
- [ ] Promo codes work
- [ ] RLS policies prevent unauthorized access

---

## 🔄 Rollback Plan

If something goes wrong:

1. **Keep local Supabase running** as backup
2. **Revert .env to local:**
   ```bash
   EXPO_PUBLIC_SUPABASE_URL=http://127.0.0.1:54321
   EXPO_PUBLIC_SUPABASE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0
   ```
3. **Restart app**

---

## 📞 Support

If you encounter issues:

1. Check Supabase logs: Dashboard → Logs
2. Check migration status: `supabase db diff --linked`
3. Verify connection: `supabase status`

---

## 🎉 Success!

Once complete, your app will be using Supabase Cloud with:
- ✅ All data migrated
- ✅ Auth working
- ✅ RLS policies active
- ✅ Ready for production
