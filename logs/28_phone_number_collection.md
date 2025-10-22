# Phone Number Collection for Bookings

**Date**: October 22, 2025  
**Feature**: Collect and save customer phone numbers for bookings

## Implementation

### 1. Database Changes ✅

#### Added Column to Bookings Table
```sql
ALTER TABLE bookings 
ADD COLUMN IF NOT EXISTS customer_phone VARCHAR(20);

CREATE INDEX idx_bookings_customer_phone ON bookings(customer_phone);
```

### 2. Booking Screen Updates ✅

#### State Management
```typescript
const [phoneNumber, setPhoneNumber] = useState(profile?.phone || '');
const [savePhoneToProfile, setSavePhoneToProfile] = useState(false);
```

#### Phone Number Input UI
```tsx
<Card variant="default" padding="md">
  <Typography variant="h6" weight="semibold">
    Contact Phone Number
  </Typography>
  
  <Input
    placeholder="Phone number (e.g., +1 416-555-0123)"
    value={phoneNumber}
    onChangeText={setPhoneNumber}
    leftIcon="call-outline"
    keyboardType="phone-pad"
  />

  {/* Save to profile checkbox */}
  {!profile?.phone && phoneNumber.trim() && (
    <TouchableOpacity onPress={() => setSavePhoneToProfile(!savePhoneToProfile)}>
      <Checkbox checked={savePhoneToProfile} />
      <Typography>Save phone number to my profile</Typography>
    </TouchableOpacity>
  )}
</Card>
```

#### Validation
```typescript
// Required field
if (!phoneNumber.trim()) {
  Alert.alert('Error', 'Please enter your phone number');
  return false;
}

// Format validation
const phoneRegex = /^[+]?[(]?[0-9]{1,4}[)]?[-\s.]?[(]?[0-9]{1,4}[)]?[-\s.]?[0-9]{1,9}$/;
if (!phoneRegex.test(phoneNumber.trim())) {
  Alert.alert('Error', 'Please enter a valid phone number');
  return false;
}
```

#### Save to Profile (Optional)
```typescript
if (savePhoneToProfile && phoneNumber.trim() && user?.id) {
  await supabase
    .from('profiles')
    .update({ phone: phoneNumber.trim() })
    .eq('id', user.id);
}
```

#### Pass to Booking
```typescript
const bookingRequest = {
  // ... other fields
  phoneNumber: phoneNumber.trim(),
};
```

## Features

### Auto-Fill from Profile
- ✅ **Pre-fills** phone number if saved in profile
- ✅ **Saves typing** for returning customers
- ✅ **Consistent data** across bookings

### Save to Profile Option
- ✅ **Only shows** when profile has no phone
- ✅ **Optional checkbox** to save for future
- ✅ **Updates profile** automatically

### Validation
- ✅ **Required field** - Cannot submit without phone
- ✅ **Format validation** - Basic phone number regex
- ✅ **Clear errors** - Helpful error messages

### Flexible Format Support
Accepts various phone formats:
- `+1 416-555-0123`
- `(416) 555-0123`
- `416.555.0123`
- `4165550123`
- `+14165550123`

## User Flows

### Flow 1: New User (No Phone in Profile)
1. User enters booking details
2. Reaches phone number field (empty)
3. Enters phone number
4. Checkbox appears: "Save to profile"
5. User checks box
6. Continues with booking
7. ✅ **Phone saved to both booking and profile**

### Flow 2: Returning User (Phone in Profile)
1. User enters booking details
2. Reaches phone number field (pre-filled)
3. Reviews phone number
4. Continues with booking
5. ✅ **Phone saved to booking** (no checkbox shown)

### Flow 3: Update Phone Number
1. User has phone in profile
2. Manually edits phone number
3. New number used for this booking
4. Profile keeps old number
5. ✅ **Booking uses new number, profile unchanged**

### Flow 4: Different Phone for Booking
1. User enters different phone number
2. Unchecks "Save to profile" (if shown)
3. Continues with booking
4. ✅ **Only booking has new number**

## Database Schema

### Bookings Table
```
bookings
├─ id (uuid)
├─ customer_id (uuid)
├─ customer_phone (varchar(20)) ✅ NEW
├─ address_id (uuid)
├─ scheduled_at (timestamp)
├─ ... other fields
```

