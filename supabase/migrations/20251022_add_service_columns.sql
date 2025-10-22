-- Add missing columns to services table for HomeScreen compatibility
-- Migration: 20251022_add_service_columns.sql

-- Add new columns to services table
ALTER TABLE services
ADD COLUMN IF NOT EXISTS slug VARCHAR(255),
ADD COLUMN IF NOT EXISTS icon VARCHAR(100),
ADD COLUMN IF NOT EXISTS color VARCHAR(7),
ADD COLUMN IF NOT EXISTS description TEXT,
ADD COLUMN IF NOT EXISTS call_out_fee DECIMAL(10,2) DEFAULT 0,
ADD COLUMN IF NOT EXISTS min_duration INTEGER DEFAULT 120,
ADD COLUMN IF NOT EXISTS max_duration INTEGER DEFAULT 480;

-- Create unique index on slug
CREATE UNIQUE INDEX IF NOT EXISTS services_slug_idx ON services(slug);

-- Update existing records with slug values based on category
-- This ensures proper image mapping in the app
UPDATE services
SET slug = CASE
    WHEN LOWER(category) LIKE '%maid%' OR LOWER(category) LIKE '%clean%' THEN 'maid-services'
    WHEN LOWER(category) LIKE '%cook%' OR LOWER(category) LIKE '%chef%' THEN 'cooks-chefs'
    WHEN LOWER(category) LIKE '%event%' THEN 'event-planning'
    WHEN LOWER(category) LIKE '%travel%' THEN 'travel-services'
    WHEN LOWER(category) LIKE '%handy%' THEN 'handymen'
    WHEN LOWER(category) LIKE '%auto%' OR LOWER(category) LIKE '%car%' THEN 'auto-services'
    WHEN LOWER(category) LIKE '%personal%' OR LOWER(category) LIKE '%care%' THEN 'personal-care'
    ELSE LOWER(REPLACE(REPLACE(category, ' ', '-'), '&', 'and'))
END
WHERE slug IS NULL;

-- Update existing records with default icon values based on category
UPDATE services
SET icon = CASE
    WHEN slug = 'maid-services' THEN 'home-outline'
    WHEN slug = 'cooks-chefs' THEN 'restaurant-outline'
    WHEN slug = 'event-planning' THEN 'calendar-outline'
    WHEN slug = 'travel-services' THEN 'airplane-outline'
    WHEN slug = 'handymen' THEN 'hammer-outline'
    WHEN slug = 'auto-services' THEN 'car-outline'
    WHEN slug = 'personal-care' THEN 'person-outline'
    ELSE 'star-outline'
END
WHERE icon IS NULL;

-- Update existing records with default color values based on category
UPDATE services
SET color = CASE
    WHEN slug = 'maid-services' THEN '#4A5D23'
    WHEN slug = 'cooks-chefs' THEN '#D97706'
    WHEN slug = 'event-planning' THEN '#7C3AED'
    WHEN slug = 'travel-services' THEN '#0891B2'
    WHEN slug = 'handymen' THEN '#DC2626'
    WHEN slug = 'auto-services' THEN '#1F2937'
    WHEN slug = 'personal-care' THEN '#EC4899'
    ELSE '#6B7280'
END
WHERE color IS NULL;

-- Add default description if missing
UPDATE services
SET description = 'Professional ' || title || ' services'
WHERE description IS NULL OR description = '';

-- Add comment for documentation
COMMENT ON COLUMN services.slug IS 'URL-friendly identifier used for image mapping';
COMMENT ON COLUMN services.icon IS 'Ionicons icon name for UI display';
COMMENT ON COLUMN services.color IS 'Hex color code for service category';
COMMENT ON COLUMN services.call_out_fee IS 'Additional fee for service call-out';
COMMENT ON COLUMN services.min_duration IS 'Minimum service duration in minutes';
COMMENT ON COLUMN services.max_duration IS 'Maximum service duration in minutes';
