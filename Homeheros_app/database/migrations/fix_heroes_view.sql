-- Drop the existing view
DROP VIEW IF EXISTS heroes;

-- Create a view with proper column mappings
CREATE VIEW heroes AS
SELECT 
  id,
  user_id,
  name,
  alias,
  photo_url,
  rating_avg AS rating,
  rating_count AS review_count,
  status = 'active' AS is_active,
  verification_status = 'verified' AS is_verified,
  skills,
  categories,
  bio,
  badges,
  contractor_id,
  created_at,
  updated_at
FROM heros;
