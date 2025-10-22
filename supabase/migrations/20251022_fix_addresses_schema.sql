-- Fix addresses table schema
-- Migration: 20251022_fix_addresses_schema.sql

-- Add is_default column
ALTER TABLE addresses 
ADD COLUMN IF NOT EXISTS is_default BOOLEAN DEFAULT false;

-- Add street column as alias for line1 (for app compatibility)
ALTER TABLE addresses 
ADD COLUMN IF NOT EXISTS street TEXT;

-- Update street column with line1 data for existing records
UPDATE addresses 
SET street = line1 
WHERE street IS NULL AND line1 IS NOT NULL;

-- Create index on is_default for faster queries
CREATE INDEX IF NOT EXISTS idx_addresses_is_default ON addresses(user_id, is_default) WHERE is_default = true;

-- Add trigger to ensure only one default address per user
CREATE OR REPLACE FUNCTION ensure_single_default_address()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.is_default = true THEN
    -- Unset all other default addresses for this user
    UPDATE addresses 
    SET is_default = false 
    WHERE user_id = NEW.user_id 
    AND id != NEW.id 
    AND is_default = true;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_ensure_single_default_address ON addresses;
CREATE TRIGGER trigger_ensure_single_default_address
  BEFORE INSERT OR UPDATE ON addresses
  FOR EACH ROW
  EXECUTE FUNCTION ensure_single_default_address();

-- Add comment
COMMENT ON COLUMN addresses.is_default IS 'Indicates if this is the users default address';
COMMENT ON COLUMN addresses.street IS 'Street address (alias for line1 for app compatibility)';

-- Show updated structure
SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_name = 'addresses'
ORDER BY ordinal_position;
