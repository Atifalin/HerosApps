# Changelog - HomeHeros GO App

All notable changes to the HomeHeros GO service provider app will be documented in this file.

## [0.05] - 2026-04-19

### 🎉 Major Features Added

#### Legal Acceptance & Onboarding Flow
- **New Legal Acceptance Screen**
  - Three mandatory checkboxes for Privacy Policy, Terms & Conditions, and Contractor Agreement
  - "Read Document" links that open legal documents in browser
  - Modern UI with shield icon and info cards
  - Continue button disabled until all agreements accepted
  
- **Background Check Integration**
  - New Background Check screen added to onboarding flow
  - External link to background check portal (https://homeheros.ca/background-check.html)
  - Checkbox to confirm completion
  - "Skip for Now" option with warning about job restrictions
  - Info cards explaining the process (Quick & Easy, Secure & Private, Fast Processing)
  - Lists what is checked (criminal record, identity, employment eligibility)

- **Updated Signup Flow**
  - New flow: SignIn → LegalAcceptance → SignUp → BackgroundCheck → SignIn
  - Legal acceptance timestamps saved to database
  - Automatic hero role assignment for GO app users
  - Validation to ensure legal acceptance before account creation

### 🗄 Database Changes

#### New Columns in `profiles` Table
```sql
- privacy_policy_accepted_at (TIMESTAMPTZ)
- terms_accepted_at (TIMESTAMPTZ)  
- contractor_agreement_accepted_at (TIMESTAMPTZ)
```

#### Indexes Added
- `idx_profiles_privacy_accepted`
- `idx_profiles_terms_accepted`
- `idx_profiles_contractor_agreement_accepted`

### 🔗 External Integrations

#### Legal Document Links
- Privacy Policy: https://homeheros.ca/privacy-policy.html
- Terms & Conditions: https://homeheros.ca/terms-conditions.html
- Contractor Agreement: https://homeheros.ca/contractor-agreement.html
- Background Check: https://homeheros.ca/background-check.html

### 📱 UI/UX Improvements

#### LegalAcceptanceScreen
- Shield icon with orange accent color
- Clear title and subtitle explaining requirements
- Custom checkbox components with visual feedback
- Responsive layout with scroll support
- Disabled state for continue button until all boxes checked

#### BackgroundCheckScreen
- Large shield icon with outline style
- Three info cards with icons (checkmark, lock, clock)
- "What We Check" section with checkmarks
- Blue "Start Background Check" button
- Orange "Continue" button (disabled until checkbox marked)
- Gray "Skip for Now" button with confirmation dialog

### 🔧 Technical Improvements

#### Navigation Updates
- Added `LegalAcceptanceScreen` to `AuthNavigator`
- Added `BackgroundCheckScreen` to `AuthNavigator`
- Updated `SignInScreen` to navigate to LegalAcceptance instead of SignUp
- Updated `SignUpScreen` to navigate to BackgroundCheck after validation
- Proper parameter passing between screens (email, password, legalAcceptance)

#### Authentication Flow
- Signup now happens in `BackgroundCheckScreen` to prevent premature auth state changes
- Legal acceptance data passed through navigation params
- Role explicitly set to 'hero' during profile update
- 1.5 second delay after signup to allow database trigger to complete

#### Code Quality
- TypeScript interfaces for all screen props
- Proper error handling with try-catch blocks
- Console logging for debugging
- Loading states for async operations
- Disabled button states during loading

### 📝 Documentation

#### New Files
- `README.md` - Comprehensive project documentation
- `LEGAL_ACCEPTANCE_IMPLEMENTATION.md` - Detailed implementation guide
- `CHANGELOG.md` - This file

#### Updated Files
- `AuthNavigator.tsx` - Added new screens to navigation stack
- `SignInScreen.tsx` - Updated navigation flow
- `SignUpScreen.tsx` - Refactored to navigate to BackgroundCheck
- `BackgroundCheckScreen.tsx` - New screen component
- `LegalAcceptanceScreen.tsx` - New screen component

### 🐛 Bug Fixes

- Fixed issue where signup would complete before BackgroundCheck screen could be shown
- Fixed role not being set to 'hero' for new accounts
- Fixed legal acceptance timestamps not being saved to database
- Fixed navigation flow to prevent automatic redirect to main app before onboarding complete

### 🔐 Security & Compliance

- Legal acceptance timestamps tracked for audit purposes
- Background check requirement enforced before job acceptance
- All legal documents accessible via secure HTTPS links
- User consent properly recorded in database

### ⚠️ Known Issues

- SecureStore warning for tokens >2048 bytes (expected behavior, not critical)
- Camera functionality unavailable in iOS Simulator (use real device for testing)
- Hero profile creation may show error if profile doesn't exist yet (will be created on first job acceptance)

### 📊 Database Migration

Migration applied: `20260419_add_legal_acceptance_fields.sql`
- Added three new timestamp columns to profiles table
- Created indexes for efficient querying
- Added column comments for documentation

### 🧪 Testing Notes

#### Test Scenarios Covered
- ✅ Complete signup flow with legal acceptance
- ✅ Background check screen navigation
- ✅ Legal document links open in browser
- ✅ Role assignment to hero
- ✅ Legal acceptance timestamps saved
- ✅ Skip background check option
- ✅ Validation prevents signup without legal acceptance

#### Test Accounts Created
- tester123@123.com (role updated to hero via SQL)
- testerlinks@gmail.com (created during testing)

### 🚀 Deployment

- Database migration applied to production Supabase project (vttzuaerdwagipyocpha)
- All changes tested on iOS Simulator
- Ready for production deployment

---

## Version History

### [0.05] - 2026-04-19
- Initial release with legal acceptance and background check flow
- Complete onboarding system for service providers
- Database schema updates for compliance tracking

---

**Maintained by:** HomeHeros Development Team
**Last Updated:** April 19, 2026
