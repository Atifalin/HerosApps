-- Import data with ID mappings
-- Old test user ID: cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31
-- New test user ID: d4285f89-01eb-42d2-a848-dbc32c7a767b
-- Old hero user ID: 550e8400-e29b-41d4-a716-446655441001
-- New hero user ID: bc784bcc-4db5-4dc1-895b-74b7d19fcd72

-- Insert addresses (update user_id)
INSERT INTO public.addresses (id, user_id, label, line1, line2, city, province, postal_code, lat, lng) VALUES
('df1059b3-ae89-4a32-82f3-7a31c976653f', 'd4285f89-01eb-42d2-a848-dbc32c7a767b', NULL, '123 Main Street', NULL, 'Kelowna', 'BC', 'V1Y 2A3', 49.8801, -119.4436)
ON CONFLICT (id) DO NOTHING;

-- Insert contractors
INSERT INTO public.contractors (id, name, status, contract_terms, gst_number, insurance_doc_url, city_coverage, categories, commission_pct, pricing_floors_json, sla_json, stripe_connect_id, created_at, updated_at) VALUES
('550e8400-e29b-41d4-a716-446655440000', 'CleanPro Services', 'active', NULL, NULL, NULL, '{Kelowna,Vernon}', '{Cleaning,Home}', 15.00, NULL, NULL, NULL, '2025-09-29 17:51:36.202861+00', '2025-09-29 17:51:36.202861+00')
ON CONFLICT (id) DO NOTHING;

-- Insert heros (update user_id)
INSERT INTO public.heros (id, contractor_id, user_id, name, alias, photo_url, skills, categories, rating_avg, rating_count, bio, badges, status, verification_status, availability_json, docs_json, created_at, updated_at) VALUES
('550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440000', 'bc784bcc-4db5-4dc1-895b-74b7d19fcd72', 'Lisa Thompson', 'Lisa T.', NULL, '{Cleaning,Organization}', '{Cleaning}', 4.80, 94, 'Professional cleaner with 5+ years of experience', '{Insured,"Background Check"}', 'active', 'verified', NULL, NULL, '2025-09-29 17:53:32.010359+00', '2025-09-29 18:20:25.38255+00')
ON CONFLICT (id) DO NOTHING;

-- Insert services (using correct column names: title, base_price_cents, city, active)
INSERT INTO public.services (id, title, category, base_price_cents, unit, city, active) VALUES
('a7e4e848-5864-47e4-8ce7-b2ef3735144d', 'Maid Services', 'Cleaning', 5000, 'hour', 'Kelowna', true)
ON CONFLICT (id) DO NOTHING;

-- Insert service_variants (using correct column names)
INSERT INTO public.service_variants (id, service_id, name, description, duration_min, is_active, created_at) VALUES
('435ffb09-41c4-475b-95ab-371c992030a3', 'a7e4e848-5864-47e4-8ce7-b2ef3735144d', 'Deep Cleaning', 'Thorough deep cleaning service', 180, true, '2025-09-29 17:46:00+00')
ON CONFLICT (id) DO NOTHING;

