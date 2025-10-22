# 🚀 How to Run Automated Tests

## ✅ App is Running
Your app is currently running in iOS Simulator via Expo Go.

---

## 🎯 Quick Run (Recommended)

### Option 1: Add to App.tsx (Easiest)

1. **Open** `App.tsx`
2. **Add this line** at the top (after other imports):
   ```typescript
   import './testing/run-tests-in-app';
   ```
3. **Save the file** (app will reload automatically)
4. **Watch console** for test results (will start after 3 seconds)
5. **Remove the import** when done

**Expected Output:**
```
═══════════════════════════════════════════════════════════════════
🧪 AUTOMATED AUTH TESTS - STARTING
═══════════════════════════════════════════════════════════════════

🚀 Starting automated auth tests...

🧪 Test 1: Sign up with valid credentials
✅ PASS - Sign Up Valid (2847ms)
   User created successfully with profile (role: customer)

... (6 more tests)

📊 Test Summary:
   Total: 7
   Passed: 7
   Failed: 0
   Duration: 8234ms
   Success Rate: 100.0%

═══════════════════════════════════════════════════════════════════
✅ AUTOMATED AUTH TESTS - COMPLETE
═══════════════════════════════════════════════════════════════════

🎉 ALL TESTS PASSED! 🎉
```

---

### Option 2: Use React DevTools Console

1. **Open** React DevTools in your browser
2. **Go to** Console tab
3. **Paste and run**:
   ```javascript
   import('./testing/automated-auth-tests').then(async ({ runAllTests }) => {
     const results = await runAllTests();
     console.log('Results:', results);
   });
   ```

---

### Option 3: Add TestRunnerScreen to Navigation

1. **Open** `src/navigation/AppNavigator.tsx`
2. **Import** the test screen:
   ```typescript
   import { TestRunnerScreen } from '../testing/TestRunnerScreen';
   ```
3. **Add a route** (temporarily):
   ```typescript
   <Stack.Screen name="TestRunner" component={TestRunnerScreen} />
   ```
4. **Navigate** to it from your app
5. **Tap** "Run All Tests" button
6. **View** results in the app
7. **Remove** before production

---

## 📊 What the Tests Do

### Test Sequence:
1. **Sign Up Valid** - Creates test1@homeheros.test
2. **Sign Up Duplicate** - Tries to create same user again
3. **Sign In Valid** - Signs in with correct password
4. **Sign In Invalid Password** - Tries wrong password
5. **Sign In Non-Existent** - Tries non-existent email
6. **Session Persistence** - Verifies session stays active
7. **Sign Out** - Signs out and verifies session cleared

### Total Duration: ~8-10 seconds

---

## 🔍 What to Watch For

### Good Signs (All Tests Pass):
```
✅ PASS - Sign Up Valid
✅ PASS - Sign Up Duplicate
✅ PASS - Sign In Valid
✅ PASS - Sign In Invalid Password
✅ PASS - Sign In Non-Existent
✅ PASS - Session Persistence
✅ PASS - Sign Out

📊 Test Summary:
   Total: 7
   Passed: 7
   Failed: 0
   Success Rate: 100.0%
```

### Issues to Watch:
```
❌ FAIL - Sign Up Valid
   Profile not created after sign up
```
**Meaning**: Trigger failed and fallback also failed. Check RLS policies.

```
❌ FAIL - Sign In Valid
   Profile not found after sign in
```
**Meaning**: User exists but no profile. Fallback should create it.

```
❌ FAIL - Session Persistence
   Session not persisted
```
**Meaning**: expo-secure-store issue or session management problem.

---

## 🐛 If Tests Fail

### Profile Not Created
1. Check Supabase dashboard → Table Editor → profiles
2. Verify trigger exists: SQL Editor → `SELECT * FROM pg_trigger WHERE tgname = 'on_auth_user_created';`
3. Check RLS policies allow INSERT

### Sign In Fails
1. Verify email confirmation is disabled in Supabase
2. Check user exists in auth.users
3. Delete any unconfirmed users

### Session Issues
1. Check expo-secure-store is installed
2. Verify no console errors
3. Try clearing app data and reinstalling

---

## 🧹 After Testing

### Clean Up Test Users
Go to Supabase Dashboard:
1. **Authentication → Users**
2. **Search**: `@homeheros.test`
3. **Delete** all test users:
   - test1@homeheros.test
   - test2@homeheros.test
   - test3@homeheros.test
   - test4@homeheros.test
   - test5@homeheros.test

### Remove Test Code
If you added to App.tsx:
```typescript
// Remove this line:
import './testing/run-tests-in-app';
```

If you added TestRunnerScreen to navigation:
- Remove the import
- Remove the route

---

## 📝 Manual Testing Alternative

If automated tests don't work, follow:
- **[manual-test-checklist.md](./manual-test-checklist.md)** - Step-by-step manual tests
- **[QUICK-START.md](./QUICK-START.md)** - 5-minute quick test

---

## 🎯 Current Status

**App**: ✅ Running in iOS Simulator
**Tests**: ✅ Ready to run
**Method**: Choose Option 1, 2, or 3 above

**Recommended**: Option 1 (Add to App.tsx) - Easiest and fastest!

---

## 💡 Pro Tip

Run tests in this order:
1. **First**: Automated tests (this file)
2. **Then**: Quick manual test (QUICK-START.md)
3. **Finally**: Full manual test if needed (manual-test-checklist.md)

This gives you confidence at each level!

---

**Ready to run? Choose an option above and start testing! 🚀**
