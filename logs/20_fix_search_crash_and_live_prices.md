# Fix Search Crash and Add Live Price Updates

**Date**: October 22, 2025  
**Issues Fixed**:
1. Search screen crashing with "Cannot read property 'map' of undefined"
2. Prices not updating live when services are viewed

## Issue 1: Search Screen Crash

### Problem
When navigating from search to service detail, the app crashed with:
```
Cannot read property 'map' of undefined
at ServiceDetailScreen.tsx:85
{service.subcategories.map((subcategory) => ...
```

### Root Cause
The search screen was creating a service object without the `subcategories` array, causing the ServiceDetailScreen to crash when trying to map over it.

### Solution
**File**: `SearchScreen.tsx` (Line 214-224)

Added required properties to the service object:
```typescript
navigation.navigate('ServiceDetail', { 
  service: {
    id: serviceId,
    name: result.title,
    description: result.description,
    icon: result.icon,
    color: result.color,
    subcategories: [], // Initialize empty array to prevent crash
    image: null,
  }
});
```

## Issue 2: Live Price Updates

### Problem
Prices were not updating in real-time when:
- Service categories were clicked
- User navigated to booking screen
- Database prices were changed

### Solution
**File**: `ServiceDetailScreen.tsx`

#### Changes Made:

1. **Added State Management**:
```typescript
const [service, setService] = useState(initialService);
const [loading, setLoading] = useState(false);
```

2. **Created Fetch Function**:
```typescript
const fetchServiceData = async () => {
  // Fetches fresh data from Supabase
  // Transforms base_price from cents to dollars
  // Updates service state with latest prices
};
```

3. **Added Auto-Refresh on Focus**:
```typescript
useFocusEffect(
  React.useCallback(() => {
    fetchServiceData();
  }, [initialService.id])
);
```

4. **Added Loading Indicator**:
```typescript
{loading && (
  <View style={styles.loadingContainer}>
    <ActivityIndicator size="small" />
    <Typography>Updating prices...</Typography>
  </View>
)}
```

5. **Added Null Safety**:
```typescript
{service.subcategories && service.subcategories.length > 0 ? (
  service.subcategories.map((subcategory) => ...)
) : (
  !loading && (
    <Typography>No services available at the moment.</Typography>
  )
)}
```

## Features Added

### Live Price Updates
✅ Prices refresh automatically when:
- Service detail screen is opened
- User returns to service detail from another screen
- Screen comes into focus

### Better UX
✅ Loading indicator shows "Updating prices..." while fetching
✅ Graceful handling of empty subcategories
✅ No crashes when data is missing

### Price Formatting
✅ Consistent conversion from cents to dollars
✅ Format: `From $XX` for all prices
✅ Proper rounding with `.toFixed(0)`

## Technical Details

### Data Flow
1. User clicks service category
2. `ServiceDetailScreen` mounts
3. `useFocusEffect` triggers `fetchServiceData()`
4. Fresh data fetched from Supabase
5. Prices converted from cents to dollars
6. UI updates with latest prices

### Database Query
```typescript
.select(`
  id, title, slug, icon, color, description,
  call_out_fee, min_duration, max_duration,
  service_variants (
    id, name, slug, description,
    base_price, default_duration
  )
`)
```

### Price Transformation
```typescript
price: variant.base_price 
  ? `From $${(variant.base_price / 100).toFixed(0)}` 
  : 'Custom pricing'
```

## Files Modified

1. ✅ `/src/screens/main/SearchScreen.tsx` - Fixed crash
2. ✅ `/src/screens/services/ServiceDetailScreen.tsx` - Added live updates

## Testing Checklist

- [x] Search no longer crashes
- [x] Prices update when service is clicked
- [x] Prices update when returning from booking screen
- [x] Loading indicator shows during fetch
- [x] Empty subcategories handled gracefully
- [x] Price formatting is correct (cents → dollars)

## Result

✅ **Search screen is stable** - No more crashes  
✅ **Prices are always current** - Fetched fresh from database  
✅ **Better user experience** - Loading states and error handling  
✅ **Consistent pricing** - All prices properly formatted

**Users now see real-time pricing every time they view a service!** 🎉
