# Testing Documentation

This folder contains all testing scripts and documentation for the HomeHeros authentication system.

## Files

### 1. `auth-test-plan.md`
Comprehensive test plan covering all authentication scenarios including:
- Sign-up flows (valid, duplicate, validation)
- Sign-in flows (valid, invalid credentials)
- Session management
- Profile creation
- Error handling

### 2. `automated-auth-tests.ts`
Automated test suite that can be run programmatically. Includes:
- 7 automated test functions
- `runAllTests()` - Runs all tests and returns results
- `cleanupTestUsers()` - Lists test users for manual deletion

**Test Coverage:**
- ✅ Sign up with valid credentials
- ✅ Sign up with duplicate email
- ✅ Sign in with valid credentials
- ✅ Sign in with invalid password
- ✅ Sign in with non-existent email
- ✅ Session persistence
- ✅ Sign out functionality

### 3. `manual-test-checklist.md`
Step-by-step manual testing checklist with 15 test cases. Use this for:
- Manual QA testing
- Regression testing
- User acceptance testing
- Documentation of test results

### 4. `TestRunnerScreen.tsx`
React Native screen component for running automated tests in the app. Features:
- Run all tests button
- Real-time test results display
- Test summary statistics
- Cleanup information

## How to Use

### Running Automated Tests

#### Option 1: Using Test Runner Screen (Recommended)
1. Temporarily add `TestRunnerScreen` to your navigation
2. Navigate to the test screen in the app
3. Tap "Run All Tests"
4. View results in the app
5. Remove the screen before production build

#### Option 2: Console/Script
```typescript
import { runAllTests } from './testing/automated-auth-tests';

// Run tests
const results = await runAllTests();
console.log(results);
```

### Running Manual Tests
1. Open `manual-test-checklist.md`
2. Follow each test case step-by-step
3. Check off completed items
4. Document results and issues
5. Fill out the summary section

## Test Users

The following test users are created during testing:
- `test1@homeheros.test` - Primary test user
- `test2@homeheros.test` - Secondary test user
- `test3@homeheros.test` - Tertiary test user
- `test4@homeheros.test` - Fallback mechanism test
- `test5@homeheros.test` - Additional test user

**Password for all test users**: `Test123!`

## Cleanup

### After Testing
1. Run `cleanupTestUsers()` or check console for list
2. Go to Supabase Dashboard → Authentication → Users
3. Delete all test users (search for @homeheros.test)
4. Verify profiles are also deleted (CASCADE delete should handle this)

### Before Production
- [ ] Remove `TestRunnerScreen` from navigation
- [ ] Remove test imports from production code
- [ ] Delete all test users from Supabase
- [ ] Verify no test data in production database

## Test Results

### Expected Success Rate
- **Automated Tests**: 100% (7/7 passing)
- **Manual Tests**: 100% (15/15 passing)

### Common Issues to Watch For
1. ❌ Profile not created after sign-up
2. ❌ Session not persisting after app restart
3. ❌ "User already exists" not handled gracefully
4. ❌ Invalid credentials showing generic error
5. ❌ Sign-out not clearing session properly

## Debugging

### Console Logs to Monitor
```
✅ Good:
- "Signup successful: { user: [uuid], session: 'present' }"
- "Profile already exists (created by trigger)"
- "Profile created successfully via fallback"
- "Sign in successful: { user: [uuid], session: 'present' }"

❌ Bad:
- "Profile not found, creating manually..." (fallback working but trigger failed)
- "Failed to create profile:" (critical issue)
- "Sign in returned no error but also no session" (unconfirmed user)
```

### Supabase Dashboard Checks
1. **Authentication → Users**: Verify user count and status
2. **Table Editor → profiles**: Verify profile records match users
3. **SQL Editor**: Run queries to check data integrity
   ```sql
   -- Check for users without profiles
   SELECT u.id, u.email 
   FROM auth.users u 
   LEFT JOIN public.profiles p ON u.id = p.id 
   WHERE p.id IS NULL;
   
   -- Check for profiles without users (orphaned)
   SELECT p.id, p.email 
   FROM public.profiles p 
   LEFT JOIN auth.users u ON p.id = u.id 
   WHERE u.id IS NULL;
   ```

## Performance Benchmarks

### Target Times
- Sign-up: < 3 seconds
- Sign-in: < 2 seconds
- Profile fetch: < 1 second
- Sign-out: < 500ms
- Session restore: < 1 second

### Actual Times (to be filled during testing)
- Sign-up: _____ seconds
- Sign-in: _____ seconds
- Profile fetch: _____ seconds
- Sign-out: _____ seconds
- Session restore: _____ seconds

## Notes

- All tests use the production Supabase instance
- Email confirmation is disabled for testing
- Test users have role='customer' by default
- Profile creation has fallback mechanism
- Session persistence uses expo-secure-store

## Contact

For issues or questions about testing:
- Check console logs first
- Review test plan for expected behavior
- Verify Supabase configuration
- Check network connectivity

---

**Last Updated**: October 21, 2025
**Version**: 1.0.0
**Status**: Ready for Testing ✅
