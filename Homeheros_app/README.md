# HomeHeros App

HomeHeros is a mobile application that connects homeowners with service providers ("heroes") for various home services like cleaning, repairs, and maintenance.

## 📁 Project Structure

```
Homeheros_app/
├── database/             # Database-related files
│   ├── migrations/       # Schema changes and database structure updates
│   └── seeds/            # Data seeding scripts for development and testing
├── docs/                 # Documentation files
├── logs/                 # Development logs and records of changes
├── scripts/              # Utility scripts
└── src/                  # Source code
    ├── components/       # Reusable UI components
    ├── config/           # Configuration files
    ├── contexts/         # React contexts for state management
    ├── data/             # Static data and mock data
    ├── lib/              # Library code and third-party integrations
    ├── navigation/       # Navigation configuration
    ├── screens/          # Screen components
    ├── services/         # Service layer for API calls
    ├── theme/            # Theme configuration
    └── utils/            # Utility functions
```

## 🚀 Getting Started

### Prerequisites

- Node.js (v18+)
- Expo CLI
- Supabase CLI (for local development)

### Setup

1. Install dependencies:
   ```bash
   npm install
   ```

2. Start the development server:
   ```bash
   npm start
   ```

3. Start Supabase with the latest backup:
   ```bash
   # From the project root directory
   ./start_with_backup.sh
   ```

## 📊 Database Management

### Backup and Restore

- Create a backup:
  ```bash
  # From the project root directory
  ./backup_database.sh
  ```

- Restore from the latest backup:
  ```bash
  # From the project root directory
  ./restore_database.sh
  ```

### Migrations

Database migrations are stored in `database/migrations/`. Apply them in sequence to set up or update the database schema.

### Seeds

Seed data scripts are stored in `database/seeds/`. Use these to populate the database with test or initial data.

## 📝 Documentation

- Development logs are stored in `logs/`
- Technical documentation is stored in `docs/`

## 🔧 Scripts

- `scripts/start-dev.sh`: Start the development environment
- `scripts/switch-to-local.sh`: Switch to local Supabase instance
- `scripts/switch-to-cloud.sh`: Switch to cloud Supabase instance

## 📱 Features

- User authentication
- Service browsing and search
- Booking management
- Real-time status updates
- Payment processing
- Provider ratings and reviews

## 🧪 Testing

Run tests with:
```bash
npm test
```

## 📄 License

This project is proprietary software. All rights reserved.
