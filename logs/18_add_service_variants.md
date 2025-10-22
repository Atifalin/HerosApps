# Add Service Variants (Subcategories)

**Date**: October 22, 2025  
**Task**: Add subcategories for all 8 services

## Service Variants Added

### 1. **Maid Services** (5 variants)
- ✅ Deep Cleaning - $250 (4 hours)
- ✅ Swimming Pool - $500 (2 hours)
- ✅ Garage - $150 (3 hours)
- ✅ Move In/Out Cleaning - $200 (4 hours) *[existing]*
- ✅ Regular Cleaning - $90 (2 hours) *[existing]*

### 2. **Cooks & Chefs** (4 variants)
- ✅ Home Cooking - $75/hour (3 hours)
- ✅ Grocery Shopping - $50 (2 hours)
- ✅ Event Catering - $150/hour (5 hours)
- ✅ Personal Chef - $120 (3 hours) *[existing]*

### 3. **Event Planning** (5 variants)
- ✅ Corporate Events - $500 (8 hours)
- ✅ Weddings - $1000 (12 hours)
- ✅ Social Celebrations - $300 (6 hours)
- ✅ Birthday Party - $250 (5 hours) *[existing]*
- ✅ Wedding Planning - $500 (8 hours) *[existing]*

### 4. **Travel Services** (4 variants)
- ✅ Local Tours - $100/hour (4 hours)
- ✅ Luxury Getaways - $500 (8 hours)
- ✅ Group Travel - $300 (6 hours)
- ✅ Airport Pickups - $80 (2 hours)

### 5. **Handymen** (4 variants)
- ✅ Repairs & Installs - $65/hour (2 hours)
- ✅ Electrical - $65/hour (1.5 hours)
- ✅ Plumbing - $65/hour (2 hours)
- ✅ Moving Services - $100/hour (3 hours)

### 6. **Auto Services** (2 variants)
- ✅ Auto Repair - $150/hour (4 hours)
- ✅ Auto Detailing - $150 (3 hours)

### 7. **Personal Care** (3 variants)
- ✅ Massage Therapy - $120/hour (1.5 hours)
- ✅ Spa Services - $150 (2 hours)
- ✅ Salon Services - $100/hour (2 hours)

### 8. **Moving Services** (3 variants)
- ✅ Local Moving - $150 (4 hours)
- ✅ Packing Services - $100 (3 hours)
- ✅ Furniture Moving - $200 (2 hours)

## Database Schema

### Service Variants Table Structure
```sql
CREATE TABLE service_variants (
    id UUID PRIMARY KEY,
    service_id UUID REFERENCES services(id),
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL,
    description TEXT,
    base_price DECIMAL(10,2),      -- Price in cents
    price_type VARCHAR(20),         -- 'fixed' or 'hourly'
    default_duration INTEGER,       -- Duration in minutes
    is_active BOOLEAN DEFAULT true,
    UNIQUE(service_id, slug)
);
```

## Summary Statistics

| Service | Variant Count | Total |
|---------|--------------|-------|
| Maid Services | 5 variants | ✅ |
| Cooks & Chefs | 4 variants | ✅ |
| Event Planning | 5 variants | ✅ |
| Travel Services | 4 variants | ✅ |
| Handymen | 4 variants | ✅ |
| Auto Services | 2 variants | ✅ |
| Personal Care | 3 variants | ✅ |
| Moving Services | 3 variants | ✅ |
| **TOTAL** | **30 variants** | ✅ |

## Price Types

- **Fixed**: One-time flat fee for the service
- **Hourly**: Price per hour of service

## Migration Details

### Files Created
- `/supabase/migrations/20251022_add_service_variants.sql`

### SQL Operations
- 30 INSERT statements for service variants
- Used `ON CONFLICT DO NOTHING` to avoid duplicates
- Preserved existing variants that were already in the database

## Database Query Results

All services now have their subcategories properly configured:

```
     service     | variant_count |                    variants                    
-----------------+---------------+-----------------------------------------------
 Car Detailing   |             2 | Auto Detailing, Auto Repair
 Cooks & Chefs   |             4 | Event Catering, Grocery Shopping, Home Cooking, Personal Chef
 Event Planning  |             5 | Birthday Party, Corporate Events, Social Celebrations, Wedding Planning, Weddings
 Handyman        |             4 | Electrical, Moving Services, Plumbing, Repairs & Installs
 Maid Services   |             5 | Deep Cleaning, Garage, Move In/Out Cleaning, Regular Cleaning, Swimming Pool
 Moving Services |             3 | Furniture Moving, Local Moving, Packing Services
 Personal Care   |             3 | Massage Therapy, Salon Services, Spa Services
 Travel Services |             4 | Airport Pickups, Group Travel, Local Tours, Luxury Getaways
```

## Next Steps

1. ✅ All service variants are in the database
2. ✅ Proper pricing and duration configured
3. ✅ Slug-based routing ready
4. 🔄 Frontend will automatically fetch these variants via the existing query
5. 🔄 Test the service detail pages to ensure variants display correctly

## Notes

- Some services had existing variants with slightly different names/prices
- All new variants follow consistent naming and pricing structure
- Price stored in cents (e.g., $150 = 15000 cents)
- Duration stored in minutes
- Each variant has a unique slug for routing

## Result

✅ **All 8 services now have complete subcategories!**  
✅ **30 total service variants available**  
✅ **Ready for booking flow implementation**
