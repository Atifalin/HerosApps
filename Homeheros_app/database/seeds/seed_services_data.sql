-- Seed essential data for HomeHeros booking system

-- Insert Services
INSERT INTO services (id, name, slug, description, icon, color, call_out_fee, min_duration, max_duration) VALUES
('maid-services', 'Maid Services', 'maid-services', 'Professional Cleaning', 'home-outline', '#4A5D23', 0, 120, 480),
('cooks-chefs', 'Cooks & Chefs', 'cooks-chefs', 'Personal Chef Services', 'restaurant-outline', '#FF6B35', 0, 120, 480),
('event-planning', 'Event Planning', 'event-planning', 'Complete Event Management', 'calendar-outline', '#6C5CE7', 0, 240, 720),
('travel-services', 'Travel Services', 'travel-services', 'Tour Guides & Travel', 'airplane-outline', '#00B894', 0, 240, 720),
('handymen', 'Handymen', 'handymen', 'Home Improvements', 'build-outline', '#FDCB6E', 65, 60, 480),
('auto-services', 'Auto Services', 'auto-services', 'Repair & Detailing', 'car-outline', '#E84393', 150, 120, 480),
('personal-care', 'Personal Care', 'personal-care', 'Massage & Salon at Home', 'flower-outline', '#A29BFE', 0, 60, 240)
ON CONFLICT (id) DO NOTHING;

-- Insert Service Variants (Subcategories)
INSERT INTO service_variants (service_id, name, slug, description, base_price, default_duration) VALUES
-- Maid Services
('maid-services', 'Deep Cleaning', 'deep-cleaning', 'Complete home cleaning service', 250.00, 240),
('maid-services', 'Regular Cleaning', 'regular-cleaning', 'Weekly/bi-weekly maintenance cleaning', 150.00, 180),
('maid-services', 'Move In/Out Cleaning', 'move-in-out', 'Thorough cleaning for moving', 300.00, 300),
('maid-services', 'Swimming Pool Cleaning', 'pool-cleaning', 'Pool cleaning service', 500.00, 120),

-- Cooks & Chefs
('cooks-chefs', 'Home Cooking', 'home-cooking', 'Daily meals tailored to your taste & diet', 75.00, 180),
('cooks-chefs', 'Meal Prep', 'meal-prep', 'Weekly meal preparation service', 200.00, 240),
('cooks-chefs', 'Special Event Catering', 'special-events', 'Private chef for special occasions', 150.00, 300),

-- Event Planning
('event-planning', 'Birthday Parties', 'birthday-parties', 'Complete birthday party planning', 500.00, 360),
('event-planning', 'Corporate Events', 'corporate-events', 'Professional corporate event planning', 800.00, 480),
('event-planning', 'Wedding Planning', 'weddings', 'Full wedding planning service', 1500.00, 720),

-- Travel Services
('travel-services', 'City Tours', 'city-tours', 'Guided city exploration', 100.00, 240),
('travel-services', 'Adventure Tours', 'adventure-tours', 'Outdoor adventure experiences', 150.00, 360),
('travel-services', 'Travel Planning', 'travel-planning', 'Complete travel itinerary planning', 200.00, 120),

-- Handymen
('handymen', 'Repairs & Installs', 'repairs-installs', 'Fixtures, furniture assembly, shelves', 65.00, 120),
('handymen', 'Electrical', 'electrical', 'Switches, fans, lighting, smart home', 65.00, 90),
('handymen', 'Plumbing', 'plumbing', 'Drains, toilet repairs, shower fittings', 65.00, 120),
('handymen', 'Painting', 'painting', 'Interior and exterior painting', 65.00, 240),

-- Auto Services
('auto-services', 'Mobile Detailing', 'mobile-detailing', 'Complete car detailing at your location', 150.00, 180),
('auto-services', 'Mobile Repair', 'mobile-repair', 'On-site automotive repairs', 150.00, 240),
('auto-services', 'Maintenance', 'maintenance', 'Regular vehicle maintenance', 150.00, 120),

-- Personal Care
('personal-care', 'Massage Therapy', 'massage-therapy', 'Professional massage at home', 120.00, 90),
('personal-care', 'Hair Styling', 'hair-styling', 'Professional hair styling at home', 80.00, 120),
('personal-care', 'Beauty Services', 'beauty-services', 'Makeup, nails, and beauty treatments', 100.00, 90)
ON CONFLICT (service_id, slug) DO NOTHING;

-- Insert Add-ons
INSERT INTO add_ons (service_id, name, description, price, category) VALUES
-- Maid Services Add-ons
('maid-services', 'Fridge Cleaning', 'Deep clean inside and outside of refrigerator', 50.00, 'kitchen'),
('maid-services', 'Oven Cleaning', 'Deep clean oven interior and exterior', 75.00, 'kitchen'),
('maid-services', 'Garage Cleaning', 'Sweep and organize garage space', 75.00, 'exterior'),
('maid-services', 'Basement Cleaning', 'Clean and organize basement area', 100.00, 'interior'),
('maid-services', 'Window Cleaning', 'Clean interior and exterior windows', 60.00, 'windows'),

-- Handymen Add-ons
('handymen', 'Additional Outlet Installation', 'Install additional electrical outlet', 150.00, 'electrical'),
('handymen', 'Light Fixture Installation', 'Install new light fixture', 100.00, 'electrical'),
('handymen', 'Furniture Assembly', 'Assemble furniture pieces', 80.00, 'assembly'),

-- Cooks & Chefs Add-ons
('cooks-chefs', 'Grocery Shopping', 'Purchase ingredients for meal preparation', 25.00, 'preparation'),
('cooks-chefs', 'Meal Prep Service', 'Prepare multiple meals for the week', 150.00, 'preparation'),
('cooks-chefs', 'Special Diet Accommodation', 'Accommodate special dietary requirements', 50.00, 'customization')
ON CONFLICT DO NOTHING;

-- Insert Sample Promo Codes
INSERT INTO promo_codes (code, name, description, discount_type, discount_value, min_order_amount, usage_limit, cities, valid_until) VALUES
('WELCOME25', 'Welcome Bonus', 'Get 25% off your first booking with HomeHeros', 'percentage', 25.00, 50.00, 1000, ARRAY['Kamloops', 'Kelowna', 'Vernon', 'Penticton', 'West Kelowna', 'Salmon Arm'], '2025-12-31 23:59:59+00'),
('CLEAN15', 'Cleaning Special', '15% off any cleaning service this month', 'percentage', 15.00, 100.00, 500, ARRAY['Kamloops', 'Kelowna', 'Vernon', 'Penticton', 'West Kelowna', 'Salmon Arm'], '2025-10-31 23:59:59+00'),
('REFER10', 'Refer a Friend', 'Get $10 credit when you refer a friend', 'fixed_amount', 10.00, 0.00, NULL, ARRAY['Kamloops', 'Kelowna', 'Vernon', 'Penticton', 'West Kelowna', 'Salmon Arm'], NULL)
ON CONFLICT (code) DO NOTHING;
