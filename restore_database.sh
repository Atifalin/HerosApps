#!/bin/bash

# Set colors for better readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if Supabase is running
SUPABASE_RUNNING=$(docker ps | grep supabase | wc -l)

if [ "$SUPABASE_RUNNING" -eq 0 ]; then
  echo -e "${YELLOW}Supabase is not running. Starting Supabase services...${NC}"
  npx supabase start
  
  # Check if Supabase started successfully
  if [ $? -ne 0 ]; then
    echo -e "${RED}Failed to start Supabase services. Exiting.${NC}"
    exit 1
  fi
  
  echo -e "${GREEN}Supabase services started successfully!${NC}"
  
  # Wait for PostgreSQL to be fully ready
  echo -e "${YELLOW}Waiting for PostgreSQL to be ready...${NC}"
  sleep 5
else
  echo -e "${GREEN}Supabase is already running.${NC}"
fi

# Find the latest backup file
BACKUP_DIR="/Users/atifali/Code/Paid Apps/Homeheros/database_backups"
LATEST_BACKUP=$(ls -t "$BACKUP_DIR"/homeheros_db_backup_*.sql 2>/dev/null | head -n 1)

if [ -z "$LATEST_BACKUP" ]; then
  echo -e "${RED}No backup files found in $BACKUP_DIR. Exiting.${NC}"
  exit 1
fi

echo -e "${YELLOW}Found latest backup: $LATEST_BACKUP${NC}"
echo -e "${YELLOW}Size: $(du -h "$LATEST_BACKUP" | cut -f1)${NC}"

# Ask for confirmation
read -p "Do you want to restore the database from this backup? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo -e "${YELLOW}Restoration cancelled.${NC}"
  exit 0
fi

# Attempt to restore from backup
echo -e "${YELLOW}Restoring database from backup...${NC}"
psql "postgresql://postgres:postgres@127.0.0.1:54322/postgres" < "$LATEST_BACKUP"

if [ $? -eq 0 ]; then
  echo -e "${GREEN}Database restored successfully from backup!${NC}"
else
  echo -e "${RED}Failed to restore database from backup.${NC}"
  exit 1
fi

# Ask if user wants to apply fixes
read -p "Do you want to apply database fixes? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
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

echo -e "${GREEN}Database restoration complete!${NC}"
echo -e "${YELLOW}You can now start your application with: cd Homeheros_app && npx expo start --ios${NC}"
