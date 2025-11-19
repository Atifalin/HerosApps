# Database & Code Audit - Hero Job Management
**Date:** November 19, 2025

## Database Schema Audit

### ✅ Existing Tables (Verified)

#### 1. **bookings** table
- **Columns:**
  - `id`, `customer_id`, `contractor_id`, `hero_id`, `address_id`
  - `service_id`, `service_variant_id`, `service_name`, `variant_name`
  - `status` (booking_status enum)
  - `scheduled_at`, `duration_min`, `price_cents`, `tip_cents`, `currency`
  - `customer_phone`, `notes`
  - `created_at`, `updated_at`
- **Status enum values:** requested, awaiting_hero_accept, enroute, arrived, in_progress, completed, rated, declined, expired, cancelled_by_customer, cancelled_by_admin, reassigned, dispute, refund_partial, refund_full
- **Foreign keys:** ✅ All correct

#### 2. **heros** table
- **Columns:**
  - `id`, `contractor_id`, `user_id`, `name`, `alias`, `photo_url`
  - `skills`, `categories`, `rating_avg`, `rating_count`, `bio`, `badges`
  - `status`, `verification_status`, `availability_json`, `docs_json`
- **Status values:** pending, active, inactive
- **Verification status:** pending, verified, rejected

#### 3. **gps_pings** table
- **Columns:** `id`, `booking_id`, `hero_id`, `lat`, `lng`, `speed`, `ts`, `geom`
- **Note:** Column is `ts` not `created_at` ✅ Fixed in migration

#### 4. **booking_photos** table ✅ NEW
- **Columns:** `id`, `booking_id`, `uploaded_by`, `photo_url`, `photo_type`, `caption`, `created_at`
- **Photo types:** completion, arrival, in_progress, issue
- **RLS:** ✅ Configured

#### 5. **notifications** table ✅ EXISTING
- **Columns:** `id`, `user_id`, `title`, `message`, `type`
  - `related_booking_id`, `related_hero_id`, `data`
  - `read` (boolean), `read_at`, `created_at`
- **Note:** Uses `related_booking_id` not `booking_id` ✅
- **Note:** Uses `read` not `is_read` ✅
- **RLS:** ✅ Configured

#### 6. **reviews** table
- **Columns:** Now includes `tip_cents`, `customer_confirmed`, `confirmed_at` ✅

#### 7. **job_photos** table (DUPLICATE?)
- **Note:** There's both `booking_photos` and `job_photos` tables
- **Decision:** Use `booking_photos` (newly created with proper RLS)

#### 8. **addresses** table
- **Columns:** Includes `lat`, `lng`, `line1`, `street`, `city`, `province`, `postal_code`
- **Note:** Has both `line1` and `street` (street is alias)

#### 9. **profiles** table
- **Columns:** `id`, `role`, `name`, `email`, `phone`, `status`
- **Note:** Separate from `users` table

---

## Code Audit - Main App (Customer)

### BookingScreen.tsx ✅
**Status:** Working correctly
- Fetches add-ons from Supabase ✅
- Fetches saved addresses ✅
- Calculates pricing with add-ons ✅
- Passes correct data to BookingConfirmScreen ✅

**Key Data Flow:**
```typescript
bookingRequest = {
  serviceId, subcategoryId, serviceName, variantName,
  scheduledDate, scheduledTime, duration,
  address, addressId, phoneNumber,
  specialInstructions, addOns: string[]
}
pricing = { basePrice, callOutFee, addOnTotal, subtotal, tax, total }
```

### BookingConfirmScreen.tsx ✅
**Status:** Recently updated, working
- No hero selection (hero_id = null) ✅
- Creates booking with status 'requested' ✅
- Inserts add-ons with unit_price and total_price ✅
- Mock payment notice displayed ✅
- Fetches and displays add-on details ✅

**Database Operations:**
1. Create/get address
2. Create booking (hero_id = null, status = 'requested')
3. Create payment intent (if payment method exists)
4. Insert booking_add_ons with pricing
5. Navigate to BookingStatus

### BookingStatusScreen.tsx ✅
**Status:** Working with real-time updates
- Real-time subscription to booking updates ✅
- Fetches booking with hero details using `fk_bookings_hero` ✅
- Fetches add-ons from `booking_add_ons` table ✅
- Displays hero info, address, add-ons ✅

