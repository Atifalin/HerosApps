# Services Table Fix - Image Mapping Issue

**Date**: October 22, 2025  
**Issue**: All services showing the same image (cleaning.png) on homepage

## Root Cause Analysis

### 1. **Table Source**
- Homepage fetches from `services` table in Supabase
- Query: `SELECT * FROM services WHERE active = true ORDER BY title`

### 2. **Missing Columns**
The `services` table was missing columns that the app code expected:
- `slug` - for image mapping
- `icon` - for UI icons
- `color` - for service category colors
- `description` - for service descriptions
- `call_out_fee` - for pricing display
- `min_duration` - for booking duration
- `max_duration` - for booking duration

### 3. **Image Mapping Problem**
- Code was calling `getServiceImage(service.category)` 
- But `category` values were like "Cleaning", "Food", "Events"
- Image map expected slugs like "maid-services", "cooks-chefs", "event-planning"
- **Result**: All services fell back to default `cleaning.png`

## Solution Applied

### Migration: `20251022_add_service_columns.sql`

1. **Added missing columns** to `services` table:
   ```sql
   ALTER TABLE services
   ADD COLUMN slug VARCHAR(255),
   ADD COLUMN icon VARCHAR(100),
   ADD COLUMN color VARCHAR(7),
   ADD COLUMN description TEXT,
   ADD COLUMN call_out_fee DECIMAL(10,2) DEFAULT 0,
   ADD COLUMN min_duration INTEGER DEFAULT 120,
   ADD COLUMN max_duration INTEGER DEFAULT 480;
   ```

2. **Populated slug values** based on category:
   - Cleaning → `maid-services`
   - Food → `cooks-chefs`
   - Events → `event-planning`
   - Home → `handymen`
   - Auto → `auto-services`

3. **Populated icon values** (Ionicons names):
   - maid-services → `home-outline`
   - cooks-chefs → `restaurant-outline`
   - event-planning → `calendar-outline`
   - handymen → `hammer-outline`
   - auto-services → `car-outline`

4. **Populated color values** (hex codes):
   - maid-services → `#4A5D23` (green)
   - cooks-chefs → `#D97706` (orange)
   - event-planning → `#7C3AED` (purple)
   - handymen → `#DC2626` (red)
   - auto-services → `#1F2937` (dark gray)

### Code Changes: `HomeScreen.tsx`

1. **Updated query** to explicitly select new columns:
   ```typescript
   .select(`
     id,
     title,
     slug,
     icon,
     color,
     description,
     call_out_fee,
     min_duration,
     max_duration,
     service_variants (...)
   `)
   ```

2. **Fixed image mapping**:
   ```typescript
   // Before: image: getServiceImage(service.category)
   // After:  image: getServiceImage(service.slug)
   ```

3. **Cleaned up data transformation**:
   - Removed fallback to `service.name` (doesn't exist)
   - Added null safety for `service_variants`

## Database State After Fix

```
 category |     title      |      slug      |        icon        |  color  
----------+----------------+----------------+--------------------+---------
 Cleaning | Maid Services  | maid-services  | home-outline       | #4A5D23
 Food     | Cooks & Chefs  | cooks-chefs    | restaurant-outline | #D97706
 Events   | Event Planning | event-planning | calendar-outline   | #7C3AED
 Home     | Handyman       | handymen       | hammer-outline     | #DC2626
 Auto     | Car Detailing  | auto-services  | car-outline        | #1F2937
```

## Result

✅ Each service now displays its correct image  
✅ Services have proper icons and colors  
✅ Code matches database schema  
✅ Image mapping works correctly via slug column

## Files Modified

1. `/supabase/migrations/20251022_add_service_columns.sql` - New migration
2. `/Homeheros_app/src/screens/main/HomeScreen.tsx` - Updated query and mapping

## Notes

- Removed problematic `update_updated_at_column()` trigger that was referencing non-existent column
- Added unique index on `slug` column for data integrity
- All existing services were automatically populated with correct values
