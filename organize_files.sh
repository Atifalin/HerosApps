#!/bin/bash

# Set colors for better readability
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Creating directory structure...${NC}"

# Create necessary directories if they don't exist
mkdir -p Homeheros_app/logs
mkdir -p Homeheros_app/docs
mkdir -p Homeheros_app/scripts
mkdir -p Homeheros_app/database/migrations
mkdir -p Homeheros_app/database/seeds

# Move documentation files to docs directory
echo -e "${YELLOW}Moving documentation files to docs directory...${NC}"
mv APPLY_MIGRATION.md Homeheros_app/docs/
mv AUTHENTICATION_SUCCESS.md Homeheros_app/docs/
mv BACKEND_IMPLEMENTATION.md Homeheros_app/docs/
mv CHECK_SUPABASE_AUTH_SETTINGS.md Homeheros_app/docs/
mv CHECK_SUPABASE_STATUS.md Homeheros_app/docs/
mv CURRENT_STATUS_AND_NEXT_STEPS.md Homeheros_app/docs/
mv HEADER_IMPROVEMENTS.md Homeheros_app/docs/
mv LOCAL_IMAGES_UPDATE.md Homeheros_app/docs/
mv LOCAL_SUPABASE_GUIDE.md Homeheros_app/docs/
mv PROJECT_OVERVIEW.md Homeheros_app/docs/
mv SUPABASE_SETUP.md Homeheros_app/docs/
mv SUPABASE_SETUP_GUIDE.md Homeheros_app/docs/
mv Service_details.md Homeheros_app/docs/
mv TESTING_STRATEGY.md Homeheros_app/docs/
mv TEST_SUPABASE.md Homeheros_app/docs/
mv UI_COMPONENTS_SUMMARY.md Homeheros_app/docs/

# Copy logs to the Homeheros_app/logs directory
echo -e "${YELLOW}Copying logs to Homeheros_app/logs directory...${NC}"
cp -r logs/* Homeheros_app/logs/

# Move SQL files to database directories
echo -e "${YELLOW}Moving SQL files to database directories...${NC}"
mv create_auth_tables.sql Homeheros_app/database/migrations/
mv create_essential_tables.sql Homeheros_app/database/migrations/
mv create_test_user.sql Homeheros_app/database/migrations/
mv fix_database.sql Homeheros_app/database/migrations/
mv fix_database_complete.sql Homeheros_app/database/migrations/
mv fix_database_relationships.sql Homeheros_app/database/migrations/
mv fix_booking_columns.sql Homeheros_app/database/migrations/
mv fix_booking_relationships.sql Homeheros_app/database/migrations/
mv fix_booking_status_history.sql Homeheros_app/database/migrations/
mv fix_bookings_permissions.sql Homeheros_app/database/migrations/
mv fix_bookings_table.sql Homeheros_app/database/migrations/
mv fix_heroes_relationship.sql Homeheros_app/database/migrations/
mv fix_heroes_relationship_alt.sql Homeheros_app/database/migrations/
mv fix_heroes_view.sql Homeheros_app/database/migrations/
mv fix_recursive_policies.sql Homeheros_app/database/migrations/
mv fix_scheduled_at.sql Homeheros_app/database/migrations/
mv fix_users_policy.sql Homeheros_app/database/migrations/
mv disable_users_rls.sql Homeheros_app/database/migrations/

# Move seed files to seeds directory
mv seed_complete_data.sql Homeheros_app/database/seeds/
mv seed_complete_data_fixed.sql Homeheros_app/database/seeds/
mv seed_final_data.sql Homeheros_app/database/seeds/
mv seed_final_data_fixed.sql Homeheros_app/database/seeds/
mv seed_final_data_fixed2.sql Homeheros_app/database/seeds/
mv seed_final_data_fixed3.sql Homeheros_app/database/seeds/
mv seed_heroes_data.sql Homeheros_app/database/seeds/
mv seed_heroes_data_updated.sql Homeheros_app/database/seeds/
mv seed_services_data.sql Homeheros_app/database/seeds/
mv seed_services_data_fixed.sql Homeheros_app/database/seeds/
mv seed_services_data_updated.sql Homeheros_app/database/seeds/

# Move utility scripts to scripts directory
echo -e "${YELLOW}Moving utility scripts to scripts directory...${NC}"
mv apply_timestamp_function.sh Homeheros_app/scripts/
mv switch-to-cloud.sh Homeheros_app/scripts/
mv switch-to-local.sh Homeheros_app/scripts/
mv start-dev.sh Homeheros_app/scripts/

# Keep important scripts in root
echo -e "${GREEN}Keeping important scripts in root directory...${NC}"
# backup_database.sh, restore_database.sh, and start_with_backup.sh stay in root

# Create a README file in each directory explaining its purpose
echo -e "${YELLOW}Creating README files in each directory...${NC}"

cat > Homeheros_app/logs/README.md << 'EOL'
# Logs Directory

This directory contains development logs and records of changes made to the HomeHeros application.

Each log file is named with a sequential number and brief description of the changes it documents.
EOL

cat > Homeheros_app/docs/README.md << 'EOL'
# Documentation Directory

This directory contains various documentation files for the HomeHeros application, including:

- Setup guides
- Implementation notes
- Architecture documentation
- Testing strategies
- Project status reports
EOL

cat > Homeheros_app/scripts/README.md << 'EOL'
# Scripts Directory

This directory contains utility scripts for the HomeHeros application, including:

- Development environment setup
- Database management
- Deployment scripts
- Utility functions
EOL

cat > Homeheros_app/database/README.md << 'EOL'
# Database Directory

This directory contains database-related files for the HomeHeros application, organized into:

- `migrations/`: Schema changes and database structure updates
- `seeds/`: Data seeding scripts for development and testing
EOL

cat > Homeheros_app/database/migrations/README.md << 'EOL'
# Migrations Directory

This directory contains database migration scripts that modify the schema structure.

Apply these in sequence to set up or update the database schema.
EOL

cat > Homeheros_app/database/seeds/README.md << 'EOL'
# Seeds Directory

This directory contains data seeding scripts to populate the database with test or initial data.

These scripts can be run after migrations to set up a working environment.
EOL

echo -e "${GREEN}File organization complete!${NC}"
