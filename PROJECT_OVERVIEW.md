# HomeHeros Project Overview

## Project Description
HomeHeros is a platform connecting customers with service providers ("Heros") for various home services. The platform follows a B2B2C model where HomeHeros signs contracts with Contractors who manage their own service providers (Heros). Customers can browse, select, and book specific Heros based on their profiles, ratings, and availability.

## Key Differentiator
"Pick your Hero" - Customers can browse and select specific service providers rather than being auto-matched, while maintaining B2B control via Contractor agreements (pricing floors, SLAs, coverage).

## System Architecture

### Components

1. **Customer App (HomeHeros)** - Mobile app for customers to browse, book, and track Heros
   - Platform: iOS 15+, Android 8+ using Expo/React Native
   - Key features: Hero discovery, booking, payment, tracking, rating

2. **Provider App (HomeHeros Go)** - Mobile app for service providers (Heros)
   - Platform: iOS 15+, Android 8+ using Expo/React Native with background location services
   - Key features: Availability management, job acceptance, status updates, navigation, proof of work

3. **Admin Portal/ERP/CRM** - Web application for administration, operations, and contractor management
   - Platform: Web application using Expo Web
   - Key features: Live operations board, user management, booking management, reporting, contractor portal

4. **Backend Services** - API and database services supporting all applications
- Platform: Supabase (PostgreSQL, Authentication, Storage, Realtime)
- Key features: Authentication, database, storage, realtime subscriptions, edge functions

### System Connectivity

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│                 │     │                 │     │                 │
│  Customer App   │     │  Provider App   │     │  Admin Portal   │
│  (Expo/RN)      │     │  (Expo/RN)      │     │  (Expo Web)     │
│                 │     │                 │     │                 │
└────────┬────────┘     └────────┬────────┘     └────────┬────────┘
         │                       │                       │
         │                       │                       │
         │                       │                       │
         ▼                       ▼                       ▼
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│                       REST API Services                         │
│                                                                 │
└────────────────────────────────┬────────────────────────────────┘
                                 │
                                 │
                                 ▼
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│                          Database                               │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### External Services Integration

- **Backend**: Supabase for authentication, database, storage, and realtime features
- **Payments**: Stripe for payment processing and Stripe Connect for contractor payouts
- **Maps & Location**: Apple/Google Maps APIs for tracking and navigation
- **Notifications**: Push notifications via Expo Notifications, Supabase Edge Functions for SMS/Email
- **Analytics**: PostHog/Amplitude for product analytics, Sentry for error tracking

## Development Approach

### Technology Stack

- **Frontend**: 
  - Mobile Apps: React Native with Expo
  - Admin Portal: React with Expo Web
  
- **Backend**:
  - Platform: Supabase
  - Database: PostgreSQL (managed by Supabase)
  - Authentication: Supabase Auth
  - Storage: Supabase Storage
  - Serverless Functions: Supabase Edge Functions
  
- **DevOps**:
  - CI/CD: GitHub Actions
  - Hosting: Supabase (backend), Vercel (web), EAS (mobile)
  - Monitoring: Sentry

### Development Phases

The project will be implemented in the following phases:

#### Phase 1: Foundation (Weeks 1-2)
- Set up project repositories and CI/CD pipelines
- Implement core backend services (auth, basic API endpoints)
- Create basic UI components and navigation for all apps
- Set up database schema and migrations

#### Phase 2: MVP Development (Weeks 3-6)
- Implement core features for all three applications
- Integrate with payment processing and maps APIs
- Develop booking and matching algorithm
- Implement basic admin functionality

#### Phase 3: Testing & Refinement (Weeks 7-8)
- Comprehensive testing of all components
- Performance optimization
- Security audits
- Bug fixes and refinements

#### Phase 4: Launch Preparation (Weeks 9-10)
- Final QA and user acceptance testing
- Documentation completion
- Deployment to production environments
- Monitoring setup and alerts configuration

## Future Roadmap (Post-MVP)

1. **V1 Enhancements**:
   - Promo codes
   - PST rules
   - In-app CS chat
   - Automated background checks
   - Surge pricing/multipliers
   - Contractor analytics/heatmaps
   - Self-serve data export/delete

2. **Later Phases**:
   - Subscriptions
   - Multi-contractor Hero association
   - Quotes/bids functionality
   - Inventory/materials management
   - Marketplace bundles
