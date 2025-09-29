-- Fix the relationship between bookings and heros
-- The app is looking for 'heroes' but the table is named 'heros'

-- Drop the view if it exists
DROP VIEW IF EXISTS heroes;

-- Create a view to alias heros as heroes
CREATE VIEW heroes AS
SELECT * FROM heros;

-- Add comment to the view
COMMENT ON VIEW heroes IS 'View that aliases the heros table to heroes for compatibility with app code';
