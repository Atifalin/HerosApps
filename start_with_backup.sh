#!/bin/bash

# Set colors for better readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Starting Supabase services...${NC}"
npx supabase start

# Check if Supabase started successfully
if [ $? -ne 0 ]; then
  echo -e "${RED}Failed to start Supabase services. Exiting.${NC}"
  exit 1
fi

echo -e "${GREEN}Supabase services started successfully!${NC}"

# Find the latest backup file
BACKUP_DIR="/Users/atifali/Code/Paid Apps/Homeheros/database_backups"
LATEST_BACKUP=$(ls -t "$BACKUP_DIR"/homeheros_db_backup_*.sql 2>/dev/null | head -n 1)

if [ -z "$LATEST_BACKUP" ]; then
  echo -e "${YELLOW}No backup files found in $BACKUP_DIR. Skipping restoration.${NC}"
else
  echo -e "${YELLOW}Found latest backup: $LATEST_BACKUP${NC}"
  echo -e "${YELLOW}Size: $(du -h "$LATEST_BACKUP" | cut -f1)${NC}"
  
  # Wait for PostgreSQL to be fully ready
  echo -e "${YELLOW}Waiting for PostgreSQL to be ready...${NC}"
  sleep 5
  
  # Attempt to restore from backup
  echo -e "${YELLOW}Restoring database from backup...${NC}"
  psql "postgresql://postgres:postgres@127.0.0.1:54322/postgres" < "$LATEST_BACKUP"
  
  if [ $? -eq 0 ]; then
    echo -e "${GREEN}Database restored successfully from backup!${NC}"
  else
    echo -e "${RED}Failed to restore database from backup.${NC}"
    exit 1
  fi
  
  # Apply fixes
  echo -e "${YELLOW}Applying database fixes...${NC}"
  
  if [ -f "fix_database_complete.sql" ]; then
    echo -e "${YELLOW}Applying fix_database_complete.sql...${NC}"
    psql "postgresql://postgres:postgres@127.0.0.1:54322/postgres" -f fix_database_complete.sql
  fi
  
  if [ -f "fix_recursive_policies.sql" ]; then
    echo -e "${YELLOW}Applying fix_recursive_policies.sql...${NC}"
    psql "postgresql://postgres:postgres@127.0.0.1:54322/postgres" -f fix_recursive_policies.sql
  fi
  
  if [ -f "fix_scheduled_at.sql" ]; then
    echo -e "${YELLOW}Applying fix_scheduled_at.sql...${NC}"
    psql "postgresql://postgres:postgres@127.0.0.1:54322/postgres" -f fix_scheduled_at.sql
  fi
  
  echo -e "${GREEN}All fixes applied!${NC}"
fi

# Start the app
echo -e "${YELLOW}Starting Expo development server...${NC}"
cd Homeheros_app && npx expo start --ios

echo -e "${GREEN}Environment is ready!${NC}"
