-- Add service add-ons to the database
-- Migration: 20251022_add_service_addons.sql

-- Maid Services Add-ons
INSERT INTO add_ons (service_id, name, description, price, category, is_active)
SELECT 
    id,
    'Fridge Cleaning',
    'Deep clean inside and outside of refrigerator',
    50.00,
    'kitchen',
    true
FROM services WHERE slug = 'maid-services'
ON CONFLICT DO NOTHING;

INSERT INTO add_ons (service_id, name, description, price, category, is_active)
SELECT 
    id,
    'Oven Cleaning',
    'Deep clean oven interior and exterior',
    75.00,
    'kitchen',
    true
FROM services WHERE slug = 'maid-services'
ON CONFLICT DO NOTHING;

INSERT INTO add_ons (service_id, name, description, price, category, is_active)
SELECT 
    id,
    'Garage Cleaning',
    'Sweep and organize garage space',
    75.00,
    'exterior',
    true
FROM services WHERE slug = 'maid-services'
ON CONFLICT DO NOTHING;

INSERT INTO add_ons (service_id, name, description, price, category, is_active)
SELECT 
    id,
    'Basement Cleaning',
    'Clean and organize basement area',
    100.00,
    'interior',
    true
FROM services WHERE slug = 'maid-services'
ON CONFLICT DO NOTHING;

INSERT INTO add_ons (service_id, name, description, price, category, is_active)
SELECT 
    id,
    'Window Cleaning',
    'Clean interior and exterior windows',
    60.00,
    'windows',
    true
FROM services WHERE slug = 'maid-services'
ON CONFLICT DO NOTHING;

-- Handymen Add-ons
INSERT INTO add_ons (service_id, name, description, price, category, is_active)
SELECT 
    id,
    'Additional Outlet Installation',
    'Install additional electrical outlet',
    150.00,
    'electrical',
    true
FROM services WHERE slug = 'handymen'
ON CONFLICT DO NOTHING;

INSERT INTO add_ons (service_id, name, description, price, category, is_active)
SELECT 
    id,
    'Light Fixture Installation',
    'Install new light fixture',
    100.00,
    'electrical',
    true
FROM services WHERE slug = 'handymen'
ON CONFLICT DO NOTHING;

INSERT INTO add_ons (service_id, name, description, price, category, is_active)
SELECT 
    id,
    'Furniture Assembly',
    'Assemble furniture pieces',
    80.00,
    'assembly',
    true
FROM services WHERE slug = 'handymen'
ON CONFLICT DO NOTHING;

-- Cooks & Chefs Add-ons
INSERT INTO add_ons (service_id, name, description, price, category, is_active)
SELECT 
    id,
    'Grocery Shopping',
    'Purchase ingredients for meal preparation',
    25.00,
    'preparation',
    true
FROM services WHERE slug = 'cooks-chefs'
ON CONFLICT DO NOTHING;

INSERT INTO add_ons (service_id, name, description, price, category, is_active)
SELECT 
    id,
    'Meal Prep Service',
    'Prepare multiple meals for the week',
    150.00,
    'preparation',
    true
FROM services WHERE slug = 'cooks-chefs'
ON CONFLICT DO NOTHING;

INSERT INTO add_ons (service_id, name, description, price, category, is_active)
SELECT 
    id,
    'Special Diet Accommodation',
    'Accommodate special dietary requirements',
    50.00,
    'customization',
    true
FROM services WHERE slug = 'cooks-chefs'
ON CONFLICT DO NOTHING;

-- Auto Services Add-ons
INSERT INTO add_ons (service_id, name, description, price, category, is_active)
SELECT 
    id,
    'Engine Bay Cleaning',
    'Deep clean engine compartment',
    75.00,
    'detailing',
    true
FROM services WHERE slug = 'auto-services'
ON CONFLICT DO NOTHING;

INSERT INTO add_ons (service_id, name, description, price, category, is_active)
SELECT 
    id,
    'Headlight Restoration',
    'Restore cloudy or yellowed headlights',
    50.00,
    'detailing',
    true
FROM services WHERE slug = 'auto-services'
ON CONFLICT DO NOTHING;

INSERT INTO add_ons (service_id, name, description, price, category, is_active)
SELECT 
    id,
    'Ceramic Coating',
    'Apply protective ceramic coating',
    200.00,
    'detailing',
    true
FROM services WHERE slug = 'auto-services'
ON CONFLICT DO NOTHING;

-- Personal Care Add-ons
INSERT INTO add_ons (service_id, name, description, price, category, is_active)
SELECT 
    id,
    'Aromatherapy',
    'Add essential oils to massage session',
    25.00,
    'enhancement',
    true
FROM services WHERE slug = 'personal-care'
ON CONFLICT DO NOTHING;

INSERT INTO add_ons (service_id, name, description, price, category, is_active)
SELECT 
    id,
    'Hot Stone Treatment',
    'Heated stone massage therapy',
    40.00,
    'enhancement',
    true
FROM services WHERE slug = 'personal-care'
ON CONFLICT DO NOTHING;

INSERT INTO add_ons (service_id, name, description, price, category, is_active)
SELECT 
    id,
    'Manicure & Pedicure',
    'Complete nail care service',
    60.00,
    'beauty',
    true
FROM services WHERE slug = 'personal-care'
ON CONFLICT DO NOTHING;

-- Show summary
SELECT 
    s.title as service,
    COUNT(a.id) as addon_count,
    STRING_AGG(a.name || ' ($' || a.price || ')', ', ' ORDER BY a.name) as addons
FROM services s
LEFT JOIN add_ons a ON s.id = a.service_id
GROUP BY s.id, s.title
ORDER BY s.title;
