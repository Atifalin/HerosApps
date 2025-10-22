# Authentication Test Plan

## Test Environment
- **Platform**: iOS Simulator
- **Date**: October 21, 2025
- **Supabase**: Production (vttzuaerdwagipyocpha.supabase.co)

## Test Scenarios

### 1. New User Sign-Up (Happy Path)
**Test Case**: Fresh email, valid password
- [ ] Enter email: `test1@homeheros.test`
- [ ] Enter password: `Test123!`
- [ ] Confirm password: `Test123!`
- [ ] Click "Create Account"
- **Expected**: 
  - Success alert shown
  - Profile created in database
  - User redirected to sign-in
  - Console shows: "Profile already exists (created by trigger)" OR "Profile created successfully via fallback"

### 2. Sign-Up with Existing Email
**Test Case**: Email already in system
- [ ] Enter email: `test1@homeheros.test` (from test 1)
- [ ] Enter password: `Test123!`
- [ ] Confirm password: `Test123!`
- [ ] Click "Create Account"
- **Expected**: 
  - Alert: "Account Already Exists"
  - Option to navigate to sign-in
  - No crash

### 3. Sign-Up with Weak Password
**Test Case**: Password too short
- [ ] Enter email: `test2@homeheros.test`
- [ ] Enter password: `12345`
- [ ] Confirm password: `12345`
- [ ] Click "Create Account"
- **Expected**: 
  - Alert: "Password must be at least 6 characters"
  - No API call made

### 4. Sign-Up with Mismatched Passwords
**Test Case**: Passwords don't match
- [ ] Enter email: `test3@homeheros.test`
- [ ] Enter password: `Test123!`
- [ ] Confirm password: `Test456!`
- [ ] Click "Create Account"
- **Expected**: 
  - Alert: "Passwords do not match"
  - No API call made

### 5. Sign-In (Happy Path)
**Test Case**: Valid credentials
- [ ] Enter email: `test1@homeheros.test`
- [ ] Enter password: `Test123!`
- [ ] Click "Sign In"
- **Expected**: 
  - User authenticated
  - Profile loaded
  - Redirected to home screen
  - Console shows: "Sign in successful"

### 6. Sign-In with Wrong Password
**Test Case**: Invalid credentials
- [ ] Enter email: `test1@homeheros.test`
- [ ] Enter password: `WrongPassword123!`
- [ ] Click "Sign In"
- **Expected**: 
  - Alert: "Invalid email or password. Please try again."
  - User stays on sign-in screen
  - No crash

### 7. Sign-In with Non-Existent Email
**Test Case**: Email not in system
- [ ] Enter email: `nonexistent@homeheros.test`
- [ ] Enter password: `Test123!`
- [ ] Click "Sign In"
- **Expected**: 
  - Alert: "Invalid email or password. Please try again."
  - User stays on sign-in screen

### 8. Profile Creation Fallback (Sign-Up)
**Test Case**: Trigger fails, fallback creates profile
- [ ] Temporarily disable trigger in Supabase (if possible)
- [ ] Sign up with: `test4@homeheros.test`
- [ ] Password: `Test123!`
- **Expected**: 
  - Console shows: "Profile not found, creating manually..."
  - Console shows: "Profile created successfully via fallback"
  - User can sign in successfully

### 9. Profile Creation Fallback (Sign-In)
**Test Case**: User exists without profile
- [ ] Manually create user in auth.users without profile
- [ ] Sign in with that user
- **Expected**: 
  - Console shows: "Profile missing for existing user, creating now..."
  - Console shows: "Missing profile created successfully"
  - User can access app

### 10. Session Persistence
**Test Case**: App restart maintains session
- [ ] Sign in successfully
- [ ] Close app completely
- [ ] Reopen app
- **Expected**: 
  - User still signed in
  - No need to sign in again
  - Profile data loaded

### 11. Sign-Out
**Test Case**: User signs out
- [ ] Sign in successfully
- [ ] Navigate to Account tab
- [ ] Click "Sign Out"
- **Expected**: 
  - User signed out
  - Redirected to sign-in screen
  - Session cleared

### 12. Empty Form Validation
**Test Case**: Submit without filling fields
- [ ] Leave all fields empty
- [ ] Click "Create Account" or "Sign In"
- **Expected**: 
  - Alert: "Please fill in all fields"
  - No API call made

### 13. Network Error Handling
**Test Case**: No internet connection
- [ ] Disable internet on simulator
- [ ] Try to sign up or sign in
- **Expected**: 
  - Alert with network error message
  - User can retry after reconnecting

### 14. Multiple Rapid Sign-Up Attempts
**Test Case**: Spam protection
- [ ] Click "Create Account" multiple times rapidly
- **Expected**: 
  - Button disabled during loading
  - Only one request sent
  - No duplicate users created

### 15. Special Characters in Email
**Test Case**: Valid email formats
- [ ] Test: `test+tag@homeheros.test`
- [ ] Test: `test.name@homeheros.test`
- **Expected**: 
  - All valid email formats accepted
  - Sign-up successful

## Console Log Checks

### Sign-Up Success Logs:
```
Attempting signup with: [email]
Supabase URL: https://vttzuaerdwagipyocpha.supabase.co
API Key length: [number]
Checking if profile exists for user: [uuid]
Profile already exists (created by trigger) OR Profile created successfully via fallback
Signup successful: { user: [uuid], session: 'present' }
```

### Sign-In Success Logs:
```
Attempting sign in with: [email]
Sign in successful: { user: [uuid], session: 'present' }
```

### Error Logs:
```
Signup error details: { message: [error], status: [code], name: [name] }
Sign in error: { message: [error], status: [code] }
```

## Database Verification

After each test, verify in Supabase:
- [ ] User exists in `auth.users`
- [ ] Profile exists in `profiles` table
- [ ] Profile has correct fields: id, email, name, role='customer', status='active'
- [ ] No duplicate profiles

## Performance Checks
- [ ] Sign-up completes within 3 seconds
- [ ] Sign-in completes within 2 seconds
- [ ] Profile fetch completes within 1 second
- [ ] No memory leaks after multiple sign-in/sign-out cycles

## Test Results Summary
- **Total Tests**: 15
- **Passed**: 
- **Failed**: 
- **Blocked**: 
- **Notes**: 
