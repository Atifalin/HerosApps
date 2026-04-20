# 🔧 Fix Supabase Password Reset Redirect URL

## Problem

Password reset emails are redirecting to `http://localhost:3000` instead of the mobile app.

**Current redirect:**
```
https://vttzuaerdwagipyocpha.supabase.co/auth/v1/verify?token=...&redirect_to=http://localhost:3000
```

**Should redirect to:**
- Customer App: `homeheros://reset-password`
- GO App: `homeheros-go://reset-password`

---

## Solution 1: Update Supabase Site URL (Quick Fix)

### Step 1: Go to Supabase Dashboard

https://supabase.com/dashboard/project/vttzuaerdwagipyocpha/settings/auth

### Step 2: Update Site URL

Scroll to **"Site URL"** section and change:

**From:**
```
http://localhost:3000
```

**To:**
```
https://homeheros.ca
```

### Step 3: Add Redirect URLs

Scroll to **"Redirect URLs"** section and add these URLs (one per line):

```
homeheros://reset-password
homeheros-go://reset-password
https://homeheros.ca/reset-password
http://localhost:3000
```

### Step 4: Save Configuration

Click **"Save"** at the bottom of the page.

---

## Solution 2: Update Code to Specify Redirect (Already Done!)

The code already specifies the redirect URL:

**Customer App:**
```typescript
await supabase.auth.resetPasswordForEmail(email, {
  redirectTo: 'homeheros://reset-password',
});
```

**GO App:**
```typescript
await supabase.auth.resetPasswordForEmail(email, {
  redirectTo: 'homeheros-go://reset-password',
});
```

But Supabase might be overriding this with the Site URL setting.

---

## Solution 3: Create Password Reset Handler Screen

Since the email link goes to Supabase first, then redirects, we need to handle the deep link properly.

### For Customer App:

Create `/src/screens/auth/ResetPasswordScreen.tsx`:

```typescript
import React, { useState, useEffect } from 'react';
import {
  View,
  Text,
  TextInput,
  TouchableOpacity,
  StyleSheet,
  Alert,
} from 'react-native';
import { supabase } from '../../lib/supabase';

export const ResetPasswordScreen = ({ route, navigation }: any) => {
  const [password, setPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [loading, setLoading] = useState(false);

  const handleResetPassword = async () => {
    if (!password || !confirmPassword) {
      Alert.alert('Error', 'Please fill in all fields');
      return;
    }

    if (password !== confirmPassword) {
      Alert.alert('Error', 'Passwords do not match');
      return;
    }

    if (password.length < 6) {
      Alert.alert('Error', 'Password must be at least 6 characters');
      return;
    }

    setLoading(true);
    try {
      const { error } = await supabase.auth.updateUser({
        password: password,
      });

      setLoading(false);

      if (error) {
        Alert.alert('Error', error.message);
      } else {
        Alert.alert(
          'Success',
          'Your password has been reset successfully!',
          [
            {
              text: 'OK',
              onPress: () => navigation.navigate('Login'),
            },
          ]
        );
      }
    } catch (err) {
      setLoading(false);
      Alert.alert('Error', 'An unexpected error occurred');
    }
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>Reset Password</Text>
      <Text style={styles.subtitle}>Enter your new password</Text>

      <TextInput
        style={styles.input}
        placeholder="New Password"
        value={password}
        onChangeText={setPassword}
        secureTextEntry
        autoCapitalize="none"
      />

      <TextInput
        style={styles.input}
        placeholder="Confirm Password"
        value={confirmPassword}
        onChangeText={setConfirmPassword}
        secureTextEntry
        autoCapitalize="none"
      />

      <TouchableOpacity
        style={[styles.button, loading && styles.buttonDisabled]}
        onPress={handleResetPassword}
        disabled={loading}
      >
        <Text style={styles.buttonText}>
          {loading ? 'Resetting...' : 'Reset Password'}
        </Text>
      </TouchableOpacity>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    padding: 20,
    justifyContent: 'center',
    backgroundColor: '#fff',
  },
  title: {
    fontSize: 28,
    fontWeight: 'bold',
    color: '#333',
    marginBottom: 8,
    textAlign: 'center',
  },
  subtitle: {
    fontSize: 16,
    color: '#666',
    marginBottom: 40,
    textAlign: 'center',
  },
  input: {
    borderWidth: 1,
    borderColor: '#ddd',
    borderRadius: 8,
    padding: 16,
    fontSize: 16,
    backgroundColor: '#f9f9f9',
    marginBottom: 16,
  },
  button: {
    backgroundColor: '#007AFF',
    borderRadius: 8,
    padding: 16,
    alignItems: 'center',
    marginTop: 20,
  },
  buttonDisabled: {
    backgroundColor: '#ccc',
  },
  buttonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '600',
  },
});
```

---

## Quick Fix for Now

**Just update the Site URL in Supabase:**

1. Go to: https://supabase.com/dashboard/project/vttzuaerdwagipyocpha/settings/auth
2. Find "Site URL"
3. Change from `http://localhost:3000` to `https://homeheros.ca`
4. Add redirect URLs (see above)
5. Click Save

**Then test again!**

---

## Testing After Fix

1. Request password reset from app
2. Check email
3. Click link in email
4. Should redirect to mobile app (or web if on desktop)
5. Enter new password
6. Sign in with new password

---

**Status:** Email sending works! ✅
**Issue:** Wrong redirect URL ⚠️
**Fix:** Update Supabase Site URL (5 minutes)
