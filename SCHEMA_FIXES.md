# Schema Column Name Fixes

## Issue
The cloud database schema has different column names than what the local database had.

## Fixed

### ✅ Services Table - Active Column
- **Local:** `is_active`
- **Cloud:** `active`
- **Fixed in:** `HomeScreen.tsx` line 65

### ✅ Services Table - No Slug Column
- **Issue:** Code was trying to use `service.slug` which doesn't exist
- **Solution:** Use `service.id` (UUID) directly instead
- **Fixed in:** 
  - `HomeScreen.tsx` line 76, 81, 86
  - `BookingScreen.tsx` lines 57, 171

### ✅ Services Table - Name Column
- **Local:** `name`
- **Cloud:** `title`
- **Fixed in:** `HomeScreen.tsx` line 77

### ✅ Service Variants - No Slug Column
- **Issue:** Code was trying to use `variant.slug` which doesn't exist
- **Solution:** Use `variant.id` (UUID) directly instead
- **Fixed in:**
  - `HomeScreen.tsx` line 86
  - `BookingScreen.tsx` line 172

### ✅ Heroes Table Name
- **Issue:** Code was querying `heroes` table, but data is in `heros` table
- **Solution:** Changed query to use `heros` table
- **Fixed in:** `BookingConfirmScreen.tsx` line 48

### ✅ Heroes Table Columns
- **Issue:** Column names differ between `heroes` and `heros` tables
- **Mapping:**
  - `is_active` → `status` (check for 'active')
  - `is_verified` → `verification_status` (check for 'verified')
  - `rating` → `rating_avg`
  - `review_count` → `rating_count`
- **Fixed in:** `BookingConfirmScreen.tsx` lines 50-52, 63-64, 67

## Column Name Reference

### Services Table (`public.services`)
```sql
- id (uuid)
- category (text)
- title (text)          -- NOT "name"
- unit (service_unit)
- base_price_cents (integer)  -- NOT "base_price"
- city (text)
- active (boolean)      -- NOT "is_active" ✅ FIXED
```

### Heroes Table (`public.heroes`)
```sql
- id (uuid)
- user_id (uuid)
- name (varchar)
- email (varchar)
- phone (varchar)
- avatar_url (text)
- rating (numeric)
- review_count (integer)
- is_active (boolean)   -- ✅ CORRECT
- is_verified (boolean) -- ✅ CORRECT
- created_at (timestamp)
- updated_at (timestamp)
```

### Add-ons Table (`public.add_ons`)
```sql
- id (uuid)
- service_id (uuid)
- name (varchar)
- description (text)
- price (numeric)
- category (varchar)
- is_active (boolean)   -- ✅ CORRECT
- created_at (timestamp)
```

### Service Variants Table (`public.service_variants`)
```sql
- id (uuid)
- service_id (uuid)
- name (varchar)
- slug (varchar)
- description (text)
- base_price (numeric)
- price_type (varchar)
- default_duration (integer)  -- NOT "duration_min"
- is_active (boolean)
- created_at (timestamp)
- updated_at (timestamp)
```

## Status
✅ Fixed - App should now load services correctly
