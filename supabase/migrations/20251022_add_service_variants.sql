-- Add service variants (subcategories) for all services
-- Migration: 20251022_add_service_variants.sql

-- First, get the service IDs (we'll use them in the inserts)
-- Maid Services variants
INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Deep Cleaning',
    'deep-cleaning',
    'Complete deep cleaning service for your home',
    25000, -- $250.00
    'fixed',
    240, -- 4 hours
    true
FROM services WHERE slug = 'maid-services'
ON CONFLICT (service_id, slug) DO NOTHING;

INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Swimming Pool',
    'swimming-pool',
    'Professional pool cleaning and maintenance',
    50000, -- $500.00
    'fixed',
    120, -- 2 hours
    true
FROM services WHERE slug = 'maid-services'
ON CONFLICT (service_id, slug) DO NOTHING;

INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Garage',
    'garage',
    'Garage cleaning and organization',
    15000, -- $150.00
    'fixed',
    180, -- 3 hours
    true
FROM services WHERE slug = 'maid-services'
ON CONFLICT (service_id, slug) DO NOTHING;

-- Cooks & Chefs variants
INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Home Cooking',
    'home-cooking',
    'Daily meals tailored to your taste and diet',
    7500, -- $75.00
    'hourly',
    180, -- 3 hours
    true
FROM services WHERE slug = 'cooks-chefs'
ON CONFLICT (service_id, slug) DO NOTHING;

INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Grocery Shopping',
    'grocery-shopping',
    'Personal grocery shopping service',
    5000, -- $50.00
    'fixed',
    120, -- 2 hours
    true
FROM services WHERE slug = 'cooks-chefs'
ON CONFLICT (service_id, slug) DO NOTHING;

INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Event Catering',
    'event-catering',
    'Professional catering for events',
    15000, -- $150.00
    'hourly',
    300, -- 5 hours
    true
FROM services WHERE slug = 'cooks-chefs'
ON CONFLICT (service_id, slug) DO NOTHING;

-- Event Planning variants
INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Corporate Events',
    'corporate-events',
    'Professional corporate event planning',
    50000, -- $500.00
    'fixed',
    480, -- 8 hours
    true
FROM services WHERE slug = 'event-planning'
ON CONFLICT (service_id, slug) DO NOTHING;

INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Weddings',
    'weddings',
    'Complete wedding planning service',
    100000, -- $1000.00
    'fixed',
    720, -- 12 hours
    true
FROM services WHERE slug = 'event-planning'
ON CONFLICT (service_id, slug) DO NOTHING;

INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Social Celebrations',
    'social-celebrations',
    'Birthday parties and social events',
    30000, -- $300.00
    'fixed',
    360, -- 6 hours
    true
FROM services WHERE slug = 'event-planning'
ON CONFLICT (service_id, slug) DO NOTHING;

-- Travel Services variants
INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Local Tours',
    'local-tours',
    'Guided local city tours',
    10000, -- $100.00
    'hourly',
    240, -- 4 hours
    true
FROM services WHERE slug = 'travel-services'
ON CONFLICT (service_id, slug) DO NOTHING;

INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Luxury Getaways',
    'luxury-getaways',
    'Premium travel planning and experiences',
    50000, -- $500.00
    'fixed',
    480, -- 8 hours
    true
FROM services WHERE slug = 'travel-services'
ON CONFLICT (service_id, slug) DO NOTHING;

INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Group Travel',
    'group-travel',
    'Group travel coordination and planning',
    30000, -- $300.00
    'fixed',
    360, -- 6 hours
    true
FROM services WHERE slug = 'travel-services'
ON CONFLICT (service_id, slug) DO NOTHING;

INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Airport Pickups',
    'airport-pickups',
    'Airport transfer and pickup service',
    8000, -- $80.00
    'fixed',
    120, -- 2 hours
    true
FROM services WHERE slug = 'travel-services'
ON CONFLICT (service_id, slug) DO NOTHING;

-- Handymen variants
INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Repairs & Installs',
    'repairs-installs',
    'General repairs and installations',
    6500, -- $65.00 (call out fee)
    'hourly',
    120, -- 2 hours
    true
FROM services WHERE slug = 'handymen'
ON CONFLICT (service_id, slug) DO NOTHING;

INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Electrical',
    'electrical',
    'Electrical repairs and installations',
    6500, -- $65.00 (call out fee)
    'hourly',
    90, -- 1.5 hours
    true
FROM services WHERE slug = 'handymen'
ON CONFLICT (service_id, slug) DO NOTHING;

INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Plumbing',
    'plumbing',
    'Plumbing repairs and installations',
    6500, -- $65.00 (call out fee)
    'hourly',
    120, -- 2 hours
    true
FROM services WHERE slug = 'handymen'
ON CONFLICT (service_id, slug) DO NOTHING;

INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Moving Services',
    'moving-services-handyman',
    'Furniture moving and heavy lifting',
    10000, -- $100.00
    'hourly',
    180, -- 3 hours
    true
FROM services WHERE slug = 'handymen'
ON CONFLICT (service_id, slug) DO NOTHING;

-- Auto Services variants
INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Auto Repair',
    'auto-repair',
    'Mobile auto repair service',
    15000, -- $150.00 (call out fee)
    'hourly',
    240, -- 4 hours
    true
FROM services WHERE slug = 'auto-services'
ON CONFLICT (service_id, slug) DO NOTHING;

INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Auto Detailing',
    'auto-detailing',
    'Complete car detailing service',
    15000, -- $150.00 (call out fee)
    'fixed',
    180, -- 3 hours
    true
FROM services WHERE slug = 'auto-services'
ON CONFLICT (service_id, slug) DO NOTHING;

-- Personal Care variants
INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Massage Therapy',
    'massage-therapy',
    'Professional massage therapy at home',
    12000, -- $120.00
    'hourly',
    90, -- 1.5 hours
    true
FROM services WHERE slug = 'personal-care'
ON CONFLICT (service_id, slug) DO NOTHING;

INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Spa Services',
    'spa-services',
    'At-home spa treatments',
    15000, -- $150.00
    'fixed',
    120, -- 2 hours
    true
FROM services WHERE slug = 'personal-care'
ON CONFLICT (service_id, slug) DO NOTHING;

INSERT INTO service_variants (service_id, name, slug, description, base_price, price_type, default_duration, is_active)
SELECT 
    id,
    'Salon Services',
    'salon-services',
    'Hair, nails, and beauty services at home',
    10000, -- $100.00
    'hourly',
    120, -- 2 hours
    true
FROM services WHERE slug = 'personal-care'
ON CONFLICT (service_id, slug) DO NOTHING;

-- Show summary of added variants
SELECT 
    s.title as service,
    COUNT(sv.id) as variant_count,
    STRING_AGG(sv.name, ', ' ORDER BY sv.name) as variants
FROM services s
LEFT JOIN service_variants sv ON s.id = sv.service_id
GROUP BY s.id, s.title
ORDER BY s.title;