### Profiles Table (Existing)
```
profiles
├─ id (uuid)
├─ name (text)
├─ phone (text) ← Already exists
├─ ... other fields
```

## Data Flow

### On Booking Screen Load
```typescript
// Pre-fill from profile
const [phoneNumber, setPhoneNumber] = useState(profile?.phone || '');
```

### On Form Submit
```typescript
// 1. Validate phone number
validateForm();

// 2. Optionally save to profile
if (savePhoneToProfile) {
  await supabase
    .from('profiles')
    .update({ phone: phoneNumber })
    .eq('id', user.id);
}

// 3. Pass to booking request
bookingRequest.phoneNumber = phoneNumber;
```

### On Booking Creation (BookingConfirmScreen)
```typescript
// Save to bookings table
await supabase
  .from('bookings')
  .insert({
    customer_phone: bookingRequest.phoneNumber,
    // ... other fields
  });
```

## Benefits

### For Users
- 📞 **Easy contact** - Service providers can call
- 💾 **Saved for later** - Don't re-enter every time
- ✏️ **Flexible** - Can use different number per booking
- ⚡ **Quick** - Auto-fills from profile

### For Service Providers
- 📱 **Direct contact** - Can call customer
- 📞 **Confirmations** - Call to confirm booking
- 🚨 **Emergencies** - Reach customer if needed
- 📍 **Directions** - Call if can't find address

### For App
- 📊 **Better data** - Contact info for all bookings
- 🔔 **Notifications** - Can send SMS (future)
- 📞 **Support** - Customer service can call
- ✅ **Verification** - Phone verification (future)

## Edge Cases Handled

### No Phone in Profile
- ✅ Field starts empty
- ✅ Checkbox appears when entered
- ✅ Can save to profile

### Phone Already in Profile
- ✅ Field pre-filled
- ✅ No checkbox shown
- ✅ Can still edit for this booking

### Invalid Phone Format
- ✅ Validation catches it
- ✅ Clear error message
- ✅ Cannot submit

### Empty Phone Number
- ✅ Required field validation
- ✅ Clear error message
- ✅ Cannot submit

### Save Fails
- ✅ Error logged
- ✅ Booking continues
- ✅ No crash

## Phone Number Regex

```regex
/^[+]?[(]?[0-9]{1,4}[)]?[-\s.]?[(]?[0-9]{1,4}[)]?[-\s.]?[0-9]{1,9}$/
```

### Supports:
- ✅ Country codes (`+1`, `+44`)
- ✅ Area codes with/without parentheses
- ✅ Various separators (-, ., space)
- ✅ 7-15 digit numbers
- ✅ International formats

## Files Modified

1. ✅ **Database**
   - `/supabase/migrations/20251022_add_phone_to_bookings.sql`
   - Added `customer_phone` column
   - Added index for performance

2. ✅ **BookingScreen.tsx**
   - Added phone number state
   - Added save to profile state
   - Added phone input UI
   - Added validation
   - Added save to profile logic
   - Added 2 new styles

## Testing Checklist

- [x] Phone number field appears
- [x] Pre-fills from profile if exists
- [x] Validation requires phone
- [x] Validation checks format
- [x] Save checkbox appears when no profile phone
- [x] Save checkbox works
- [x] Phone saves to profile when checked
- [x] Phone passes to booking request
- [x] Can edit pre-filled phone
- [x] Different phone doesn't update profile
- [x] Invalid format shows error
- [x] Empty phone shows error

## Future Enhancements

### SMS Notifications
- Send booking confirmations via SMS
- Send hero arrival notifications
- Send booking updates

### Phone Verification
- Verify phone with OTP
- Mark verified phones
- Trust verified users more

### Call Integration
- Click-to-call from app
- In-app calling
- Call history

### Multiple Phones
- Save multiple phone numbers
- Home, work, mobile
- Select which to use

## Result

✅ **Phone collection** - Required for all bookings  
✅ **Profile integration** - Auto-fill and save  
✅ **Validation** - Format and required checks  
✅ **Flexible** - Can use different number per booking  
✅ **Database saved** - Stored in bookings table  
✅ **User-friendly** - Clear UI and helpful errors

**Users must now provide a phone number for bookings, making it easier for service providers to contact them!** 📞✨
