# Hero Job Management & Real-Time Status Implementation

**Date:** November 19, 2025
**Objective:** Implement complete job status management for heroes in GO app with real-time updates, GPS tracking, photo uploads, and customer notifications

---

## Implementation Plan

### Phase 1: Database Schema & Migrations ✅
**Status:** Ready to implement

#### 1.1 Job Completion Photos
- [ ] Create `booking_photos` table
- [ ] Store multiple photos per booking
- [ ] Link to booking and upload stage (completion, arrival, etc.)
- [ ] RLS policies for hero upload and customer view

#### 1.2 GPS Tracking Enhancement
- [ ] Verify `gps_pings` table exists and is functional
- [ ] Add indexes for performance
- [ ] RLS policies for hero insert and customer read
- [ ] Add ETA calculation function

#### 1.3 Notifications System
- [ ] Create `notifications` table
- [ ] Support in-app and push notifications
- [ ] Link to bookings and users
- [ ] RLS policies for user access

#### 1.4 Tips & Ratings Enhancement
- [ ] Verify `reviews` table supports tips
- [ ] Add tip amount field if missing
- [ ] Customer confirmation field

**Testing:** Apply migrations and verify tables in Supabase

---

### Phase 2: GO App - Hero Job Management ✅
**Status:** Ready to implement

#### 2.1 Jobs List Screen (`JobsScreen.tsx`)
- [ ] Fetch jobs assigned to logged-in hero
- [ ] Filter by status (pending, en route, in progress, completed)
- [ ] Show job cards with key info
- [ ] Pull-to-refresh functionality
- [ ] Navigation to job detail

#### 2.2 Job Detail Screen Enhancement (`JobDetailScreen.tsx`)
- [ ] Display complete job information
- [ ] Status-based action buttons:
  - **Awaiting Accept:** Accept / Decline buttons
  - **Accepted:** Start En Route button
  - **En Route:** Mark Arrived button
  - **Arrived:** Start Job button
  - **In Progress:** Complete Job button (with photo)
- [ ] Customer contact info
- [ ] Address with map preview
- [ ] Service details
- [ ] Hide pricing information

#### 2.3 GPS Tracking Service
- [ ] Create `GPSService.ts` for background location tracking
- [ ] Start tracking when hero marks "En Route"
- [ ] Send location pings every 30 seconds
- [ ] Stop tracking when hero marks "Arrived"
- [ ] Handle permissions (iOS/Android)

#### 2.4 Photo Upload for Completion
- [ ] Camera integration (expo-camera or expo-image-picker)
- [ ] Photo preview before upload
- [ ] Upload to Supabase storage
- [ ] Link photo to booking
- [ ] Compress images for performance

#### 2.5 Status Update Logic
- [ ] Create `jobService.ts` for status updates
- [ ] API calls to update booking status
- [ ] Error handling and retry logic
- [ ] Optimistic UI updates

**Testing:** 
1. Hero logs in and sees assigned jobs
2. Accept a job and verify status change
3. Start en route and verify GPS tracking
4. Complete job with photo upload
5. Verify all status transitions work

---

### Phase 3: Main App - Customer Real-Time Updates ✅
**Status:** Ready to implement

#### 3.1 Booking Status Screen Enhancement (`BookingStatusScreen.tsx`)
- [ ] Real-time status updates (Supabase realtime subscriptions)
- [ ] Status timeline/progress indicator
- [ ] Hero information display
- [ ] Contact hero button (call/message)

#### 3.2 Live GPS Tracking Map
- [ ] Show map when hero is "En Route"
- [ ] Display hero's live location
- [ ] Show customer's location
- [ ] Draw route between hero and customer
- [ ] Calculate and display ETA
- [ ] Update location in real-time

#### 3.3 Job Completion Flow
- [ ] View completion photos uploaded by hero
- [ ] Rate hero (1-5 stars)
- [ ] Add written review
- [ ] Add tip amount
- [ ] Confirm job completion
- [ ] Payment processing with tip

#### 3.4 In-App Notifications
- [ ] Notification bell icon in header
- [ ] Notification list screen
- [ ] Mark as read functionality
- [ ] Navigate to relevant booking on tap

#### 3.5 Push Notifications (Future)
- [ ] Setup Supabase Edge Function for push
- [ ] FCM/APNs integration
- [ ] Notification triggers:
  - Hero accepts job
  - Hero en route
  - Hero 5 minutes away
  - Hero arrived
  - Job started
  - Job completed

**Testing:**
1. Create booking and assign hero
2. Hero accepts - customer sees update
3. Hero starts en route - customer sees live map
4. Verify ETA updates
5. Hero completes - customer rates and tips
6. Verify notifications work

---

### Phase 4: Admin Tool Updates ✅
**Status:** Ready to implement

