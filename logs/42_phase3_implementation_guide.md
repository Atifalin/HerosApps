# Phase 3 Implementation Guide
**Date:** November 20, 2025

## Overview
Implementing customer-facing enhancements for real-time tracking and job completion flow.

---

## Phase 3.1: BookingStatusScreen Enhancements

### Features to Add:
1. ✅ Status timeline with progress indicators
2. ✅ Hero information card with rating
3. ✅ Contact buttons (Call/Message) when hero is active
4. ⏳ Helper functions for timeline rendering
5. ⏳ Styles for new components

### Status Order:
```
requested → awaiting_hero_accept → enroute → arrived → in_progress → completed
```

---

## Phase 3.2: Live GPS Tracking Map

### Features to Add:
1. MapView component showing hero location
2. Real-time GPS ping subscription
3. ETA calculation
4. Route visualization
5. Show only when status = 'enroute'

### Implementation:
- Subscribe to `gps_pings` table for real-time location
- Use latest ping to show hero marker
- Calculate distance and ETA
- Auto-refresh every 30 seconds

---

## Phase 3.3: Job Completion Flow

### Features to Add:
1. View completion photos
2. Rating modal (1-5 stars)
3. Review text input
4. Tip amount selection
5. Submit review and tip
6. Update booking status to 'rated'

### Flow:
```
completed → [View Photos] → [Rate & Review] → [Add Tip] → [Submit] → rated
```

---

## Implementation Steps

### Step 1: Add Helper Functions
```typescript
const isStatusAfter = (currentStatus: string, checkStatus: string): boolean
const renderTimelineItem = (label, icon, isActive, isCompleted): JSX.Element
```

### Step 2: Add Styles
- timelineCard
- timeline, timelineItem, timelineDot, timelineLine
- heroCard, heroInfo, heroAvatar, heroDetails
- contactButtons, contactButton, contactButtonText
- ratingContainer, ratingText

### Step 3: Fix Type Issues
- Update Hero type to include phone
- Fix status enum comparisons

---

## Files to Modify

1. `/Homeheros_app/src/screens/booking/BookingStatusScreen.tsx`
2. `/Homeheros_app/src/navigation/types.ts` (Hero type)
3. Create `/Homeheros_app/src/components/RatingModal.tsx`
4. Create `/Homeheros_app/src/components/LiveMap.tsx`

---

## Next Actions
1. Fix current errors in BookingStatusScreen
2. Add helper functions
3. Add missing styles
4. Test timeline display
5. Implement GPS map (3.2)
6. Implement rating flow (3.3)
