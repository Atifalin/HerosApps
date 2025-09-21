-- Create schema for HomeHeros platform
-- Initial migration with core tables based on QRD

-- Enable PostGIS for location-based features
CREATE EXTENSION IF NOT EXISTS postgis;

-- Create enum types for various statuses
CREATE TYPE user_role AS ENUM ('customer', 'hero', 'admin', 'cs', 'finance', 'contractor_manager');
CREATE TYPE booking_status AS ENUM ('requested', 'awaiting_hero_accept', 'enroute', 'arrived', 'in_progress', 'completed', 'rated', 'declined', 'expired', 'cancelled_by_customer', 'cancelled_by_admin', 'reassigned', 'dispute', 'refund_partial', 'refund_full');
CREATE TYPE service_unit AS ENUM ('fixed', 'hourly');
CREATE TYPE promo_type AS ENUM ('amount', 'percent');
CREATE TYPE ratee_type AS ENUM ('hero', 'contractor');

-- Create tables based on ERD from QRD

-- Contractors table
CREATE TABLE contractors (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'pending',
  contract_terms JSONB,
  gst_number TEXT,
  insurance_doc_url TEXT,
  city_coverage TEXT[] NOT NULL DEFAULT '{}',
  categories TEXT[] NOT NULL DEFAULT '{}',
  commission_pct NUMERIC(5, 2) NOT NULL DEFAULT 15.00,
  pricing_floors_json JSONB,
  sla_json JSONB,
  stripe_connect_id TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Users table (extends Supabase auth.users)
CREATE TABLE users (
  id UUID PRIMARY KEY REFERENCES auth.users(id),
  role user_role NOT NULL DEFAULT 'customer',
  name TEXT,
  email TEXT UNIQUE,
  phone TEXT UNIQUE,
  status TEXT NOT NULL DEFAULT 'active',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Heros table
CREATE TABLE heros (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  contractor_id UUID NOT NULL REFERENCES contractors(id),
  user_id UUID NOT NULL REFERENCES users(id),
  name TEXT NOT NULL,
  alias TEXT,
  photo_url TEXT,
  skills TEXT[] DEFAULT '{}',
  categories TEXT[] DEFAULT '{}',
  rating_avg NUMERIC(3, 2) DEFAULT 0,
  rating_count INTEGER DEFAULT 0,
  bio TEXT,
  badges TEXT[] DEFAULT '{}',
  status TEXT NOT NULL DEFAULT 'pending',
  verification_status TEXT NOT NULL DEFAULT 'pending',
  availability_json JSONB,
  docs_json JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Addresses table
CREATE TABLE addresses (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id UUID NOT NULL REFERENCES users(id),
  label TEXT,
  line1 TEXT NOT NULL,
  line2 TEXT,
  city TEXT NOT NULL,
  province TEXT NOT NULL,
  postal_code TEXT NOT NULL,
  lat NUMERIC,
  lng NUMERIC,
  geom GEOGRAPHY(POINT) GENERATED ALWAYS AS (ST_SetSRID(ST_MakePoint(lng, lat), 4326)::geography) STORED
);

-- Services table
CREATE TABLE services (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  category TEXT NOT NULL,
  title TEXT NOT NULL,
  unit service_unit NOT NULL DEFAULT 'fixed',
  base_price_cents INTEGER NOT NULL,
  city TEXT NOT NULL,
  active BOOLEAN NOT NULL DEFAULT true
);

-- Bookings table
CREATE TABLE bookings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  customer_id UUID NOT NULL REFERENCES users(id),
  contractor_id UUID NOT NULL REFERENCES contractors(id),
  hero_id UUID REFERENCES heros(id),
  service_id UUID NOT NULL REFERENCES services(id),
  address_id UUID NOT NULL REFERENCES addresses(id),
  scheduled_at TIMESTAMPTZ NOT NULL,
  duration_min INTEGER NOT NULL,
  status booking_status NOT NULL DEFAULT 'requested',
  price_cents INTEGER NOT NULL,
  currency TEXT NOT NULL DEFAULT 'CAD',
  tip_cents INTEGER DEFAULT 0,
  notes TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- BookingEvents table
CREATE TABLE booking_events (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  booking_id UUID NOT NULL REFERENCES bookings(id),
  type TEXT NOT NULL,
  meta_json JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- GpsPings table
CREATE TABLE gps_pings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  booking_id UUID NOT NULL REFERENCES bookings(id),
  hero_id UUID NOT NULL REFERENCES heros(id),
  lat NUMERIC NOT NULL,
  lng NUMERIC NOT NULL,
  speed NUMERIC,
  ts TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  geom GEOGRAPHY(POINT) GENERATED ALWAYS AS (ST_SetSRID(ST_MakePoint(lng, lat), 4326)::geography) STORED
);

-- Payments table
CREATE TABLE payments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  booking_id UUID NOT NULL REFERENCES bookings(id),
  stripe_pi TEXT,
  amount_cents INTEGER NOT NULL,
  currency TEXT NOT NULL DEFAULT 'CAD',
  status TEXT NOT NULL,
  captured_at TIMESTAMPTZ,
  refunded_cents INTEGER DEFAULT 0,
  refund_reason TEXT
);

-- Payouts table
CREATE TABLE payouts (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  contractor_id UUID NOT NULL REFERENCES contractors(id),
  stripe_transfer_id TEXT,
  amount_cents INTEGER NOT NULL,
  status TEXT NOT NULL,
  period_start TIMESTAMPTZ NOT NULL,
  period_end TIMESTAMPTZ NOT NULL
);

-- Reviews table
CREATE TABLE reviews (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  booking_id UUID NOT NULL REFERENCES bookings(id),
  rater_user_id UUID NOT NULL REFERENCES users(id),
  ratee_type ratee_type NOT NULL,
  ratee_id UUID NOT NULL,
  rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
  comment TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Promos table
CREATE TABLE promos (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  code TEXT NOT NULL UNIQUE,
  type promo_type NOT NULL,
  value NUMERIC NOT NULL,
  city TEXT,
  start_at TIMESTAMPTZ NOT NULL,
  end_at TIMESTAMPTZ NOT NULL,
  max_uses INTEGER,
  used INTEGER DEFAULT 0
);

-- CSNotes table
CREATE TABLE cs_notes (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  subject_type TEXT NOT NULL,
  subject_id UUID NOT NULL,
  author_user_id UUID NOT NULL REFERENCES users(id),
  note TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Create indexes for performance
CREATE INDEX idx_heros_contractor_id ON heros(contractor_id);
CREATE INDEX idx_heros_user_id ON heros(user_id);
CREATE INDEX idx_addresses_user_id ON addresses(user_id);
CREATE INDEX idx_bookings_customer_id ON bookings(customer_id);
CREATE INDEX idx_bookings_contractor_id ON bookings(contractor_id);
CREATE INDEX idx_bookings_hero_id ON bookings(hero_id);
CREATE INDEX idx_bookings_status ON bookings(status);
CREATE INDEX idx_booking_events_booking_id ON booking_events(booking_id);
CREATE INDEX idx_gps_pings_booking_id ON gps_pings(booking_id);
CREATE INDEX idx_gps_pings_hero_id ON gps_pings(hero_id);
CREATE INDEX idx_payments_booking_id ON payments(booking_id);
CREATE INDEX idx_reviews_booking_id ON reviews(booking_id);
CREATE INDEX idx_cs_notes_subject_id ON cs_notes(subject_id);

-- Create spatial indexes for location queries
CREATE INDEX idx_addresses_geom ON addresses USING GIST(geom);
CREATE INDEX idx_gps_pings_geom ON gps_pings USING GIST(geom);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply updated_at trigger to relevant tables
CREATE TRIGGER update_contractors_updated_at
BEFORE UPDATE ON contractors
FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_heros_updated_at
BEFORE UPDATE ON heros
FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_bookings_updated_at
BEFORE UPDATE ON bookings
FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- Create booking event trigger
CREATE OR REPLACE FUNCTION create_booking_event()
RETURNS TRIGGER AS $$
BEGIN
  IF OLD.status IS NULL OR NEW.status != OLD.status THEN
    INSERT INTO booking_events (booking_id, type, meta_json)
    VALUES (NEW.id, 'status_change', jsonb_build_object('from', OLD.status, 'to', NEW.status));
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER booking_status_change
AFTER UPDATE ON bookings
FOR EACH ROW
WHEN (OLD.status IS NULL OR NEW.status != OLD.status)
EXECUTE FUNCTION create_booking_event();

-- Create hero rating update trigger
CREATE OR REPLACE FUNCTION update_hero_rating()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.ratee_type = 'hero' THEN
    UPDATE heros
    SET 
      rating_count = rating_count + 1,
      rating_avg = (rating_avg * rating_count + NEW.rating) / (rating_count + 1)
    WHERE id = NEW.ratee_id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER hero_rating_update
AFTER INSERT ON reviews
FOR EACH ROW
WHEN (NEW.ratee_type = 'hero')
EXECUTE FUNCTION update_hero_rating();

-- Set up Row Level Security (RLS) policies

-- Enable RLS on all tables
ALTER TABLE contractors ENABLE ROW LEVEL SECURITY;
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE heros ENABLE ROW LEVEL SECURITY;
ALTER TABLE addresses ENABLE ROW LEVEL SECURITY;
ALTER TABLE services ENABLE ROW LEVEL SECURITY;
ALTER TABLE bookings ENABLE ROW LEVEL SECURITY;
ALTER TABLE booking_events ENABLE ROW LEVEL SECURITY;
ALTER TABLE gps_pings ENABLE ROW LEVEL SECURITY;
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE payouts ENABLE ROW LEVEL SECURITY;
ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;
ALTER TABLE promos ENABLE ROW LEVEL SECURITY;
ALTER TABLE cs_notes ENABLE ROW LEVEL SECURITY;

-- Create basic policies (these will be expanded in future migrations)

-- Users can read their own data
CREATE POLICY users_read_own ON users
  FOR SELECT USING (auth.uid() = id);

-- Customers can read hero profiles
CREATE POLICY customers_read_heros ON heros
  FOR SELECT USING (true);

-- Customers can read their own addresses
CREATE POLICY customers_read_own_addresses ON addresses
  FOR SELECT USING (auth.uid() = user_id);

-- Customers can create addresses
CREATE POLICY customers_create_addresses ON addresses
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Customers can read services
CREATE POLICY customers_read_services ON services
  FOR SELECT USING (true);

-- Customers can read their own bookings
CREATE POLICY customers_read_own_bookings ON bookings
  FOR SELECT USING (auth.uid() = customer_id);

-- Heros can read bookings assigned to them
CREATE POLICY heros_read_assigned_bookings ON bookings
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM users
      WHERE users.id = auth.uid()
      AND users.role = 'hero'
      AND EXISTS (
        SELECT 1 FROM heros
        WHERE heros.user_id = auth.uid()
        AND heros.id = bookings.hero_id
      )
    )
  );

-- Create admin policies (admins can do everything)
CREATE POLICY admin_all ON contractors FOR ALL USING (
  EXISTS (
    SELECT 1 FROM users
    WHERE users.id = auth.uid()
    AND users.role IN ('admin', 'cs', 'finance')
  )
);

CREATE POLICY admin_all ON users FOR ALL USING (
  EXISTS (
    SELECT 1 FROM users
    WHERE users.id = auth.uid()
    AND users.role IN ('admin', 'cs', 'finance')
  )
);

CREATE POLICY admin_all ON heros FOR ALL USING (
  EXISTS (
    SELECT 1 FROM users
    WHERE users.id = auth.uid()
    AND users.role IN ('admin', 'cs', 'finance')
  )
);

CREATE POLICY admin_all ON bookings FOR ALL USING (
  EXISTS (
    SELECT 1 FROM users
    WHERE users.id = auth.uid()
    AND users.role IN ('admin', 'cs', 'finance')
  )
);

-- Create storage buckets
INSERT INTO storage.buckets (id, name, public) VALUES ('avatars', 'avatars', true);
INSERT INTO storage.buckets (id, name, public) VALUES ('documents', 'documents', false);
INSERT INTO storage.buckets (id, name, public) VALUES ('booking_photos', 'booking_photos', false);

-- Set up storage policies
CREATE POLICY avatars_select_policy ON storage.objects
  FOR SELECT USING (bucket_id = 'avatars');

CREATE POLICY documents_auth_only ON storage.objects
  FOR SELECT USING (
    bucket_id = 'documents' AND (
      EXISTS (
        SELECT 1 FROM users
        WHERE users.id = auth.uid()
        AND users.role IN ('admin', 'cs', 'finance', 'contractor_manager')
      )
    )
  );

CREATE POLICY booking_photos_participants ON storage.objects
  FOR SELECT USING (
    bucket_id = 'booking_photos' AND (
      EXISTS (
        SELECT 1 FROM bookings
        WHERE bookings.id::text = (storage.foldername(name))[1]
        AND (
          bookings.customer_id = auth.uid() OR
          EXISTS (
            SELECT 1 FROM heros
            WHERE heros.id = bookings.hero_id
            AND heros.user_id = auth.uid()
          ) OR
          EXISTS (
            SELECT 1 FROM users
            WHERE users.id = auth.uid()
            AND users.role IN ('admin', 'cs', 'finance')
          )
        )
      )
    )
  );
