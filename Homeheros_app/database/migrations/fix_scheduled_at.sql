-- Make the scheduled_at column nullable
ALTER TABLE bookings ALTER COLUMN scheduled_at DROP NOT NULL;

-- Make sure we can insert a booking with a current timestamp
DO $$
BEGIN
  -- Try to insert a test booking
  INSERT INTO bookings (
    customer_id, 
    service_id,
    service_name,
    status,
    scheduled_at,
    duration_min,
    price_cents,
    currency
  ) VALUES (
    'cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31',
    'a7e4e848-5864-47e4-8ce7-b2ef3735144d',
    'Test Service',
    'requested',
    NOW(),
    60,
    10000,
    'CAD'
  );
  
  -- Clean up the test booking
  DELETE FROM bookings WHERE service_name = 'Test Service';
END
$$;
