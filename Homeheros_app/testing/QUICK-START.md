# 🚀 Quick Start Testing Guide

## What's Ready

✅ **iOS Simulator**: Running (iPhone 17)
✅ **App**: Starting via Expo Go
✅ **Test Scripts**: All created in `/testing` folder
✅ **Supabase**: Connected to production

---

## 📋 Test Now (5 Minutes)

### 1. Sign Up Test (2 min)
```
Email: test1@homeheros.test
Password: Test123!
Confirm: Test123!
```

**Expected**: 
- ✅ Success alert
- ✅ Console: "Profile already exists (created by trigger)" OR "Profile created successfully via fallback"
- ✅ Redirected to sign-in

### 2. Duplicate Email Test (30 sec)
```
Try signing up with test1@homeheros.test again
```

**Expected**:
- ✅ Alert: "Account Already Exists"
- ✅ Option to navigate to sign-in

### 3. Sign In Test (1 min)
```
Email: test1@homeheros.test
Password: Test123!
```

**Expected**:
- ✅ Authenticated
- ✅ Home screen shown
- ✅ Console: "Sign in successful"

### 4. Wrong Password Test (30 sec)
```
Email: test1@homeheros.test
Password: WrongPassword123!
```

**Expected**:
- ✅ Alert: "Invalid email or password"
- ✅ Stays on sign-in screen

### 5. Session Persistence Test (1 min)
```
1. Sign in successfully
2. Close app (Cmd+Q on simulator)
3. Reopen app
```

**Expected**:
- ✅ Still signed in
- ✅ Home screen shown immediately

---

## 🔍 What to Watch

### Console Logs (Good)
```
✅ "Signup successful: { user: [uuid], session: 'present' }"
✅ "Profile already exists (created by trigger)"
✅ "Sign in successful: { user: [uuid], session: 'present' }"
```

### Console Logs (Issues)
```
⚠️ "Profile not found, creating manually..." (fallback working)
❌ "Failed to create profile:" (CRITICAL)
❌ "Sign in returned no error but also no session" (unconfirmed user)
```

---

## 📊 Verify in Supabase

After each test:
1. Open Supabase Dashboard
2. Go to **Authentication → Users**
3. Verify user exists
4. Go to **Table Editor → profiles**
5. Verify profile exists with:
   - ✅ Correct email
   - ✅ role = 'customer'
   - ✅ status = 'active'

---

## 📁 Test Files Created

All in `/testing` folder:

1. **auth-test-plan.md** - Full test plan (15 scenarios)
2. **manual-test-checklist.md** - Step-by-step checklist
3. **automated-auth-tests.ts** - Automated test functions
4. **TestRunnerScreen.tsx** - In-app test runner
5. **README.md** - Complete documentation
6. **test-execution-log.md** - Execution tracking
7. **QUICK-START.md** - This file

---

## 🧹 Cleanup After Testing

```bash
# In Supabase Dashboard:
1. Authentication → Users
2. Search: @homeheros.test
3. Delete all test users
4. Verify profiles also deleted
```

---

## ⚡ Fast Track (30 seconds)

Just want to verify it works?

1. **Sign Up**: test1@homeheros.test / Test123!
2. **Check Console**: Should see "Signup successful"
3. **Sign In**: Same credentials
4. **Check Home**: Should see home screen

**Done!** ✅

---

## 🐛 If Something Fails

### Profile Not Created
- Check console for "Failed to create profile"
- Verify trigger exists in Supabase
- Fallback should still work

### Can't Sign In
- Check if email confirmation is disabled in Supabase
- Verify user exists in auth.users
- Check for "Email not confirmed" error

### Session Not Persisting
- Check expo-secure-store is installed
- Verify no errors in console
- Try sign in/out cycle again

---

## 📞 Need More Details?

- **Full Test Plan**: `auth-test-plan.md`
- **Step-by-Step**: `manual-test-checklist.md`
- **Documentation**: `README.md`
- **Automated Tests**: `automated-auth-tests.ts`

---

## ✅ Current Status

**App**: Loading in iOS Simulator
**Ready**: YES
**Next**: Start testing with test1@homeheros.test

**Good luck! 🚀**
