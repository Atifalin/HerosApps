-- Add-ons Feature Implementation

**Date**: October 22, 2025  
**Feature**: Add-ons for service bookings with correct price calculations

## Feature Overview

Add-ons allow customers to enhance their service bookings with additional options for an extra fee. The feature is fully integrated into the booking flow with automatic price calculations.

## Database Structure

### Add-ons Table Schema
```sql
CREATE TABLE add_ons (
    id UUID PRIMARY KEY,
    service_id UUID REFERENCES services(id),
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,  -- Stored in dollars
    category VARCHAR(100),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP
);
```

## Add-ons by Service

### 1. Maid Services (5 add-ons)
- ✅ **Fridge Cleaning** - $50.00 (Deep clean inside and outside of refrigerator)
- ✅ **Oven Cleaning** - $75.00 (Deep clean oven interior and exterior)
- ✅ **Garage Cleaning** - $75.00 (Sweep and organize garage space)
- ✅ **Basement Cleaning** - $100.00 (Clean and organize basement area)
- ✅ **Window Cleaning** - $60.00 (Clean interior and exterior windows)

### 2. Handymen (3 add-ons)
- ✅ **Additional Outlet Installation** - $150.00 (Install additional electrical outlet)
- ✅ **Light Fixture Installation** - $100.00 (Install new light fixture)
- ✅ **Furniture Assembly** - $80.00 (Assemble furniture pieces)

### 3. Cooks & Chefs (3 add-ons)
- ✅ **Grocery Shopping** - $25.00 (Purchase ingredients for meal preparation)
- ✅ **Meal Prep Service** - $150.00 (Prepare multiple meals for the week)
- ✅ **Special Diet Accommodation** - $50.00 (Accommodate special dietary requirements)

### 4. Car Detailing (3 add-ons)
- ✅ **Engine Bay Cleaning** - $75.00 (Deep clean engine compartment)
- ✅ **Headlight Restoration** - $50.00 (Restore cloudy or yellowed headlights)
- ✅ **Ceramic Coating** - $200.00 (Apply protective ceramic coating)

### 5. Personal Care (3 add-ons)
- ✅ **Aromatherapy** - $25.00 (Add essential oils to massage session)
- ✅ **Hot Stone Treatment** - $40.00 (Heated stone massage therapy)
- ✅ **Manicure & Pedicure** - $60.00 (Complete nail care service)

**Total**: 17 add-ons across 5 services

## Implementation Details

### Booking Screen Features

#### 1. Add-ons Display
```typescript
{addOns.length > 0 && (
  <Card>
    <Typography>Add-ons</Typography>
    {addOns.map((addOn) => (
      <TouchableOpacity onPress={() => toggleAddOn(addOn.id)}>
        <Typography>{addOn.name}</Typography>
        <Typography>{addOn.description}</Typography>
        <Typography>+${addOn.price}</Typography>
        <Checkbox checked={selectedAddOns.includes(addOn.id)} />
      </TouchableOpacity>
    ))}
  </Card>
)}
```

#### 2. Data Fetching
```typescript
const { data: addOnsData } = await supabase
  .from('add_ons')
  .select('*')
  .eq('service_id', serviceId)
  .eq('is_active', true);
```

#### 3. Price Calculation
```typescript
const calculatePricing = () => {
  // Base price from service variant
  let basePrice = parseFloat(subcategory.price.replace(/[^0-9.]/g, ''));
  
  // Call-out fee from service
  let callOutFee = parseFloat(service.callOutFee.replace(/[^0-9.]/g, ''));
  
  // Sum of selected add-ons
  let addOnTotal = selectedAddOns.reduce((total, addOnId) => {
    const addOn = addOns.find(a => a.id === addOnId);
    return total + (addOn?.price || 0);
  }, 0);

  const subtotal = basePrice + callOutFee + addOnTotal;
  const tax = subtotal * 0.12; // 12% (GST + PST)
  const total = subtotal + tax;

  return { basePrice, callOutFee, addOnTotal, subtotal, tax, total };
};
```

### Pricing Summary Display

```
Base Price:        $150.00
Call-out Fee:      $65.00
Add-ons:           $125.00  (if selected)
----------------------------
Subtotal:          $340.00
Tax (GST + PST):   $40.80
----------------------------
Total:             $380.80
```

## Price Storage Format

### Database
- **service_variants.base_price**: Stored in cents (INTEGER)
- **add_ons.price**: Stored in dollars (DECIMAL 10,2)
- **services.call_out_fee**: Stored in dollars (DECIMAL 10,2)

### Display Conversion
```typescript
// Service variant price (cents → dollars)
price: `From $${(variant.base_price / 100).toFixed(0)}`

// Add-on price (already in dollars)
price: parseFloat(addOn.price)

// Call-out fee (already in dollars)
callOutFee: parseFloat(service.call_out_fee)
```

## User Experience

### Booking Flow
1. **Select Service** → Navigate to service detail
2. **Choose Variant** → Navigate to booking screen
3. **Select Date/Time** → Choose when service is needed
4. **Enter Address** → Provide service location
5. **Choose Add-ons** → Select optional enhancements (NEW!)
6. **Review Pricing** → See total with add-ons included
7. **Confirm Booking** → Complete the booking

### Add-on Selection
- ✅ **Visual Checkboxes**: Clear indication of selected add-ons
- ✅ **Price Display**: Each add-on shows its price
- ✅ **Description**: Helpful details about what's included
- ✅ **Toggle**: Tap to add/remove add-ons
- ✅ **Live Updates**: Pricing updates immediately

## Files Modified

1. ✅ `/src/screens/booking/BookingScreen.tsx`
   - Fixed add-on price parsing
   - Added proper null safety
   - Ensured correct price calculations

2. ✅ Database Migration
   - Created `/supabase/migrations/20251022_add_service_addons.sql`
   - Added 17 add-ons across 5 services

## Testing Checklist

- [x] Add-ons load from database
- [x] Add-ons display correctly
- [x] Checkbox toggle works
- [x] Prices calculate correctly
- [x] Subtotal includes add-ons
- [x] Tax calculated on total with add-ons
- [x] Final total is accurate
- [x] Multiple add-ons can be selected
- [x] Deselecting add-ons updates price

## Price Calculation Examples

### Example 1: Maid Service with Add-ons
```
Deep Cleaning:           $75.00
+ Fridge Cleaning:       $50.00
+ Oven Cleaning:         $75.00
--------------------------------
Subtotal:               $200.00
Tax (12%):               $24.00
--------------------------------
Total:                  $224.00
```

### Example 2: Handyman with Call-out Fee
```
Electrical Work:         $65.00
Call-out Fee:            $65.00
+ Light Fixture:        $100.00
+ Outlet Installation:  $150.00
--------------------------------
Subtotal:               $380.00
Tax (12%):               $45.60
--------------------------------
Total:                  $425.60
```

### Example 3: Personal Care
```
Massage Therapy:        $120.00
+ Aromatherapy:          $25.00
+ Hot Stone:             $40.00
--------------------------------
Subtotal:               $185.00
Tax (12%):               $22.20
--------------------------------
Total:                  $207.20
```

## Result

✅ **17 add-ons available** across 5 services  
✅ **Correct price calculations** with tax  
✅ **Seamless UX** with checkboxes and live updates  
✅ **Database integration** for dynamic add-ons  
✅ **Flexible pricing** - customers can customize their service

**Customers can now enhance their bookings with add-ons!** 🎉
