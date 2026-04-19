# HomeHeros GO - Service Provider App

The HomeHeros GO app is the service provider (Hero) companion app for the HomeHeros platform. It allows service providers to manage their bookings, accept jobs, track their location, and complete service requests.

## 🚀 Recent Updates

### Legal Acceptance & Background Check Flow (April 2026)
- ✅ Implemented comprehensive legal acceptance flow for new hero onboarding
- ✅ Added Privacy Policy, Terms & Conditions, and Contractor Agreement acceptance
- ✅ Integrated background check process into signup flow
- ✅ Database schema updated to track legal acceptance timestamps
- ✅ All legal documents linked to HomeHeros website

## 📱 Features

### Authentication & Onboarding
- **Legal Acceptance Screen** - New heroes must accept all legal agreements before signup
- **Background Check Integration** - Seamless background check process during onboarding
- **Role-Based Access** - Automatic hero role assignment for GO app users
- **Secure Authentication** - Powered by Supabase Auth

### Job Management
- Real-time booking notifications
- Accept/decline job requests
- View booking details and customer information
- Track job status (requested → accepted → enroute → arrived → in progress → completed)
- Job completion with photo upload

### Location Services
- Real-time GPS tracking during active jobs
- ETA updates sent to customers
- Arrival notifications

### Profile Management
- Hero profile with skills and categories
- Availability management
- Performance ratings and reviews

## 🛠 Tech Stack

- **Framework:** React Native (Expo)
- **Language:** TypeScript
- **Backend:** Supabase
  - Authentication
  - PostgreSQL Database
  - Real-time subscriptions
  - Edge Functions
- **Maps:** React Native Maps
- **Navigation:** React Navigation
- **State Management:** React Context API
- **Storage:** Expo SecureStore

## 📋 Prerequisites

- Node.js 16+
- npm or yarn
- Expo CLI
- iOS Simulator (Mac) or Android Emulator
- Supabase account and project

## 🔧 Installation

1. **Clone the repository**
   ```bash
   cd Homeheros_go_app
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Set up environment variables**
   Create a `.env` file in the root directory:
   ```env
   EXPO_PUBLIC_SUPABASE_URL=your_supabase_url
   EXPO_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key
   ```

4. **Run the app**
   ```bash
   npx expo start
   ```

## 🗄 Database Schema

### Key Tables
- **profiles** - User profiles with role-based access
  - New fields: `privacy_policy_accepted_at`, `terms_accepted_at`, `contractor_agreement_accepted_at`
- **heros** - Hero-specific information (skills, categories, ratings)
- **bookings** - Service bookings and job requests
- **gps_pings** - Real-time location tracking
- **job_photos** - Job completion photos
- **notifications** - Push notifications for heroes

### Recent Schema Updates
```sql
-- Legal acceptance tracking
ALTER TABLE public.profiles
ADD COLUMN privacy_policy_accepted_at TIMESTAMPTZ,
ADD COLUMN terms_accepted_at TIMESTAMPTZ,
ADD COLUMN contractor_agreement_accepted_at TIMESTAMPTZ;
```

## 📱 Onboarding Flow

```
Sign In Screen
    ↓
Legal Acceptance Screen
    ├─ Privacy Policy
    ├─ Terms & Conditions
    └─ Contractor Agreement
    ↓
Sign Up Screen
    ├─ Email
    └─ Password
    ↓
Background Check Screen
    ├─ Start Background Check (opens external link)
    ├─ Mark as Complete
    └─ Skip for Now (with warning)
    ↓
Account Created → Sign In
```

## 🔗 External Links

The app integrates with the following HomeHeros web pages:
- **Privacy Policy:** https://homeheros.ca/privacy-policy.html
- **Terms & Conditions:** https://homeheros.ca/terms-conditions.html
- **Contractor Agreement:** https://homeheros.ca/contractor-agreement.html
- **Background Check:** https://homeheros.ca/background-check.html

## 📁 Project Structure

```
Homeheros_go_app/
├── src/
│   ├── components/        # Reusable UI components
│   ├── contexts/          # React Context providers
│   │   └── AuthContext.tsx
│   ├── navigation/        # Navigation configuration
│   │   ├── AppNavigator.tsx
│   │   ├── AuthNavigator.tsx
│   │   └── MainNavigator.tsx
│   ├── screens/
│   │   ├── auth/          # Authentication screens
│   │   │   ├── SignInScreen.tsx
│   │   │   ├── SignUpScreen.tsx
│   │   │   ├── LegalAcceptanceScreen.tsx
│   │   │   └── BackgroundCheckScreen.tsx
│   │   └── main/          # Main app screens
│   │       ├── HomeScreen.tsx
│   │       ├── JobDetailScreen.tsx
│   │       └── ProfileScreen.tsx
│   ├── services/          # API services
│   └── lib/
│       └── supabase.ts    # Supabase client configuration
├── App.tsx                # Root component
├── package.json
└── LEGAL_ACCEPTANCE_IMPLEMENTATION.md  # Detailed implementation docs
```

## 🔐 Security

- All sensitive data stored in Expo SecureStore
- JWT-based authentication via Supabase
- Row-level security (RLS) policies on all database tables
- Legal acceptance timestamps tracked for compliance
- Background checks required before job acceptance

## 🧪 Testing

### Manual Testing Checklist
- [ ] Sign up flow with legal acceptance
- [ ] Background check screen navigation
- [ ] Legal document links open correctly
- [ ] Role assignment (hero) works correctly
- [ ] Sign in with hero account
- [ ] Accept/decline bookings
- [ ] GPS tracking during active jobs
- [ ] Job completion with photos
- [ ] Profile updates

### Test Accounts
Create test accounts through the app signup flow. All new accounts will have hero role assigned automatically.

## 📝 Development Notes

### Known Issues
- SecureStore warning for large tokens (>2048 bytes) - expected behavior
- Camera functionality not available in iOS Simulator (use real device for photo testing)

### Future Enhancements
- [ ] Push notifications for new bookings
- [ ] In-app chat with customers
- [ ] Earnings dashboard
- [ ] Schedule management
- [ ] Multi-language support

## 🤝 Contributing

This is a private project. For internal development only.

## 📄 License

Proprietary - HomeHeros Inc.

## 📞 Support

For technical issues or questions, contact the development team.

---

**Last Updated:** April 19, 2026
**Version:** 0.05
**Platform:** iOS & Android (React Native)
