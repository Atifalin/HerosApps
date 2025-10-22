#!/bin/bash

# Auth Users Sync Script
# Creates auth.users entries from profiles table for test users

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

PROJECT_REF="vttzuaerdwagipyocpha"
SERVICE_ROLE_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ0dHp1YWVyZHdhZ2lweW9jcGhhIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1ODQ3NzU0MywiZXhwIjoyMDc0MDUzNTQzfQ.yrWidHIlMbZfDxQ3OKcBJieColSjzbJM1A-ok74jvzQ"
CLOUD_URL="https://${PROJECT_REF}.supabase.co"

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Auth Users Sync Script${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

echo -e "${YELLOW}This script will create auth.users for:${NC}"
echo "  - test@test.com (customer)"
echo "  - hero1@example.com (hero)"
echo ""
echo -e "${YELLOW}Default password for all users: Test123!${NC}"
echo ""

read -p "Continue? (y/n) " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

echo ""
echo -e "${YELLOW}Creating auth users...${NC}"

# Function to create user
create_user() {
    local email=$1
    local password=$2
    local user_id=$3
    
    echo "Creating user: $email"
    
    response=$(curl -s -X POST "${CLOUD_URL}/auth/v1/admin/users" \
        -H "apikey: ${SERVICE_ROLE_KEY}" \
        -H "Authorization: Bearer ${SERVICE_ROLE_KEY}" \
        -H "Content-Type: application/json" \
        -d "{
            \"email\": \"${email}\",
            \"password\": \"${password}\",
            \"email_confirm\": true,
            \"user_metadata\": {
                \"role\": \"customer\"
            }
        }")
    
    if echo "$response" | grep -q "error"; then
        echo -e "${RED}Error creating user $email:${NC}"
        echo "$response"
    else
        echo -e "${GREEN}✓ User created: $email${NC}"
    fi
}

# Create test users
create_user "test@test.com" "Test123!" "cc20c42a-2e6e-4ee1-a2dd-02d511fe4f31"
create_user "hero1@example.com" "Test123!" "550e8400-e29b-41d4-a716-446655441001"

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Auth Sync Complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Test credentials:"
echo "  Email: test@test.com"
echo "  Password: Test123!"
echo ""
echo "  Email: hero1@example.com"
echo "  Password: Test123!"
echo ""
echo -e "${YELLOW}Note: The auth.users IDs may differ from profiles IDs${NC}"
echo "You may need to update the profiles table to match the new auth.users IDs"
echo ""
echo "To link profiles to auth users, run this SQL in Supabase Dashboard:"
echo ""
echo "-- Update profile IDs to match auth.users"
echo "UPDATE profiles SET id = (SELECT id FROM auth.users WHERE email = 'test@test.com') WHERE email = 'test@test.com';"
echo "UPDATE profiles SET id = (SELECT id FROM auth.users WHERE email = 'hero1@example.com') WHERE email = 'hero1@example.com';"
echo ""