#### 4.1 Job Assignment Dashboard Enhancement
- [ ] Show declined jobs separately
- [ ] Reassignment workflow for declined jobs
- [ ] Filter by status
- [ ] Show hero acceptance rate
- [ ] Bulk actions (future)

**Testing:**
1. Hero declines job
2. Admin sees declined job
3. Admin reassigns to different hero

---

### Phase 5: Edge Functions & Background Jobs ⏳
**Status:** Future enhancement

#### 5.1 ETA Calculation Function
- [ ] Calculate distance and time
- [ ] Consider traffic (Google Maps API)
- [ ] Update every minute

#### 5.2 Notification Triggers
- [ ] Status change notifications
- [ ] 5-minute arrival alert
- [ ] Job reminders

#### 5.3 GPS Cleanup Job
- [ ] Archive old GPS pings
- [ ] Optimize database

---

## Current Status: Phase 2 - IN PROGRESS 🚧

### Phase 1 - COMPLETED ✅
1. ✅ Created `booking_photos` table with RLS policies
2. ✅ Enhanced `gps_pings` table with proper RLS policies
3. ✅ Configured existing `notifications` table with RLS policies
4. ✅ Added `tip_cents`, `customer_confirmed`, `confirmed_at` to `reviews` table
5. ✅ Created helper functions: `create_notification()`, `mark_notification_read()`, `calculate_eta()`
6. ✅ Created trigger for automatic notifications on booking status changes
7. ✅ Completed database and code audit

### Phase 2 - Services Created ✅
1. ✅ Created `jobService.ts` - Job status management
   - Accept/decline jobs
   - Update status (enroute, arrived, in_progress, completed)
   - Upload job photos
   - Get job photos
2. ✅ Created `gpsService.ts` - GPS tracking
   - Request location permissions
   - Start/stop tracking
   - Send location pings every 30 seconds
   - Get current location

### Phase 2 - Bug Fixes ✅
1. ✅ Fixed RLS policies blocking hero access to bookings
2. ✅ Fixed RLS policies blocking customer access to booking history
3. ✅ Fixed foreign key syntax in JobsScreen (`profiles!customer_id` → `profiles:customer_id`)
4. ✅ Fixed foreign key syntax in BookingHistoryScreen (`heros!bookings_hero_id_fkey` → `heros:fk_bookings_hero`)
5. ✅ Added UPDATE policy for heroes to update job status
6. ✅ Enabled RLS on profiles table with proper hero access
7. ✅ Fixed BookingStatusScreen to show all status values correctly

### Phase 2 - JobDetailScreen Updates ✅
1. ✅ Added imports for ImagePicker, jobService, gpsService, useAuth
2. ✅ Added state variables for GPS tracking and photo upload
3. ✅ Added GPS tracking check in useEffect
4. ✅ Replaced old status update functions with new service-based handlers
5. ✅ Added Accept/Decline job handlers
6. ✅ Added GPS tracking integration (start en route, mark arrived)
7. ✅ Added photo upload handlers (take photo, upload, complete job)
8. ✅ Updated getStatusActions with correct status flow
9. ✅ Added photo upload modal UI
10. ✅ Added all missing styles
11. ✅ Removed pricing display (hidden from heroes)

### Phase 2 - Additional Fixes & Features ✅
1. ✅ Installed expo-image-picker and expo-location packages
2. ✅ Fixed hero profile RLS policies (heroes can read/update own profile)
3. ✅ Fixed notifications foreign key (changed from auth.users to profiles)
4. ✅ Fixed notification functions (related_booking_id, read column names)
5. ✅ Fixed acceptJob flow (uses local state, no invalid enum value)
6. ✅ Added active booking card to home screen
7. ✅ Added GPS tracking indicator to customer app

### Phase 2 - COMPLETE ✅

**What's Working:**
- ✅ Admin assigns job → Hero receives it
- ✅ Hero accepts job → Shows "Start Journey" button
- ✅ Hero starts journey → GPS tracking starts automatically
- ✅ Customer sees active booking card on home screen
- ✅ Customer sees real-time status updates
- ✅ Hero marks arrived → GPS stops
- ✅ Hero starts work → Status updates
- ✅ Hero completes with photo → Job marked complete
- ✅ All notifications working
- ✅ Pricing hidden from heroes
- ✅ Real-time updates via Supabase

**Next Steps: Phase 3 - Optional Enhancements**
1. Add live map view for customer to see hero location
2. Add ETA calculation
3. Add status filters to JobsScreen
4. Add rating/tip flow for customer
5. Add earnings tracking for heroes

---

## Notes
- Hide pricing in GO app as requested
- Real-time updates using Supabase Realtime
- GPS tracking only when en route (battery optimization)
- Photo required for job completion
- Customer must confirm and rate to finalize
