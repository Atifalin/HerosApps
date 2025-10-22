# Manual Testing Checklist

## Pre-Test Setup
- [ ] iOS Simulator running
- [ ] App installed and launched
- [ ] Supabase dashboard open in browser
- [ ] Console logs visible
- [ ] Network connected

## Test Execution Log

### Test 1: New User Sign-Up ✓
**Time**: _____
**Email**: test1@homeheros.test
**Password**: Test123!

Steps:
1. [ ] Navigate to Sign Up screen
2. [ ] Enter email
3. [ ] Enter password
4. [ ] Enter confirm password
5. [ ] Click "Create Account"

Results:
- [ ] Success alert shown
- [ ] Redirected to sign-in
- [ ] Console log: "Signup successful"
- [ ] Console log: Profile creation message
- [ ] Supabase: User exists in auth.users
- [ ] Supabase: Profile exists in profiles table

**Status**: ⬜ Pass ⬜ Fail
**Notes**: _______________________________________________

---

### Test 2: Duplicate Email Sign-Up ✓
**Time**: _____
**Email**: test1@homeheros.test (same as Test 1)
**Password**: Test123!

Steps:
1. [ ] Navigate to Sign Up screen
2. [ ] Enter same email from Test 1
3. [ ] Enter password
4. [ ] Click "Create Account"

Results:
- [ ] Alert: "Account Already Exists"
- [ ] Option to navigate to sign-in shown
- [ ] No crash
- [ ] Console log: Error message about existing user

**Status**: ⬜ Pass ⬜ Fail
**Notes**: _______________________________________________

---

### Test 3: Weak Password Validation ✓
**Time**: _____
**Email**: test2@homeheros.test
**Password**: 12345 (only 5 characters)

Steps:
1. [ ] Navigate to Sign Up screen
2. [ ] Enter email
3. [ ] Enter weak password
4. [ ] Enter confirm password
5. [ ] Click "Create Account"

Results:
- [ ] Alert: "Password must be at least 6 characters"
- [ ] No API call made
- [ ] User stays on sign-up screen

**Status**: ⬜ Pass ⬜ Fail
**Notes**: _______________________________________________

---

### Test 4: Password Mismatch ✓
**Time**: _____
**Email**: test3@homeheros.test
**Password**: Test123! / Test456! (different)

Steps:
1. [ ] Navigate to Sign Up screen
2. [ ] Enter email
3. [ ] Enter password: Test123!
4. [ ] Enter confirm password: Test456!
5. [ ] Click "Create Account"

Results:
- [ ] Alert: "Passwords do not match"
- [ ] No API call made
- [ ] User stays on sign-up screen

**Status**: ⬜ Pass ⬜ Fail
**Notes**: _______________________________________________

---

### Test 5: Empty Fields Validation ✓
**Time**: _____

Steps:
1. [ ] Navigate to Sign Up screen
2. [ ] Leave all fields empty
3. [ ] Click "Create Account"

Results:
- [ ] Alert: "Please fill in all fields"
- [ ] No API call made

**Status**: ⬜ Pass ⬜ Fail
**Notes**: _______________________________________________

---

### Test 6: Valid Sign-In ✓
**Time**: _____
**Email**: test1@homeheros.test
**Password**: Test123!

Steps:
1. [ ] Navigate to Sign In screen
2. [ ] Enter email
3. [ ] Enter password
4. [ ] Click "Sign In"

Results:
- [ ] User authenticated
- [ ] Redirected to home screen
- [ ] Console log: "Sign in successful"
- [ ] Console log: Session present
- [ ] Profile data loaded
- [ ] Bottom tabs visible

**Status**: ⬜ Pass ⬜ Fail
**Notes**: _______________________________________________

---

### Test 7: Invalid Password Sign-In ✓
**Time**: _____
**Email**: test1@homeheros.test
**Password**: WrongPassword123!

Steps:
1. [ ] Navigate to Sign In screen
2. [ ] Enter email
3. [ ] Enter wrong password
4. [ ] Click "Sign In"

Results:
- [ ] Alert: "Invalid email or password"
- [ ] User stays on sign-in screen
- [ ] No crash
- [ ] Console log: Sign in error

**Status**: ⬜ Pass ⬜ Fail
**Notes**: _______________________________________________

---

### Test 8: Non-Existent Email Sign-In ✓
**Time**: _____
**Email**: nonexistent@homeheros.test
**Password**: Test123!

Steps:
1. [ ] Navigate to Sign In screen
2. [ ] Enter non-existent email
3. [ ] Enter password
4. [ ] Click "Sign In"

Results:
- [ ] Alert: "Invalid email or password"
- [ ] User stays on sign-in screen
- [ ] No crash

**Status**: ⬜ Pass ⬜ Fail
**Notes**: _______________________________________________

