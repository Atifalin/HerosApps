# HomeHeros Supabase Backend

This directory contains the Supabase configuration and setup for the HomeHeros platform.

## Overview

Supabase provides a complete backend solution for the HomeHeros platform, including:

- Authentication and user management
- PostgreSQL database
- Storage for files and media
- Realtime subscriptions
- Edge Functions for serverless computing

## Getting Started

### Prerequisites

- Node.js 18+
- Yarn or npm
- Supabase CLI
- Docker (for local development)

### Installation

1. Install the Supabase CLI:

```bash
npm install -g supabase
```

2. Install project dependencies:

```bash
yarn install
```

3. Start the local Supabase instance:

```bash
supabase start
```

4. Initialize the project (if not already done):

```bash
supabase init
```

### Configuration

1. Copy the `.env.example` file to `.env`:

```bash
cp .env.example .env
```

2. Update the environment variables with your Supabase project details.

## Project Structure

```
/supabase
├── .gitignore
├── README.md
├── package.json
├── supabase
│   ├── config.toml                  # Supabase configuration
│   ├── seed.sql                     # Initial seed data
│   └── .env.example                 # Environment variables template
├── migrations/                      # Database migrations
│   ├── 20250101000000_initial.sql
│   └── ...
├── functions/                       # Edge Functions
│   ├── stripe/
│   │   ├── create-payment-intent.ts
│   │   ├── process-refund.ts
│   │   └── create-transfer.ts
│   ├── notifications/
│   │   ├── send-push.ts
│   │   ├── send-email.ts
│   │   └── send-sms.ts
│   └── webhooks/
│       ├── stripe-webhook.ts
│       └── notification-webhook.ts
├── database/
│   ├── schema/                      # Table definitions
│   │   ├── public/
│   │   │   ├── users.sql
│   │   │   ├── contractors.sql
│   │   │   ├── heros.sql
│   │   │   ├── bookings.sql
│   │   │   └── ...
│   ├── functions/                   # PostgreSQL functions
│   │   ├── match_hero.sql
│   │   ├── calculate_eta.sql
│   │   └── ...
│   ├── triggers/                    # Database triggers
│   │   ├── booking_state_change.sql
│   │   ├── rating_update.sql
│   │   └── ...
│   ├── views/                       # Database views
│   │   ├── hero_availability.sql
│   │   ├── booking_timeline.sql
│   │   └── revenue_report.sql
│   └── policies/                    # Row Level Security policies
│       ├── users_policy.sql
│       ├── bookings_policy.sql
│       └── ...
├── storage/                         # Storage bucket configurations
│   ├── avatars.sql
│   ├── documents.sql
│   ├── booking_photos.sql
│   └── ...
└── tests/
    ├── database/                    # Database tests
    │   ├── functions/
    │   ├── triggers/
    │   └── policies/
    └── functions/                   # Edge Function tests
        ├── stripe/
        ├── notifications/
        └── webhooks/
```

## Development Workflow

### Database Migrations

1. Create a new migration:

```bash
supabase migration new <migration_name>
```

2. Apply migrations:

```bash
supabase db push
```

### Edge Functions

1. Create a new Edge Function:

```bash
supabase functions new <function_name>
```

2. Deploy an Edge Function:

```bash
supabase functions deploy <function_name>
```

3. Test an Edge Function locally:

```bash
supabase functions serve <function_name> --no-verify-jwt
```

### Database Schema

1. Apply schema changes:

```bash
supabase db push
```

2. Reset the database (caution: this will delete all data):

```bash
supabase db reset
```

## Deployment

### Staging

1. Link to your staging Supabase project:

```bash
supabase link --project-ref <staging_project_id>
```

2. Push changes to staging:

```bash
supabase db push
supabase functions deploy
```

### Production

1. Link to your production Supabase project:

```bash
supabase link --project-ref <production_project_id>
```

2. Push changes to production:

```bash
supabase db push
supabase functions deploy
```

## Testing

Run tests:

```bash
yarn test
```

## Additional Resources

- [Supabase Documentation](https://supabase.io/docs)
- [Supabase CLI Reference](https://supabase.io/docs/reference/cli)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