**Query Structure:**
```typescript
.from('bookings')
.select(`
  *,
  heros:fk_bookings_hero (id, name, rating_avg, rating_count, skills, contractor_id),
  services (id, title),
  service_variants (id, name),
  addresses (id, street, line1, city, province, postal_code, label)
`)
```

---

## Code Audit - GO App (Hero)

### JobsScreen.tsx ⚠️ NEEDS ENHANCEMENT
**Current Status:** Basic functionality
- Fetches jobs for logged-in hero ✅
- Displays job cards with status ✅
- Sorting and filtering ✅
- Real-time updates: ❌ NOT IMPLEMENTED

**Issues to Fix:**
1. Uses `profiles!customer_id` - should use `profiles:customer_id`
2. No status filtering (all jobs shown together)
3. Status colors include old statuses
4. Price is shown (should be hidden per requirements)

**Required Enhancements:**
1. Add status filter tabs (Pending, Active, Completed)
2. Hide price display
3. Add real-time subscription
4. Update status color mapping

### JobDetailScreen.tsx ⚠️ NEEDS MAJOR ENHANCEMENT
**Current Status:** Basic display only
- Fetches job details ✅
- Displays customer info, address, schedule ✅
- Shows map ✅
- Basic status actions ✅

**Critical Issues:**
1. **Status flow is incorrect:**
   - `requested` → Accept → `awaiting_hero_accept` ❌ (should stay `awaiting_hero_accept`)
   - Missing `declined` action
2. **No GPS tracking** when en route
3. **No photo upload** for completion
4. **Price is shown** (should be hidden)
5. **No photo requirement** for completion

**Required Enhancements:**
1. Fix status action flow:
   - `awaiting_hero_accept` → Accept/Decline
   - `awaiting_hero_accept` (after accept) → Start En Route
   - `enroute` → Mark Arrived (with GPS tracking)
   - `arrived` → Start Job
   - `in_progress` → Complete Job (requires photo)
2. Add GPS tracking service
3. Add camera/photo upload
4. Hide pricing
5. Add decline functionality

---

## Status Flow (Corrected)

### Customer App Flow:
1. **requested** - Initial booking (no hero assigned)
2. Admin assigns hero → **awaiting_hero_accept**
3. Hero accepts → Customer sees "Hero On The Way"
4. Hero starts en route → **enroute** (GPS tracking starts)
5. Hero arrives → **arrived**
6. Hero starts work → **in_progress**
7. Hero completes (with photo) → **completed**
8. Customer rates/tips/confirms → **rated**

### Hero Decline Flow:
1. **awaiting_hero_accept** → Hero declines → **declined**
2. Admin sees declined job
3. Admin reassigns to different hero → **awaiting_hero_accept**

---

## Key Findings

### ✅ What's Working:
1. Database schema is solid
2. Main app booking flow works
3. Add-ons system fully functional
4. Real-time subscriptions in place
5. Notifications system ready
6. RLS policies configured

### ⚠️ What Needs Work:
1. GO app status actions need complete rewrite
2. GPS tracking service doesn't exist
3. Photo upload for completion not implemented
4. Status flow logic incorrect in JobDetailScreen
5. No decline functionality
6. Price should be hidden in GO app

### 🔧 Implementation Priority:
1. **Phase 2.1:** Fix JobDetailScreen status actions
2. **Phase 2.2:** Add GPS tracking service
3. **Phase 2.3:** Add photo upload for completion
4. **Phase 2.4:** Add decline functionality
5. **Phase 2.5:** Enhance JobsScreen with filters
6. **Phase 2.6:** Hide pricing in GO app

---

## Database Column Reference (Quick Lookup)

### bookings table:
- `hero_id` (UUID, nullable)
- `status` (booking_status enum)
- `customer_phone` (text)
- `scheduled_at` (timestamptz)
- `duration_min` (integer)
- `price_cents` (integer)
- `tip_cents` (integer)

### addresses table:
- `line1` (text) - main address line
- `street` (text) - alias for line1
- `lat`, `lng` (numeric)

### gps_pings table:
- `ts` (timestamptz) - NOT created_at!
- `lat`, `lng`, `speed` (numeric)

### notifications table:
- `related_booking_id` (UUID) - NOT booking_id!
- `read` (boolean) - NOT is_read!

### booking_photos table:
- `photo_type` (varchar) - completion, arrival, in_progress, issue
- `uploaded_by` (UUID) - references users.id

---

## Ready to Proceed with Phase 2 ✅

All database tables verified, existing code audited, and issues identified.
