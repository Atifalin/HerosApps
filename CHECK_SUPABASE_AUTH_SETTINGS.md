# 🔍 Check Supabase Authentication Settings

## Issue
Even valid email formats like `test@example.com` are being rejected as "invalid".

## Possible Causes

### 1. Email Confirmation Settings
- Go to **Supabase Dashboard** → **Authentication** → **Settings**
- Check if **"Enable email confirmations"** is turned ON
- If ON, users need to verify email before account is active

### 2. Email Domain Restrictions
- Check if there are any **domain allowlists** or **blocklists**
- Some organizations block common test domains like `example.com`

### 3. Email Provider Validation
- Supabase might be using strict email validation that checks if the domain actually exists
- `example.com` is a reserved domain that might be blocked

## 🔧 Quick Fixes to Try

### Option 1: Try Real Email Domains
Test with these email formats:
- ✅ `testuser@gmail.com`
- ✅ `demo@outlook.com`
- ✅ `user123@yahoo.com`

### Option 2: Disable Email Confirmation (Temporary)
1. Go to **Authentication** → **Settings**
2. Turn OFF **"Enable email confirmations"**
3. Save settings
4. Test signup again

### Option 3: Check Email Templates
1. Go to **Authentication** → **Email Templates**
2. Make sure templates are properly configured
3. Check if there are any validation rules

## 🧪 Test Commands

Try these emails in your app:
```
testuser@gmail.com
demo@outlook.com
user123@yahoo.com
```

## Expected Behavior
- If email confirmation is ON: User created but needs to verify email
- If email confirmation is OFF: User created and can login immediately

## Next Steps
1. Check authentication settings in Supabase dashboard
2. Try with real email domains
3. Test with email confirmation disabled
4. If still failing, check Supabase project logs
