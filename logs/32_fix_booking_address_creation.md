# Fix Booking Address Creation with Correct User IDs

**Date**: October 22, 2025  
**Issue**: Addresses created during booking were using hardcoded IDs

## Problems Found

### 1. Hardcoded User ID
```typescript
// ❌ BAD - Fallback to wrong user
customer_id: user?.id || 'd4285f89-01eb-42d2-a848-dbc32c7a767b'
```

### 2. Hardcoded Address ID
```typescript
// ❌ BAD - Always using same address
address_id: 'df1059b3-ae89-4a32-82f3-7a31c976653f'
```

### 3. Missing Phone Number
```typescript
// ❌ Missing customer_phone field
```

### 4. Incomplete Type Definition
```typescript
// ❌ Missing fields in BookingRequest
interface BookingRequest {
  address: {
    street: string;
    city: string;
    postalCode: string;
    // Missing: province, label
  };
  // Missing: addressId, phoneNumber
}
```

## Solutions Implemented

### 1. Dynamic Address Creation
```typescript
// ✅ GOOD - Create address with correct user_id
let addressId: string;

if (bookingRequest.addressId) {
  // Using existing saved address
  addressId = bookingRequest.addressId;
} else {
  // Create new address from booking request
  const { data: newAddress } = await supabase
    .from('addresses')
    .insert({
      user_id: user.id,  // ✅ Correct user ID
      street: bookingRequest.address.street,
      line1: bookingRequest.address.street,
      city: bookingRequest.address.city,
      province: bookingRequest.address.province || 'ON',
      postal_code: bookingRequest.address.postalCode,
      label: bookingRequest.address.label || null,
      is_default: false,
    })
    .select()
    .single();

  addressId = newAddress.id;
}
```

### 2. Proper User ID Validation
```typescript
// ✅ GOOD - Validate user before proceeding
if (!user?.id) {
  Alert.alert('Error', 'User not authenticated');
  return;
}

const bookingData = {
  customer_id: user.id,  // ✅ Always correct user
  address_id: addressId,  // ✅ Dynamic address
  customer_phone: bookingRequest.phoneNumber,  // ✅ Include phone
  // ... other fields
};
```

### 3. Updated Type Definition
```typescript
// ✅ GOOD - Complete type
export interface BookingRequest {
  serviceId: string;
  subcategoryId: string;
  serviceName?: string;
  variantName?: string;
  scheduledDate: string;
  scheduledTime: string;
  duration: number;
  address: {
    street: string;
    city: string;
    postalCode: string;
    province?: string;  // ✅ Added
    label?: string;     // ✅ Added
    coordinates?: {
      latitude: number;
      longitude: number;
    };
  };
  addressId?: string;   // ✅ Added - for saved addresses
  phoneNumber: string;  // ✅ Added - required field
  addOns: string[];
  specialInstructions?: string;
  heroId?: string;
}
```

### 4. Pass Address ID from BookingScreen
```typescript
// ✅ GOOD - Pass saved address ID
const bookingRequest = {
  // ... other fields
  address: {
    street: address.street,
    city: address.city,
    postalCode: address.postalCode,
    province: address.province,  // ✅ Include province
    label: address.label,         // ✅ Include label
  },
  addressId: selectedAddressId || undefined,  // ✅ Pass saved address ID
  phoneNumber: phoneNumber.trim(),
  // ... other fields
};
```

## Flow Now

### Scenario 1: Using Saved Address
1. User selects saved address in BookingScreen
2. `selectedAddressId` is set
3. BookingScreen passes `addressId` in request
4. BookingConfirmScreen uses existing address
5. ✅ **No new address created, uses saved one**

### Scenario 2: Entering New Address
1. User enters new address manually
2. `selectedAddressId` is null
3. BookingScreen passes address data without `addressId`
4. BookingConfirmScreen creates new address with `user.id`
5. ✅ **New address created with correct user_id**

### Scenario 3: Saving New Address
1. User enters new address
2. User checks "Save this address"
3. Address saved in SavedAddressesScreen with `user.id`
4. ✅ **Address saved with correct user_id**

## Data Integrity

### Before Fix
```
❌ Addresses created with wrong user_id
❌ Hardcoded address_id in bookings
❌ Phone number not saved
❌ Province and label lost
```

### After Fix
```
✅ Addresses created with correct user.id
✅ Dynamic address_id based on selection
✅ Phone number saved to bookings
✅ Province and label preserved
✅ Saved addresses reused properly
```

## Files Modified

1. ✅ **BookingConfirmScreen.tsx**
   - Added address creation logic
   - Removed hardcoded IDs
   - Added user validation
   - Added phone number to booking

2. ✅ **BookingScreen.tsx**
   - Pass province and label in address
   - Pass addressId when using saved address
   - Pass phone number

3. ✅ **types.ts**
   - Added province and label to address
   - Added addressId field
   - Added phoneNumber field

## Testing Checklist

- [x] Using saved address doesn't create duplicate
- [x] New address created with correct user_id
- [x] Phone number saved to booking
- [x] Province and label preserved
- [x] User validation works
- [x] Error handling for address creation
- [x] SavedAddressesScreen still works

## Database Verification

```sql
-- Check addresses are created with correct user_id
SELECT id, user_id, street, city, label 
FROM addresses 
WHERE user_id = 'edd168f2-0d05-4866-93fb-5348716b6a24';

-- Check bookings have correct customer_id and phone
SELECT id, customer_id, customer_phone, address_id
FROM bookings
WHERE customer_id = 'edd168f2-0d05-4866-93fb-5348716b6a24';
```

## Result

✅ **Addresses created with correct user_id**  
✅ **Saved addresses reused properly**  
✅ **Phone numbers saved**  
✅ **No hardcoded IDs**  
✅ **Data integrity maintained**  
✅ **Type safety improved**

**All addresses and bookings now use the correct user IDs!** 🎉
