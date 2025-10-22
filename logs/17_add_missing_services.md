# Add Missing Services to Database

**Date**: October 22, 2025  
**Task**: Add missing services from the original service lineup

## Services Added

Based on the original service lineup from `logs/01_services_update.md`, the following services were missing from the database:

### 1. **Travel Services** ✈️
- **Category**: Travel
- **Title**: Travel Services
- **Slug**: `travel-services`
- **Icon**: `airplane-outline`
- **Color**: `#0891B2` (Teal)
- **Description**: Professional tour guides and travel planning services
- **Call-out Fee**: $0
- **Duration**: 3-8 hours

### 2. **Personal Care** 💆‍♀️
- **Category**: Personal Care
- **Title**: Personal Care
- **Slug**: `personal-care`
- **Icon**: `person-outline`
- **Color**: `#EC4899` (Pink)
- **Description**: Massage and salon services at home
- **Call-out Fee**: $0
- **Duration**: 1-4 hours

### 3. **Moving Services** 📦
- **Category**: Moving
- **Title**: Moving Services
- **Slug**: `moving-services`
- **Icon**: `cube-outline`
- **Color**: `#06B6D4` (Cyan)
- **Description**: Professional packing and moving services
- **Call-out Fee**: $50
- **Duration**: 2-8 hours

## Database Changes

### SQL Insert Statement
```sql
INSERT INTO services (category, title, unit, base_price_cents, city, active, slug, icon, color, description, call_out_fee, min_duration, max_duration)
VALUES 
  ('Travel', 'Travel Services', 'fixed', 5000, 'Toronto', true, 'travel-services', 'airplane-outline', '#0891B2', 'Professional tour guides and travel planning services', 0, 180, 480),
  ('Personal Care', 'Personal Care', 'fixed', 8000, 'Toronto', true, 'personal-care', 'person-outline', '#EC4899', 'Massage and salon services at home', 0, 60, 240),
  ('Moving', 'Moving Services', 'fixed', 15000, 'Toronto', true, 'moving-services', 'cube-outline', '#06B6D4', 'Professional packing and moving services', 5000, 120, 480);
```

## Code Changes

### 1. HomeScreen.tsx
- Added `moving-services` to the `getServiceImage()` mapping
- Currently using `handyman.png` as fallback until `moving.png` is added

### 2. serviceCatalog.ts
- Added Moving Services with 3 subcategories:
  - **Local Moving**: Moving within the city
  - **Packing Services**: Professional packing and unpacking
  - **Furniture Moving**: Heavy furniture and appliance moving

## Current Service Lineup (8 Services)

| # | Service | Slug | Icon | Color |
|---|---------|------|------|-------|
| 1 | Maid Services | `maid-services` | home-outline | #4A5D23 (Green) |
| 2 | Cooks & Chefs | `cooks-chefs` | restaurant-outline | #D97706 (Orange) |
| 3 | Event Planning | `event-planning` | calendar-outline | #7C3AED (Purple) |
| 4 | Travel Services | `travel-services` | airplane-outline | #0891B2 (Teal) |
| 5 | Handyman | `handymen` | hammer-outline | #DC2626 (Red) |
| 6 | Car Detailing | `auto-services` | car-outline | #1F2937 (Dark Gray) |
| 7 | Personal Care | `personal-care` | person-outline | #EC4899 (Pink) |
| 8 | Moving Services | `moving-services` | cube-outline | #06B6D4 (Cyan) |

## Pending Tasks

### TODO: Add Moving Service Image
- [ ] Create or source `moving.png` image
- [ ] Add to `/assets/Services_images/` folder
- [ ] Update image mapping in both:
  - `HomeScreen.tsx` (line 122)
  - `serviceCatalog.ts` (line 373)

## Files Modified

1. **Database**: Added 3 new service records
2. `/Homeheros_app/src/screens/main/HomeScreen.tsx` - Added moving-services mapping
3. `/Homeheros_app/src/data/serviceCatalog.ts` - Added Moving Services category

## Result

✅ All 8 services from the original lineup are now in the database  
✅ Services are properly configured with slugs, icons, and colors  
✅ Image mapping is set up (using fallback for moving service)  
⚠️ Need to add `moving.png` image for complete implementation

## Next Steps

1. Add `moving.png` image to assets folder
2. Consider adding service variants to the database for the new services
3. Test the homepage to ensure all services display correctly
