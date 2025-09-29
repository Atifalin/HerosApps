# Supabase Setup Instructions

## Apply Database Migration

To fix the "Network request failed" error and set up user profiles, you need to apply the SQL migration to your Supabase database.

### Option 1: Using Supabase Dashboard (Recommended)

1. Go to your Supabase project dashboard: https://supabase.com/dashboard/project/vttzuaerdwagipyocpha
2. Navigate to **SQL Editor** in the left sidebar
3. Click **New Query**
4. Copy and paste the contents of `supabase/migrations/20250122000001_auth_and_profiles.sql`
5. Click **Run** to execute the migration

### Option 2: Using Supabase CLI (Advanced)

If you have Supabase CLI set up locally:

```bash
cd supabase
supabase db reset --force
```

## What This Migration Does

1. **Creates user roles enum**: `customer`, `hero`, `admin`, `cs`, `finance`, `contractor_manager`
2. **Creates profiles table**: Extends Supabase Auth with user profiles
3. **Sets up Row Level Security (RLS)**: Ensures users can only access their own data
4. **Creates automatic profile creation**: When a user signs up, a profile is automatically created
5. **Adds proper indexes**: For better query performance

## Testing Authentication

After applying the migration:

1. Run the Customer App: `npx expo start --ios`
2. Try signing up with a new email
3. Check the Supabase dashboard under **Authentication > Users** to see the new user
4. Check **Table Editor > profiles** to see the automatically created profile

## Troubleshooting

### "Network request failed" error
- Make sure you've applied the SQL migration
- Check that your Supabase project is active
- Verify the URL and anon key in `shared/supabase-config.ts`

### "relation 'profiles' does not exist"
- The migration hasn't been applied yet
- Follow the steps above to apply the migration

### Authentication works but no profile data
- Check the `handle_new_user()` trigger is working
- Manually insert a profile record if needed:
```sql
INSERT INTO public.profiles (id, email, role, name) 
VALUES ('your-user-id', 'your-email@example.com', 'customer', 'Your Name');
```

## Next Steps

Once authentication is working:
1. Test user signup and login
2. Verify profile creation
3. Test role-based access
4. Implement profile editing in the app