-- Insert bookings (using only columns that exist in the table)
INSERT INTO public.bookings (id, customer_id, contractor_id, hero_id, address_id, scheduled_at, duration_min, status, price_cents, currency, tip_cents, notes, created_at, updated_at, service_id, service_variant_id, service_name, variant_name) VALUES
('51616905-9ae2-40c2-8b2e-de03e0f00549', 'd4285f89-01eb-42d2-a848-dbc32c7a767b', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440001', 'df1059b3-ae89-4a32-82f3-7a31c976653f', '2025-10-15 14:30:00+00', 180, 'requested', 18374, 'CAD', 0, 'Please focus on kitchen and bathrooms', '2025-09-29 18:47:22.543162+00', '2025-09-29 18:47:22.543162+00', 'a7e4e848-5864-47e4-8ce7-b2ef3735144d', '435ffb09-41c4-475b-95ab-371c992030a3', 'Maid Services', 'Deep Cleaning'),
('e82a4c37-c672-4ef7-95ab-5032b2b2e22b', 'd4285f89-01eb-42d2-a848-dbc32c7a767b', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440001', 'df1059b3-ae89-4a32-82f3-7a31c976653f', '2025-09-29 19:27:12.522+00', 180, 'requested', 17372, 'CAD', 0, NULL, '2025-09-29 19:27:12.553636+00', '2025-09-29 19:27:12.553636+00', 'a7e4e848-5864-47e4-8ce7-b2ef3735144d', '435ffb09-41c4-475b-95ab-371c992030a3', 'Maid Services', 'Deep Cleaning'),
('f3fe9b6c-1a28-4e62-85e5-6218f3f2ac87', 'd4285f89-01eb-42d2-a848-dbc32c7a767b', '550e8400-e29b-41d4-a716-446655440000', '550e8400-e29b-41d4-a716-446655440001', 'df1059b3-ae89-4a32-82f3-7a31c976653f', '2025-09-29 19:32:26.89+00', 180, 'requested', 18102, 'CAD', 0, NULL, '2025-09-29 19:32:26.922212+00', '2025-09-29 19:32:26.922212+00', 'a7e4e848-5864-47e4-8ce7-b2ef3735144d', '435ffb09-41c4-475b-95ab-371c992030a3', 'Maid Services', 'Deep Cleaning')
ON CONFLICT (id) DO NOTHING;

-- Insert booking_status_history (update created_by)
INSERT INTO public.booking_status_history (id, booking_id, status, notes, created_by, created_at) VALUES
('309ea213-8fdc-4ab8-99b3-3de304f08363', 'e82a4c37-c672-4ef7-95ab-5032b2b2e22b', 'requested', 'Booking created and payment authorized', 'd4285f89-01eb-42d2-a848-dbc32c7a767b', '2025-09-29 19:27:14.627677+00'),
('b1901849-3f3c-4752-8cc7-180335ebaaef', '51616905-9ae2-40c2-8b2e-de03e0f00549', 'requested', 'Initial status', NULL, '2025-09-29 19:29:58.408407+00'),
('9e53bcbb-e526-457f-bf13-0192e851e9fd', 'f3fe9b6c-1a28-4e62-85e5-6218f3f2ac87', 'requested', 'Booking created and payment authorized', NULL, '2025-09-29 19:32:28.973288+00')
ON CONFLICT (id) DO NOTHING;

-- Insert payments
INSERT INTO public.payments (id, booking_id, stripe_pi, amount_cents, currency, status, captured_at, refunded_cents, refund_reason) VALUES
('e3025605-d444-494a-9dcf-69b6b3f7f1a1', 'e82a4c37-c672-4ef7-95ab-5032b2b2e22b', 'pi_mock_1759174034571', 17372, 'CAD', 'authorized', NULL, 0, NULL),
('d9cb024b-410c-4865-adaf-f036b2c2a7ee', 'f3fe9b6c-1a28-4e62-85e5-6218f3f2ac87', 'pi_mock_1759174348938', 18102, 'CAD', 'authorized', NULL, 0, NULL)
ON CONFLICT (id) DO NOTHING;

-- Insert promo_codes
INSERT INTO public.promo_codes (id, code, name, description, discount_type, discount_value, min_order_amount, max_discount_amount, usage_limit, usage_count, cities, valid_from, valid_until, is_active, created_at) VALUES
('1b15f39c-377e-4714-9b9a-6b088a9111e2', 'WELCOME25', 'Welcome Bonus', 'Get 25% off your first booking with HomeHeros', 'percentage', 25.00, 50.00, NULL, 1000, 0, '{Kamloops,Kelowna,Vernon,Penticton,"West Kelowna","Salmon Arm"}', '2025-09-29 17:49:51.484791+00', '2025-12-31 23:59:59+00', true, '2025-09-29 17:49:51.484791+00')
ON CONFLICT (id) DO NOTHING;

-- Verify data
SELECT 'Profiles' as table_name, COUNT(*) as count FROM public.profiles
UNION ALL
SELECT 'Addresses', COUNT(*) FROM public.addresses
UNION ALL
SELECT 'Contractors', COUNT(*) FROM public.contractors
UNION ALL
SELECT 'Heros', COUNT(*) FROM public.heros
UNION ALL
SELECT 'Services', COUNT(*) FROM public.services
UNION ALL
SELECT 'Service Variants', COUNT(*) FROM public.service_variants
UNION ALL
SELECT 'Bookings', COUNT(*) FROM public.bookings
UNION ALL
SELECT 'Payments', COUNT(*) FROM public.payments
UNION ALL
SELECT 'Promo Codes', COUNT(*) FROM public.promo_codes;
