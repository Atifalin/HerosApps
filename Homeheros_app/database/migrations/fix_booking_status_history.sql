-- Make created_by nullable
ALTER TABLE booking_status_history ALTER COLUMN created_by DROP NOT NULL;

-- Make sure we can insert a status history record
INSERT INTO booking_status_history (booking_id, status, notes)
SELECT id, status, 'Initial status' FROM bookings LIMIT 1;
