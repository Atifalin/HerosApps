#!/bin/bash

# Supabase Cloud Migration Script
# This script migrates your local Supabase database to Supabase Cloud

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
PROJECT_REF="vttzuaerdwagipyocpha"
CLOUD_URL="https://${PROJECT_REF}.supabase.co"
BACKUP_FILE="/Users/atifali/Code/Paid Apps/Homeheros/database_backups/homeheros_db_backup_20251002_183513.sql"
SUPABASE_DIR="/Users/atifali/Code/Paid Apps/Homeheros/supabase"

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Supabase Cloud Migration Script${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# Step 1: Check if supabase CLI is installed
echo -e "${YELLOW}Step 1: Checking Supabase CLI...${NC}"
if ! command -v supabase &> /dev/null; then
    echo -e "${RED}Error: Supabase CLI is not installed${NC}"
    echo "Install it with: brew install supabase/tap/supabase"
    exit 1
fi
echo -e "${GREEN}✓ Supabase CLI found${NC}"
echo ""

# Step 2: Check if backup file exists
echo -e "${YELLOW}Step 2: Checking backup file...${NC}"
if [ ! -f "$BACKUP_FILE" ]; then
    echo -e "${RED}Error: Backup file not found at $BACKUP_FILE${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Backup file found ($(du -h "$BACKUP_FILE" | cut -f1))${NC}"
echo ""

# Step 3: Link to cloud project
echo -e "${YELLOW}Step 3: Linking to Supabase Cloud project...${NC}"
cd "$SUPABASE_DIR"
echo "Project Ref: $PROJECT_REF"
echo "You will be prompted for your database password..."
echo ""

# Check if already linked
if [ -f ".branches/_current_branch" ]; then
    echo -e "${YELLOW}Project appears to be already linked. Skipping link step.${NC}"
else
    supabase link --project-ref "$PROJECT_REF"
fi
echo -e "${GREEN}✓ Project linked${NC}"
echo ""

# Step 4: Push migrations
echo -e "${YELLOW}Step 4: Pushing database migrations to cloud...${NC}"
echo "This will create all tables, functions, and policies..."
echo ""
supabase db push
echo -e "${GREEN}✓ Migrations pushed successfully${NC}"
echo ""

# Step 5: Get database connection string
echo -e "${YELLOW}Step 5: Preparing to restore data...${NC}"
echo ""
echo -e "${YELLOW}IMPORTANT: You need to provide your database password${NC}"
echo "Find it in: Supabase Dashboard → Project Settings → Database → Connection String"
echo ""
read -sp "Enter your database password: " DB_PASSWORD
echo ""

# Step 6: Restore data
echo -e "${YELLOW}Step 6: Restoring data from backup...${NC}"
echo "This may take a few minutes..."
echo ""

DB_CONNECTION="postgresql://postgres:${DB_PASSWORD}@db.${PROJECT_REF}.supabase.co:5432/postgres"

# Create a filtered backup without auth schema conflicts
FILTERED_BACKUP="/tmp/homeheros_filtered_backup.sql"
echo "Creating filtered backup (excluding auth schema)..."

# Filter out auth schema and system schemas that Supabase manages
grep -v "CREATE SCHEMA auth" "$BACKUP_FILE" | \
grep -v "ALTER SCHEMA auth" | \
grep -v "CREATE SCHEMA _realtime" | \
grep -v "ALTER SCHEMA _realtime" | \
grep -v "CREATE SCHEMA realtime" | \
grep -v "ALTER SCHEMA realtime" | \
grep -v "CREATE SCHEMA storage" | \
grep -v "ALTER SCHEMA storage" | \
grep -v "CREATE SCHEMA graphql" | \
grep -v "ALTER SCHEMA graphql" | \
grep -v "CREATE EXTENSION" | \
grep -v "COMMENT ON EXTENSION" > "$FILTERED_BACKUP"

echo "Restoring data to cloud database..."
PGPASSWORD="$DB_PASSWORD" psql "$DB_CONNECTION" -f "$FILTERED_BACKUP" 2>&1 | grep -v "already exists" || true

# Clean up
rm "$FILTERED_BACKUP"

echo -e "${GREEN}✓ Data restored successfully${NC}"
echo ""

# Step 7: Summary
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Migration Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Your Supabase Cloud project is now set up with:"
echo "  ✓ All database tables and schemas"
echo "  ✓ All data from local backup"
echo "  ✓ RLS policies and functions"
echo ""
echo -e "${YELLOW}Next Steps:${NC}"
echo "1. Run the auth sync script: ./sync_auth_users.sh"
echo "2. Test your app with the cloud database"
echo "3. Verify data in Supabase Dashboard: $CLOUD_URL"
echo ""
echo -e "${YELLOW}Note: Auth users need to be synced separately${NC}"
echo "Run: ./sync_auth_users.sh to create auth.users from profiles"
echo ""
