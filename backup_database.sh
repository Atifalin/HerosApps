#!/bin/bash

# Set the backup directory
BACKUP_DIR="/Users/atifali/Code/Paid Apps/Homeheros/database_backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/homeheros_db_backup_$TIMESTAMP.sql"

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Create a database backup
echo "Creating database backup..."
pg_dump "postgresql://postgres:postgres@127.0.0.1:54322/postgres" > "$BACKUP_FILE"

# Check if backup was successful
if [ $? -eq 0 ]; then
  echo "Database backup created successfully at: $BACKUP_FILE"
  echo "Size: $(du -h "$BACKUP_FILE" | cut -f1)"
else
  echo "Error: Database backup failed"
  exit 1
fi

echo "Backup completed successfully!"
