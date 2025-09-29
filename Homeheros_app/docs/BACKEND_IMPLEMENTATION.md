# HomeHeros Backend Implementation Plan with Supabase

## Overview
The HomeHeros backend leverages Supabase to provide authentication, database, storage, and realtime features for all three applications (Customer App, Provider App, and Admin Portal). This approach significantly reduces development time by using Supabase's ready-made services while maintaining the flexibility to extend functionality with Edge Functions.

## Technical Specifications

- **Platform**: Supabase
- **Database**: PostgreSQL (managed by Supabase)
- **Authentication**: Supabase Auth
- **Storage**: Supabase Storage
- **Serverless Functions**: Supabase Edge Functions
- **Realtime**: Supabase Realtime
- **API Style**: REST and Realtime subscriptions

## Implementation Phases

### Phase 1: Supabase Setup & Configuration (Week 1)

#### Tasks:
1. Create Supabase project and configure settings
2. Design and implement database schema using Supabase interface
3. Configure authentication settings
   - Email/phone authentication
   - OAuth providers (Google, Apple)
   - Role-based access control with Row Level Security (RLS)
4. Set up storage buckets with appropriate permissions
5. Configure Supabase realtime features
6. Set up monitoring and logging

#### Deliverables:
- Configured Supabase project
- Database schema with RLS policies
- Authentication system with multiple providers
- Storage buckets with proper permissions
- Monitoring and logging setup

### Phase 2: Database Schema & API Development (Weeks 2-3)

#### Tasks:
1. Implement city and category tables with seed data
2. Create Hero discovery views and stored procedures
3. Develop booking tables and RLS policies
   - Booking states and transitions using PostgreSQL enums
   - Hero matching algorithm as PostgreSQL functions
   - Booking events tracking with triggers
4. Implement address and location tables
5. Create contractor and Hero management tables with RLS
6. Set up availability management using JSON or dedicated tables

#### Deliverables:
- Complete database schema with relationships
- PostgreSQL functions for core business logic
- RLS policies for security
- Views for efficient data access
- Database triggers for event tracking

### Phase 3: Edge Functions & External Integrations (Week 4)

#### Tasks:
1. Develop Edge Functions for Stripe integration
   - Payment intents creation
   - Payment method storage
   - Capture and refunds
2. Implement Edge Functions for Stripe Connect contractor payouts
3. Create notification Edge Functions
   - Push notifications via Expo
   - Email notifications
   - SMS notifications
4. Set up webhook handlers as Edge Functions
5. Implement rating and review system with triggers

#### Deliverables:
- Stripe integration via Edge Functions
- Contractor payout system
- Notification system using Edge Functions
- Webhook handlers
- Rating and review system with triggers

### Phase 4: Realtime Features & Media Handling (Week 5)

#### Tasks:
1. Configure Supabase realtime subscriptions
   - Booking state changes
   - Hero location updates
   - Notification delivery
2. Implement media storage and processing
   - Supabase Storage configuration
   - Image optimization with transformations
   - Document storage with access controls
3. Create GPS tracking system
   - Location data processing with PostGIS
   - ETA calculation using PostgreSQL functions
4. Implement reporting data aggregation with views and materialized views

#### Deliverables:
- Realtime subscription configurations
- Media storage system with Supabase Storage
- GPS tracking system with PostGIS
- Reporting data aggregation with views

### Phase 5: Testing, Optimization & Documentation (Week 6)

#### Tasks:
1. Implement comprehensive testing
   - Database function tests
   - Edge Function tests
   - RLS policy tests
   - Load tests
2. Optimize performance
   - Query optimization with indexes
   - PostgreSQL function optimization
   - Edge Function performance tuning
3. Create API documentation
4. Set up monitoring and alerting with Supabase metrics
5. Implement security measures
   - Additional RLS policies
   - Input validation in Edge Functions
   - Security headers

#### Deliverables:
- Test suite for database and Edge Functions
- Performance optimizations
- API documentation
- Monitoring and alerting setup
- Enhanced security implementation

## Key Components

