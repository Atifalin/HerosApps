-- Insert mock heroes for testing the booking system

INSERT INTO heroes (id, name, email, phone, rating, review_count, is_active, is_verified) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'Sarah Johnson', 'sarah.johnson@example.com', '+1-250-555-0101', 4.9, 127, true, true),
('550e8400-e29b-41d4-a716-446655440002', 'Mike Chen', 'mike.chen@example.com', '+1-250-555-0102', 4.8, 89, true, true),
('550e8400-e29b-41d4-a716-446655440003', 'Emma Wilson', 'emma.wilson@example.com', '+1-250-555-0103', 4.7, 156, true, true),
('550e8400-e29b-41d4-a716-446655440004', 'David Rodriguez', 'david.rodriguez@example.com', '+1-250-555-0104', 4.6, 203, true, true),
('550e8400-e29b-41d4-a716-446655440005', 'Lisa Thompson', 'lisa.thompson@example.com', '+1-250-555-0105', 4.8, 94, true, true)
ON CONFLICT (id) DO NOTHING;