---

### Test 9: Session Persistence ✓
**Time**: _____

Steps:
1. [ ] Sign in successfully (use test1@homeheros.test)
2. [ ] Verify you're on home screen
3. [ ] Close app completely (swipe up from dock)
4. [ ] Wait 5 seconds
5. [ ] Reopen app

Results:
- [ ] User still signed in
- [ ] Home screen shown immediately
- [ ] No sign-in screen shown
- [ ] Profile data loaded
- [ ] Console log: Session restored

**Status**: ⬜ Pass ⬜ Fail
**Notes**: _______________________________________________

---

### Test 10: Sign Out ✓
**Time**: _____

Steps:
1. [ ] Ensure you're signed in
2. [ ] Navigate to Account tab
3. [ ] Find and click "Sign Out" button
4. [ ] Confirm sign out if prompted

Results:
- [ ] User signed out
- [ ] Redirected to sign-in screen
- [ ] Session cleared
- [ ] Console log: Sign out successful
- [ ] Can't navigate back to authenticated screens

**Status**: ⬜ Pass ⬜ Fail
**Notes**: _______________________________________________

---

### Test 11: Profile Data Verification ✓
**Time**: _____

Steps:
1. [ ] Sign in as test1@homeheros.test
2. [ ] Navigate to Account tab
3. [ ] Check profile information displayed

Results:
- [ ] Email displayed correctly
- [ ] Name displayed (or email prefix)
- [ ] Role is "customer"
- [ ] No errors loading profile
- [ ] Console log: Profile fetched successfully

**Status**: ⬜ Pass ⬜ Fail
**Notes**: _______________________________________________

---

### Test 12: Multiple Sign-In/Sign-Out Cycles ✓
**Time**: _____

Steps:
1. [ ] Sign in
2. [ ] Sign out
3. [ ] Repeat 3 times

Results:
- [ ] All cycles work correctly
- [ ] No memory leaks
- [ ] No performance degradation
- [ ] No crashes
- [ ] Session management works consistently

**Status**: ⬜ Pass ⬜ Fail
**Notes**: _______________________________________________

---

### Test 13: Button States ✓
**Time**: _____

Steps:
1. [ ] Navigate to Sign Up screen
2. [ ] Click "Create Account" with valid data
3. [ ] Observe button during loading

Results:
- [ ] Button shows "Creating Account..." during loading
- [ ] Button is disabled during loading
- [ ] Button turns grey/disabled state
- [ ] Can't click multiple times
- [ ] Button returns to normal after completion

**Status**: ⬜ Pass ⬜ Fail
**Notes**: _______________________________________________

---

### Test 14: Navigation Flow ✓
**Time**: _____

Steps:
1. [ ] Start at sign-in screen
2. [ ] Click "Sign Up" link
3. [ ] Verify on sign-up screen
4. [ ] Click "Sign In" link
5. [ ] Verify back on sign-in screen

Results:
- [ ] Navigation works smoothly
- [ ] No flashing or glitches
- [ ] Form data cleared on navigation
- [ ] Correct screen titles shown

**Status**: ⬜ Pass ⬜ Fail
**Notes**: _______________________________________________

---

### Test 15: Profile Fallback Creation ✓
**Time**: _____
**Note**: This tests the fallback mechanism

Steps:
1. [ ] Sign up with test4@homeheros.test
2. [ ] Watch console logs carefully
3. [ ] Check Supabase dashboard

Results:
- [ ] Console log: "Checking if profile exists"
- [ ] Console log: Either "Profile already exists" OR "Profile created successfully via fallback"
- [ ] Profile exists in database
- [ ] Profile has correct structure
- [ ] User can sign in successfully

**Status**: ⬜ Pass ⬜ Fail
**Notes**: _______________________________________________

---

## Test Summary

**Date**: October 21, 2025
**Tester**: _____
**Environment**: iOS Simulator
**App Version**: 1.0.0

### Results
- Total Tests: 15
- Passed: _____
- Failed: _____
- Blocked: _____
- Success Rate: _____%

### Critical Issues Found
1. _______________________________________________
2. _______________________________________________
3. _______________________________________________

### Minor Issues Found
1. _______________________________________________
2. _______________________________________________
3. _______________________________________________

### Performance Notes
- Average sign-up time: _____ seconds
- Average sign-in time: _____ seconds
- Profile fetch time: _____ seconds
- App launch time (with session): _____ seconds

### Recommendations
_______________________________________________
_______________________________________________
_______________________________________________

### Test Users Created
- test1@homeheros.test (primary test user)
- test2@homeheros.test (if created)
- test3@homeheros.test (if created)
- test4@homeheros.test (fallback test)

**Remember to delete these users from Supabase after testing!**
