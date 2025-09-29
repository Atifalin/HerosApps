-- Create test users for heroes if they don't exist
INSERT INTO users (id, role, name, email, phone, status)
VALUES
  ('550e8400-e29b-41d4-a716-446655441001', 'hero', 'Lisa Thompson', 'lisa@example.com', '+12505551001', 'active'),
  ('550e8400-e29b-41d4-a716-446655441002', 'hero', 'Michael Johnson', 'michael@example.com', '+12505551002', 'active'),
  ('550e8400-e29b-41d4-a716-446655441003', 'hero', 'Sarah Williams', 'sarah@example.com', '+12505551003', 'active')
ON CONFLICT (id) DO NOTHING;

-- Create test contractor if it doesn't exist
INSERT INTO contractors (id, name, status, city_coverage, categories)
VALUES
  ('550e8400-e29b-41d4-a716-446655440000', 'CleanPro Services', 'active', ARRAY['Kelowna', 'Vernon'], ARRAY['Cleaning', 'Home'])
ON CONFLICT (id) DO NOTHING;

-- Insert heroes
INSERT INTO heros (id, contractor_id, user_id, name, alias, skills, categories, rating_avg, rating_count, bio, badges, status, verification_status)
VALUES
  ('550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655441001', 'Lisa Thompson', 'Lisa T.', ARRAY['Cleaning', 'Organization'], ARRAY['Cleaning'], 4.8, 94, 'Professional cleaner with 5+ years of experience', ARRAY['Insured', 'Background Check'], 'active', 'verified'),
  
  ('550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655441002', 'Michael Johnson', 'Mike J.', ARRAY['Deep Cleaning', 'Sanitization'], ARRAY['Cleaning'], 4.7, 78, 'Specialized in deep cleaning and sanitization', ARRAY['Insured'], 'active', 'verified'),
  
  ('550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655441003', 'Sarah Williams', 'Sarah W.', ARRAY['Cleaning', 'Organization', 'Pet Friendly'], ARRAY['Cleaning', 'Home'], 4.9, 112, 'Experienced in both home cleaning and organization', ARRAY['Insured', 'Background Check', 'Pet Friendly'], 'active', 'verified')
ON CONFLICT (id) DO NOTHING;