### Authentication & Authorization
- Supabase Auth for user registration and login
- Multiple authentication providers (email, phone, OAuth)
- Role-based access control with RLS policies
- Password reset and account recovery

### Booking Management
- PostgreSQL tables and functions for booking lifecycle
- Hero matching algorithm as stored procedures
- Booking events tracking with triggers
- Cancellation and rescheduling logic

### Hero & Contractor Management
- Hero profiles and availability in PostgreSQL
- Contractor management with RLS policies
- Service categories and pricing tables
- Document verification with Supabase Storage

### Payment Processing
- Edge Functions for Stripe integration
- Stripe Connect for contractor payouts
- Refund processing via Edge Functions
- Payment reporting with PostgreSQL views

### Notification System
- Edge Functions for push notifications via Expo
- Email notifications through Edge Functions
- SMS notifications through Edge Functions
- Notification preferences stored in database

### Location & Tracking
- PostGIS for GPS data processing
- ETA calculation with PostgreSQL functions
- Geofencing with PostGIS
- Location history with efficient storage

### Media Handling
- Supabase Storage for file storage
- Image transformations
- Document storage with access controls
- Media access control with RLS policies

### Reporting & Analytics
- Views and materialized views for reports
- Performance metrics calculation with PostgreSQL
- Export functionality via Edge Functions
- Analytics event tracking

## Database Schema

The database schema follows the ERD outlined in the QRD document:

```
Key relationships (→ one-to-many):
Contractor → Heros → Bookings → BookingEvents/GpsPings/Media/Payments

Contractors(id, name, status, contract_terms, gst_number, insurance_doc_url,
            city_coverage[], categories[], commission_pct, pricing_floors_json, sla_json,
            stripe_connect_id, created_at, updated_at)

Heros(id, contractor_id→Contractors.id, user_id→Users.id, name, alias, photo_url,
      skills[], categories[], rating_avg, rating_count, bio, badges[],
      status, verification_status, availability_json, docs_json,
      created_at, updated_at)

Users(id, role[customer|hero|admin|cs|finance|contractor_manager], name, email, phone,
     password_hash?, status, created_at)

Addresses(id, user_id, label, line1, line2, city, province, postal_code, lat, lng)

Services(id, category, title, unit['fixed'|'hourly'], base_price_cents, city, active)

Bookings(id, customer_id→Users.id, contractor_id→Contractors.id, hero_id→Heros.id,
         service_id→Services.id, address_id→Addresses.id,
         scheduled_at, duration_min, status, price_cents, currency,
         tip_cents, notes, created_at, updated_at)

BookingEvents(id, booking_id, type, meta_json, created_at)

GpsPings(id, booking_id, hero_id, lat, lng, speed, ts)

Payments(id, booking_id, stripe_pi, amount_cents, currency, status,
         captured_at, refunded_cents, refund_reason)

Payouts(id, contractor_id, stripe_transfer_id, amount_cents, status, period_start, period_end)

Reviews(id, booking_id, rater_user_id, ratee_type['hero'|'contractor'], ratee_id,
        rating, comment, created_at)

Promos(id, code, type['amount'|'percent'], value, city, start_at, end_at, max_uses, used)

CSNotes(id, subject_type['booking'|'user'|'hero'|'contractor'], subject_id,
        author_user_id, note, created_at)
```

## API Endpoints

### Authentication
- `POST /auth/signup` - Register a new user
- `POST /auth/login` - Login with email/phone
- `POST /auth/otp/verify` - Verify OTP code
- `POST /auth/refresh` - Refresh access token
- `POST /auth/password/reset` - Request password reset

### Cities & Categories
- `GET /cities` - List available cities
- `GET /categories` - List service categories
- `GET /services` - List services by category and city

### Heros & Discovery
- `GET /heros` - List Heros with filtering
- `GET /heros/:id` - Get Hero details
- `GET /heros/:id/availability` - Get Hero availability
- `GET /contractors/:id/heros` - List Heros by contractor

