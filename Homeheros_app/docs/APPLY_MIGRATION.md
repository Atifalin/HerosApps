# 🚨 CRITICAL: Apply SQL Migration to Fix Authentication

## The Problem
Authentication is failing because the `profiles` table doesn't exist in your Supabase database yet.

## The Solution
You MUST apply the SQL migration to create the necessary database tables.

## Steps to Apply Migration

### 1. Go to Supabase Dashboard
Visit: https://supabase.com/dashboard/project/vttzuaerdwagipyocpha

### 2. Open SQL Editor
- Click **SQL Editor** in the left sidebar
- Click **New Query**

### 3. Copy the Migration SQL
Copy the ENTIRE contents of this file:
```
supabase/migrations/20250122000001_auth_and_profiles.sql
```

### 4. Paste and Run
- Paste the SQL into the query editor
- Click **Run** button

## What This Migration Does
- Creates `user_role` enum with: customer, hero, admin, cs, finance, contractor_manager
- Creates `profiles` table that extends Supabase Auth
- Sets up Row Level Security (RLS) policies
- Creates automatic profile creation trigger
- Adds proper indexes for performance

## After Running Migration
1. The authentication should work immediately
2. New users will automatically get a profile with role 'customer'
3. You can test signup/login in the app

## Verification
After running the migration, check:
1. **Table Editor** → You should see a `profiles` table
2. **Authentication** → Try signing up a new user
3. **Table Editor** → Check if a profile was created automatically

## If You Still Get Errors
1. Make sure your Supabase project is active (not paused)
2. Check if there are any billing issues
3. Verify the API key in your Supabase dashboard under Settings → API

---

**This is the most important step to get authentication working!**
