-- Create a simple function to get the server timestamp
-- This can be used to test the connection to Supabase
CREATE OR REPLACE FUNCTION get_server_timestamp()
RETURNS TIMESTAMP WITH TIME ZONE
LANGUAGE SQL
SECURITY DEFINER
AS $$
  SELECT NOW();
$$;
