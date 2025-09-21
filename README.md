# HomeHeros Platform

## Overview

HomeHeros is a platform connecting customers with service providers ("Heros") for various home services. The platform follows a B2B2C model where HomeHeros signs contracts with Contractors who manage their own service providers (Heros). Customers can browse, select, and book specific Heros based on their profiles, ratings, and availability.

## Key Differentiator

"Pick your Hero" - Customers can browse and select specific service providers rather than being auto-matched, while maintaining B2B control via Contractor agreements (pricing floors, SLAs, coverage).

## Repository Structure

This repository contains the following components:

- **[Homeheros_app](./Homeheros_app/)**: Customer mobile application (iOS/Android)
- **[Homeheros_go_app](./Homeheros_go_app/)**: Provider mobile application (iOS/Android)
- **[HomeHeros_ERP](./HomeHeros_ERP/)**: Admin Portal/ERP/CRM web application
- **Supabase**: Backend services (authentication, database, storage, realtime)

## Documentation

- **[PROJECT_OVERVIEW.md](./PROJECT_OVERVIEW.md)**: High-level overview of the project architecture and components
- **[BACKEND_IMPLEMENTATION.md](./BACKEND_IMPLEMENTATION.md)**: Backend implementation plan and API documentation
- **[TESTING_STRATEGY.md](./TESTING_STRATEGY.md)**: Comprehensive testing strategy for all components
- **[QRD.md](./QRD.md)**: Original Quick Requirements Document

Each component folder contains its own implementation plan with detailed information about the development phases, technical specifications, and folder structure.

## Technology Stack

### Mobile Applications
- **Framework**: React Native with Expo
- **State Management**: Redux Toolkit / Context API
- **Navigation**: React Navigation
- **API Client**: Axios
- **Maps**: React Native Maps
- **Payments**: Stripe React Native

### Admin Portal
- **Framework**: React with Expo Web
- **UI Library**: Mantine
- **State Management**: Redux Toolkit / Context API
- **Routing**: React Router
- **Data Visualization**: Recharts
- **Maps**: Google Maps React

### Backend (Supabase)
- **Platform**: Supabase
- **Database**: PostgreSQL (managed by Supabase)
- **Authentication**: Supabase Auth
- **Storage**: Supabase Storage
- **Realtime**: Supabase Realtime
- **Serverless Functions**: Supabase Edge Functions
- **Payment Processing**: Stripe (via Edge Functions)
- **Notifications**: Expo Server SDK, Nodemailer, Twilio (via Edge Functions)

## Getting Started

### Prerequisites
- Node.js 18+
- Yarn or npm
- Expo CLI
- PostgreSQL
- Redis

### Setting Up the Development Environment

1. Clone the repository:
```bash
git clone https://github.com/yourusername/homeheros.git
cd homeheros
```

2. Install dependencies for each component:
```bash
# Customer App
cd Homeheros_app
yarn install

# Provider App
cd ../Homeheros_go_app
yarn install

# Admin Portal
cd ../HomeHeros_ERP
yarn install

# Supabase setup
cd ../supabase
yarn install
```

3. Set up environment variables:
   - Copy `.env.example` to `.env` in each component folder
   - Fill in the required environment variables

4. Start the development servers:
```bash
# Customer App
cd Homeheros_app
expo start

# Provider App
cd ../Homeheros_go_app
expo start

# Admin Portal
cd ../HomeHeros_ERP
expo start --web

# Supabase local development
cd ../supabase
npx supabase start
```

## Development Workflow

1. Create a feature branch from `develop`
2. Implement the feature or fix
3. Write tests
4. Submit a pull request to `develop`
5. After review and approval, merge to `develop`
6. Periodically, merge `develop` to `main` for releases

## Deployment

### Mobile Apps
- Use EAS Build for creating native builds
- Use EAS Submit for submitting to app stores
- Use EAS Update for OTA updates

### Admin Portal
- Deploy to Vercel or similar platform
- Set up preview deployments for PRs

### Backend
- Deploy to Fly.io, Render, or similar platform
- Set up CI/CD pipeline for automated deployments

## Contributing

1. Follow the coding standards and conventions
2. Write tests for new features
3. Update documentation as needed
4. Keep commits small and focused
5. Use descriptive commit messages

## License

[Specify your license here]

## Contact

[Your contact information]
