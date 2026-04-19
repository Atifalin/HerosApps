# Legal Acceptance Implementation for HomeHeros GO App

## Overview
Added privacy and legal acceptance flow to the Go app onboarding process. Users must now accept Privacy Policy, Terms & Conditions, and Contractor Agreement before creating their provider account.

## Changes Made

### 1. Database Migration
**File:** `/supabase/migrations/20260419_add_legal_acceptance_fields.sql`

Added three new timestamp fields to the `profiles` table:
- `privacy_policy_accepted_at` - Records when user accepted Privacy Policy
- `terms_accepted_at` - Records when user accepted Terms & Conditions  
- `contractor_agreement_accepted_at` - Records when hero accepted Contractor Agreement

**To apply migration:**
```bash
cd supabase
npx supabase db push
```

### 2. New LegalAcceptanceScreen Component
**File:** `/Homeheros_go_app/src/screens/auth/LegalAcceptanceScreen.tsx`

Features:
- Three checkboxes for Privacy Policy, Terms & Conditions, and Contractor Agreement
- "Read Document" links for each agreement (opens in browser)
- Continue button disabled until all three are accepted
- Passes acceptance timestamps to SignUp screen via navigation params
- Modern UI with icons and info box

### 3. New BackgroundCheckScreen Component
**File:** `/Homeheros_go_app/src/screens/auth/BackgroundCheckScreen.tsx`

Features:
- Displays information about the background check process
- "Start Background Check" button opens external link (https://homeheros.ca/background-check.html)
- Checkbox to confirm completion
- "Continue" button enabled after marking as complete
- "Skip for Now" option with warning about job acceptance restrictions
- Info cards explaining the process (quick, secure, fast)
- Lists what is checked (criminal record, identity, employment eligibility)

### 4. Updated Navigation Flow
**File:** `/Homeheros_go_app/src/navigation/AuthNavigator.tsx`

New flow:
```
SignIn → LegalAcceptance → SignUp → BackgroundCheck → SignIn
```

### 5. Updated SignInScreen
**File:** `/Homeheros_go_app/src/screens/auth/SignInScreen.tsx`

- "Sign Up" link now navigates to `LegalAcceptance` instead of directly to `SignUp`

### 6. Updated SignUpScreen
**File:** `/Homeheros_go_app/src/screens/auth/SignUpScreen.tsx`

- Receives `legalAcceptance` data from navigation params
- Validates that legal acceptance data exists before allowing signup
- After successful signup, updates profile with acceptance timestamps
- Navigates to BackgroundCheck screen instead of directly to SignIn

## User Flow

1. User taps "Sign Up" on SignIn screen
2. User is taken to LegalAcceptanceScreen
3. User must check all three agreement boxes
4. User taps "Continue to Sign Up"
5. User enters email and password on SignUpScreen
6. After successful signup, acceptance timestamps are saved to database
7. User is taken to BackgroundCheckScreen
8. User can start the background check process (opens external link)
9. User marks the check as completed and continues to SignIn screen
10. User can also skip the background check for later (with warning)

## Legal Documents & Background Check

The app links to legal documents and background check hosted on HomeHeros website:
- **Privacy Policy:** `https://homeheros.ca/privacy-policy.html`
- **Terms & Conditions:** `https://homeheros.ca/terms-conditions.html`
- **Contractor Agreement:** `https://homeheros.ca/contractor-agreement.html`
- **Background Check:** `https://homeheros.ca/background-check.html`

Source PDF documents are available in `/Privacy and legal/`:
- `home_heros_privacy_policy.pdf`
- `home_heros_terms_conditions.pdf`
- `home_heros_contractor_agreement.pdf`

**Note:** All document and background check links will open in the device's default browser.

## Database Schema

```sql
-- New columns in profiles table
ALTER TABLE public.profiles
ADD COLUMN privacy_policy_accepted_at TIMESTAMPTZ,
ADD COLUMN terms_accepted_at TIMESTAMPTZ,
ADD COLUMN contractor_agreement_accepted_at TIMESTAMPTZ;
```

## Testing Checklist

- [ ] Apply database migration
- [ ] Test new signup flow from SignIn → LegalAcceptance → SignUp
- [ ] Verify all three checkboxes must be checked to continue
- [ ] Verify acceptance timestamps are saved to database
- [ ] Test "Read Document" links (currently shows alerts)
- [ ] Test back navigation from each screen
- [ ] Verify existing users can still sign in normally
- [ ] Test that accessing SignUp directly without legal acceptance redirects to LegalAcceptance

## Future Enhancements

1. **Document Viewing:**
   - Host PDFs on web server
   - Implement in-app PDF viewer or open in browser
   - Track which documents user actually opened/read

2. **Version Tracking:**
   - Add version numbers to legal documents
   - Track which version user accepted
   - Prompt users to re-accept when documents are updated

3. **Admin Dashboard:**
   - View which users have accepted agreements
   - Export acceptance records for compliance
   - Filter users by acceptance status

4. **Re-acceptance Flow:**
   - Detect when legal documents are updated
   - Prompt existing users to accept new versions
   - Block app usage until new versions are accepted
