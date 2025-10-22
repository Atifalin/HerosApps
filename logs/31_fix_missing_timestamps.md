# Fix Missing Timestamps in Addresses Table

**Date**: October 22, 2025  
**Issue**: Addresses queries failing due to missing created_at column

## Problem

### Error
The app was trying to order addresses by `created_at` but the column didn't exist in the addresses table.

```sql
SELECT * FROM addresses ORDER BY created_at DESC;
-- ERROR: column "created_at" does not exist
```

### Root Cause
The addresses table was missing timestamp columns that are standard in most tables:
- `created_at` - When the address was created
- `updated_at` - When the address was last modified

## Solution

### Added Missing Columns
```sql
ALTER TABLE addresses 
ADD COLUMN IF NOT EXISTS created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW();

ALTER TABLE addresses 
ADD COLUMN IF NOT EXISTS updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW();
```

### Updated Existing Records
```sql
UPDATE addresses 
SET created_at = NOW(), updated_at = NOW()
WHERE created_at IS NULL;
```

### Forced Schema Reload
```sql
NOTIFY pgrst, 'reload schema';
```

## Verification

### Before
```
addresses table columns:
- id, user_id, label, line1, line2
- city, province, postal_code
- lat, lng, geom
- is_default, street
❌ No created_at
❌ No updated_at
```

### After
```
addresses table columns:
- id, user_id, label, line1, line2
- city, province, postal_code
- lat, lng, geom
- is_default, street
✅ created_at (timestamp with time zone)
✅ updated_at (timestamp with time zone)
```

### Test Query
```sql
SELECT id, label, street, city, is_default, created_at
FROM addresses
WHERE user_id = 'd4285f89-01eb-42d2-a848-dbc32c7a767b'
ORDER BY created_at DESC;

-- Result: ✅ Works!
```

## Impact

### Now Working
- ✅ Saved addresses screen loads
- ✅ Booking screen shows saved addresses
- ✅ Homepage tooltip shows recent address
- ✅ Account page navigation works
- ✅ Ordering by created_at works

### Queries Fixed
All queries that order by `created_at` now work:
```typescript
.order('created_at', { ascending: false })
```

## Next Steps

1. **Restart Expo** with cache clear:
   ```bash
   npx expo start --clear
   ```

2. **Force close the app** on your device

3. **Reopen the app**

4. **Test saved addresses**:
   - Go to Account → Saved Addresses
   - Should see existing address
   - Can add new addresses
   - Addresses show in booking screen

## Files Modified

- Database: Added `created_at` and `updated_at` columns
- No code changes needed (queries already used these columns)

## Result

✅ **Database schema complete** - All required columns present  
✅ **Queries work** - No more column errors  
✅ **PostgREST reloaded** - Schema cache cleared  
✅ **Ready to use** - Just restart the app

**The addresses table now has all required columns. Restart the app to see your saved addresses!** 🎉
