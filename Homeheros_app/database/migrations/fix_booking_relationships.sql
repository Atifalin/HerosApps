-- Fix foreign key relationships for bookings table

-- Add foreign key constraints for service_id and service_variant_id
ALTER TABLE bookings 
ADD CONSTRAINT fk_bookings_service 
FOREIGN KEY (service_id) REFERENCES services(id) ON DELETE SET NULL;

ALTER TABLE bookings 
ADD CONSTRAINT fk_bookings_service_variant 
FOREIGN KEY (service_variant_id) REFERENCES service_variants(id) ON DELETE SET NULL;

-- Verify the relationships
SELECT 
    tc.constraint_name, 
    tc.table_name, 
    kcu.column_name, 
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name 
FROM 
    information_schema.table_constraints AS tc 
    JOIN information_schema.key_column_usage AS kcu
      ON tc.constraint_name = kcu.constraint_name
      AND tc.table_schema = kcu.table_schema
    JOIN information_schema.constraint_column_usage AS ccu
      ON ccu.constraint_name = tc.constraint_name
      AND ccu.table_schema = tc.table_schema
WHERE tc.constraint_type = 'FOREIGN KEY' 
  AND tc.table_name = 'bookings'
  AND tc.table_schema = 'public';
