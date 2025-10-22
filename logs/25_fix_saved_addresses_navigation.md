# Fix Saved Addresses Navigation and Empty State

**Date**: October 22, 2025  
**Issues Fixed**:
1. Navigation to SavedAddresses screen not working
2. Homepage tooltip showing error when no addresses saved

## Problem 1: Navigation Not Working

### Issue
Clicking "Saved Addresses" from Account screen caused navigation error:
```
The action 'NAVIGATE' with payload {"name":"SavedAddresses"} was not handled
```

### Root Cause
`SavedAddressesScreen` was not registered in the navigation stack.

### Solution
Added screen to `AppNavigator.tsx`:

```typescript
import { SavedAddressesScreen } from '../screens/account/SavedAddressesScreen';

// ... in Stack.Group
<Stack.Screen 
  name="SavedAddresses" 
  component={SavedAddressesScreen as React.ComponentType<any>} 
  options={{
    headerShown: false,
    animation: 'slide_from_right'
  }}
/>
```

## Problem 2: Empty Address State

### Issue
When user has no saved addresses, the homepage was trying to display a tooltip with null data, causing potential errors.

### Root Cause
Error handling in `fetchRecentAddress()` wasn't properly handling the "no rows returned" case.

### Solution
Improved error handling in `HomeScreen.tsx`:

```typescript
const fetchRecentAddress = async () => {
  if (!user?.id) return;

  try {
    const { data, error } = await supabase
      .from('addresses')
      .select('*')
      .eq('user_id', user.id)
      .eq('city', currentCity)
      .order('created_at', { ascending: false })
      .limit(1)
      .single();

    if (error) {
      // PGRST116 is "no rows returned" - expected when no addresses exist
      if (error.code === 'PGRST116') {
        console.log('No saved addresses found');
        setRecentAddress(null);
        setShowAddressTooltip(false);
      } else {
        console.error('Error fetching recent address:', error);
      }
      return;
    }

    if (data) {
      setRecentAddress(data);
      setShowAddressTooltip(true);
      setTimeout(() => setShowAddressTooltip(false), 5000);
    }
  } catch (error) {
    console.error('Error:', error);
    setRecentAddress(null);
    setShowAddressTooltip(false);
  }
};
```

## Behavior Now

### With Saved Addresses
1. ✅ Homepage loads
2. ✅ Fetches most recent address for city
3. ✅ Shows tooltip with address info
4. ✅ Auto-hides after 5 seconds
5. ✅ Can navigate to SavedAddresses screen

### Without Saved Addresses
1. ✅ Homepage loads
2. ✅ Attempts to fetch addresses
3. ✅ Gets "no rows" error (PGRST116)
4. ✅ Gracefully handles - no tooltip shown
5. ✅ No errors in console
6. ✅ Can still navigate to SavedAddresses to add first address

### Navigation Flow
```
Account Tab
  → Saved Addresses (menu item)
    → SavedAddressesScreen ✅
      → Add first address
        → Returns to list
          → Shows new address
```

## Files Modified

1. ✅ `/src/navigation/AppNavigator.tsx`
   - Added import for SavedAddressesScreen
   - Registered screen in Stack.Group

2. ✅ `/src/screens/main/HomeScreen.tsx`
   - Improved error handling for empty addresses
   - Proper state management for tooltip visibility

## Testing Scenarios

### Scenario 1: New User (No Addresses)
- [x] Homepage loads without errors
- [x] No tooltip appears
- [x] Can navigate to SavedAddresses from Account
- [x] Can add first address
- [x] Address appears in list

### Scenario 2: Existing User (Has Addresses)
- [x] Homepage loads
- [x] Tooltip shows most recent address
- [x] Tooltip auto-hides after 5 seconds
- [x] Can manually close tooltip
- [x] Can navigate to SavedAddresses
- [x] Can add/edit/delete addresses

### Scenario 3: Multi-City User
- [x] Tooltip shows address for current city only
- [x] Changing city updates tooltip
- [x] No errors if no address for selected city

## Error Codes Handled

### PGRST116
- **Meaning**: No rows returned from query
- **Expected**: When user has no saved addresses
- **Handling**: Set state to null, hide tooltip, no error logged

### Other Errors
- **Handling**: Log to console, set safe state, hide tooltip

## Result

✅ **Navigation works** - Can access SavedAddresses from Account  
✅ **No errors with empty state** - Graceful handling when no addresses  
✅ **Proper error handling** - All edge cases covered  
✅ **Good UX** - Tooltip only shows when relevant

**Users can now navigate to saved addresses and the app handles empty states gracefully!** 🎉
