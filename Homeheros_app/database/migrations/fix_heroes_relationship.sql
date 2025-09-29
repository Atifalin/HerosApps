-- Fix the relationship between bookings and heros
-- The app is looking for 'heroes' but the table is named 'heros'

-- Create a view to alias heros as heroes
CREATE OR REPLACE VIEW heroes AS
SELECT * FROM heros;

-- Add comment to the view
COMMENT ON VIEW heroes IS 'View that aliases the heros table to heroes for compatibility with app code';

-- Check if we need to fix the query in BookingStatusScreen.tsx
DO $$
BEGIN
  -- Check if the foreign key constraint exists with the correct name
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'fk_bookings_hero') THEN
    -- If the constraint doesn't exist with that name, try to create it
    IF EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'bookings_hero_id_fkey') THEN
      -- Rename the existing constraint
      ALTER TABLE bookings RENAME CONSTRAINT bookings_hero_id_fkey TO fk_bookings_hero;
    ELSE
      -- Create the constraint if it doesn't exist at all
      BEGIN
        ALTER TABLE bookings ADD CONSTRAINT fk_bookings_hero FOREIGN KEY (hero_id) REFERENCES heros(id);
      EXCEPTION WHEN duplicate_object THEN
        -- Constraint already exists with a different name
        NULL;
      END;
    END IF;
  END IF;
END
$$;