### Bookings (Customer)
- `POST /bookings` - Create a new booking
- `GET /bookings` - List user's bookings
- `GET /bookings/:id` - Get booking details
- `POST /bookings/:id/cancel` - Cancel booking
- `POST /bookings/:id/reschedule` - Reschedule booking
- `POST /bookings/:id/tip` - Add tip to booking

### Jobs (Provider)
- `GET /jobs/queue` - Get Hero's job queue
- `POST /jobs/:id/accept` - Accept job
- `POST /jobs/:id/decline` - Decline job
- `POST /jobs/:id/status` - Update job status
- `POST /jobs/:id/ping` - Send GPS location
- `POST /jobs/:id/media` - Upload job media
- `GET /earnings` - Get Hero earnings

### Payments
- `POST /payments/intent` - Create payment intent
- `POST /payments/methods` - Save payment method
- `GET /payments/methods` - List payment methods
- `POST /payments/refund` - Request refund

### Reviews
- `POST /reviews` - Create review
- `GET /reviews/hero/:id` - Get Hero reviews

### Admin
- `POST /admin/contractors` - Create contractor
- `PATCH /admin/contractors/:id` - Update contractor
- `POST /admin/heros` - Create Hero
- `PATCH /admin/heros/:id` - Update Hero
- `GET /admin/bookings` - List bookings with filtering
- `POST /admin/bookings/:id/reassign` - Reassign booking
- `POST /admin/refunds` - Process refund
- `GET /admin/reports/revenue` - Get revenue reports

### Webhooks
- `POST /webhooks/stripe` - Handle Stripe events
- `POST /webhooks/notifications` - Handle notification events

## Technical Considerations

### Authentication & Security
- JWT-based authentication
- Role-based access control
- Rate limiting for sensitive endpoints
- Input validation and sanitization
- Security headers (CORS, CSP, etc.)

### Database
- Connection pooling
- Query optimization
- Indexing strategy
- Transaction management
- Soft deletes for important data

### Caching
- Redis for caching frequently accessed data
- Cache invalidation strategy
- Session storage

### Background Processing
- Job queue for asynchronous tasks
- Scheduled jobs for recurring tasks
- Error handling and retries

### Scalability
- Horizontal scaling with stateless design
- Database read replicas
- Caching layer
- Load balancing

### Monitoring & Logging
- Structured logging
- Error tracking with Sentry
- Performance monitoring
- Health checks
- Alerting for critical issues

## Project Structure with Supabase

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

## Dependencies for Supabase Project

```json
{
  "dependencies": {
    "@supabase/supabase-js": "^2.38.4",
    "stripe": "^14.5.0",
    "expo-server-sdk": "^3.7.0",
    "nodemailer": "^6.9.7",
    "twilio": "^4.19.0",
    "zod": "^3.22.4"
  },
  "devDependencies": {
    "typescript": "^5.2.2",
    "@types/node": "^20.9.0",
    "supabase": "^1.112.0",
    "jest": "^29.7.0",
    "ts-jest": "^29.1.1",
    "ts-node": "^10.9.1"
  }
}
```

## Testing Strategy

1. **Database Tests**: PostgreSQL functions, triggers, and RLS policies
2. **Edge Function Tests**: Testing serverless functions
3. **Load Tests**: Performance under load, concurrency handling
4. **Security Tests**: RLS policies, authentication, authorization

## Deployment Strategy

1. **Development**: Local Supabase development with Supabase CLI
2. **Staging**: Dedicated Supabase staging project
3. **Production**: Production Supabase project with monitoring

## Special Considerations

### Data Privacy & Compliance
- PIPEDA compliance for Canadian users
- Data retention policies implemented with RLS
- PII handling with column encryption
- Audit logging with database triggers

### Performance
- Query optimization with proper indexes
- Materialized views for frequently accessed data
- Efficient PostgreSQL functions
- Edge Functions for time-consuming tasks

### Reliability
- Error handling in Edge Functions
- Retry mechanisms for external services
- Monitoring with Supabase metrics
- Health checks for Edge Functions

### Scalability
- Supabase's built-in scalability features
- Optimized database queries
- Efficient use of realtime subscriptions
- Edge Functions for distributed processing
