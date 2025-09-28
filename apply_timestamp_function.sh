#!/bin/bash

echo "Applying server timestamp function to local Supabase..."

# Get the Supabase connection string
CONNECTION_STRING=$(npx supabase db connect --uri)

if [ $? -ne 0 ]; then
  echo "Error: Failed to get Supabase connection string. Make sure Supabase is running."
  exit 1
fi

# Apply the SQL migration
psql "$CONNECTION_STRING" -f supabase/migrations/20250929_add_server_timestamp_function.sql

if [ $? -eq 0 ]; then
  echo "✅ Successfully applied server timestamp function!"
else
  echo "❌ Failed to apply server timestamp function."
  exit 1
fi

echo "You can now test the function by running:"
echo "psql \"$CONNECTION_STRING\" -c \"SELECT get_server_timestamp();\""
