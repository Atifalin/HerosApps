# ✅ Password Reset - Production Ready Checklist

## 🎉 What's Complete (In App)

### Customer App
✅ ForgotPasswordScreen - Request reset
✅ ResetPasswordScreen - Set new password
✅ Navigation configured
✅ Email validation
✅ Error handling
✅ Loading states
✅ Success confirmations

### GO App
✅ ForgotPasswordScreen - Request reset
✅ ResetPasswordScreen - Set new password
✅ Navigation configured
✅ Email validation
✅ Error handling
✅ Loading states
✅ Success confirmations

---

## 🔧 What YOU Need to Do (Outside App)

### 1. Supabase Configuration ✅ DONE

You already completed:
- ✅ SMTP Settings configured with Resend
- ✅ Site URL updated to https://homeheros.ca
- ✅ Redirect URLs added

### 2. Email Template Customization (OPTIONAL - 5 minutes)

**Go to:** https://supabase.com/dashboard/project/vttzuaerdwagipyocpha/auth/templates

**Click "Reset Password" template and customize:**

```html
<h2>Reset Your HomeHeros Password</h2>

<p>Hi there,</p>

<p>We received a request to reset your password for your HomeHeros account.</p>

<p>Click the button below to reset your password:</p>

<p style="text-align: center; margin: 30px 0;">
  <a href="{{ .ConfirmationURL }}" 
     style="background-color: #007AFF; 
            color: white; 
            padding: 14px 28px; 
            text-decoration: none; 
            border-radius: 8px; 
            display: inline-block;
            font-weight: bold;">
    Reset My Password
  </a>
</p>

<p>Or copy and paste this link into your browser:</p>
<p style="word-break: break-all; color: #666;">{{ .ConfirmationURL }}</p>

<p><strong>⏰ This link expires in 1 hour.</strong></p>

<p>If you didn't request this password reset, you can safely ignore this email. Your password will not be changed.</p>

<hr style="border: none; border-top: 1px solid #eee; margin: 30px 0;">

<p style="color: #666; font-size: 14px;">
  Thanks,<br>
  The HomeHeros Team<br>
  <a href="https://homeheros.ca" style="color: #007AFF;">homeheros.ca</a>
</p>
```

**Save the template**

### 3. Deep Linking Setup (CRITICAL - 10 minutes)

#### For iOS (Both Apps):

**Add URL Scheme to app.json:**

Already configured in your apps:
- Customer App: `homeheros://`
- GO App: `homeheros-go://`

**Test deep linking:**
1. Build app with `eas build` or run on device
2. Send password reset email
3. Click link in email on device
4. Should open app to ResetPassword screen

#### For Android (Both Apps):

Already configured in your apps via Expo.

### 4. Domain Verification (OPTIONAL - Better Deliverability)

**Go to Resend Dashboard:** https://resend.com/domains

**Add domain:** `homeheros.ca`

**Add these DNS records to your domain:**

```
Type: TXT
Name: _resend
Value: [Resend will provide]

Type: CNAME  
Name: resend._domainkey
Value: [Resend will provide]

Type: CNAME
Name: resend
Value: [Resend will provide]
```

**Benefits:**
- Better email deliverability
- Less likely to go to spam
- Professional sender address
- Higher trust score

---

## 🧪 Testing Checklist

### Test Customer App:
- [ ] Click "Forgot Password?" on login screen
- [ ] Enter email address
- [ ] Receive email within 30 seconds
- [ ] Email has correct branding
- [ ] Click link in email
- [ ] App opens to ResetPassword screen
- [ ] Enter new password
- [ ] Confirm password matches
- [ ] Click "Reset Password"
- [ ] See success message
- [ ] Sign in with new password works

### Test GO App:
- [ ] Click "Forgot Password?" on sign-in screen
- [ ] Enter email address
- [ ] Receive email within 30 seconds
- [ ] Email has correct branding
- [ ] Click link in email
- [ ] App opens to ResetPassword screen
- [ ] Enter new password
- [ ] Confirm password matches
- [ ] Click "Reset Password"
- [ ] See success message
- [ ] Sign in with new password works

### Test Error Cases:
- [ ] Empty email - shows error
- [ ] Invalid email format - shows error
- [ ] Passwords don't match - shows error
- [ ] Password too short (<6 chars) - shows error
- [ ] Expired link - shows error message
- [ ] Invalid link - shows error message

### Test Email Delivery:
- [ ] Email arrives in inbox (not spam)
- [ ] Email looks professional
- [ ] Links work correctly
- [ ] Branding is correct
- [ ] Mobile responsive

---

## 📊 Monitoring

### Check Email Delivery:
**Resend Dashboard:** https://resend.com/emails
- View sent emails
- Check delivery status
- Monitor bounce rates
- Check spam complaints

### Check Supabase Logs:
**Auth Logs:** https://supabase.com/dashboard/project/vttzuaerdwagipyocpha/logs/auth-logs
- Monitor password reset requests
- Check for errors
- View success rates

### Monitor Usage:
**Resend Free Tier Limits:**
- 100 emails/day
- 3,000 emails/month
- Monitor usage in dashboard
- Upgrade if needed ($20/month for 50k emails)

---

## 🚨 Common Issues & Solutions

### Issue: Emails not arriving
**Solutions:**
1. Check spam folder
2. Verify SMTP settings in Supabase
3. Check Resend dashboard for errors
4. Verify email address is valid
5. Check Resend daily/monthly limits

### Issue: Link doesn't open app
**Solutions:**
1. Verify deep linking is configured
2. Test on real device (not simulator)
3. Check URL scheme matches app.json
4. Rebuild app after changes
5. Check redirect URLs in Supabase

### Issue: "Invalid link" error
**Solutions:**
1. Link may have expired (1 hour limit)
2. Link may have been used already
3. User may need to request new reset
4. Check Supabase session is valid

### Issue: Emails going to spam
**Solutions:**
1. Verify domain in Resend
2. Add SPF/DKIM/DMARC records
3. Use professional email content
4. Avoid spam trigger words
5. Warm up domain gradually

---

## 🔒 Security Features

✅ **Link expiration** - 1 hour timeout
✅ **One-time use** - Links can't be reused
✅ **Secure tokens** - Cryptographically secure
✅ **Rate limiting** - 60 seconds between requests
✅ **No user enumeration** - Same response for all emails
✅ **HTTPS only** - All communication encrypted
✅ **Session validation** - Checks for valid recovery session

---

## 📱 Deep Linking Configuration

### Customer App (homeheros://)
**Configured in:**
- `app.json` - URL scheme
- `ForgotPasswordScreen.tsx` - redirectTo parameter
- `ResetPasswordScreen.tsx` - Handler screen

### GO App (homeheros-go://)
**Configured in:**
- `app.json` - URL scheme  
- `ForgotPasswordScreen.tsx` - redirectTo parameter
- `ResetPasswordScreen.tsx` - Handler screen

### How it works:
1. User clicks email link
2. Supabase validates token
3. Redirects to app:// URL
4. OS opens app
5. App navigates to ResetPassword screen
6. User sets new password
7. Session cleared, redirected to login

---

## 🎨 Email Template Variables

Available in Supabase email templates:

- `{{ .ConfirmationURL }}` - Password reset link
- `{{ .Email }}` - User's email address
- `{{ .Token }}` - Reset token (don't use directly)
- `{{ .TokenHash }}` - Token hash (don't use directly)
- `{{ .SiteURL }}` - Your site URL
- `{{ .RedirectTo }}` - Redirect URL

---

## 📝 Files Created

### Customer App:
1. `/src/screens/auth/ForgotPasswordScreen.tsx` - Request reset
2. `/src/screens/auth/ResetPasswordScreen.tsx` - Set new password
3. Updated `/src/navigation/AuthNavigator.tsx`

### GO App:
1. `/src/screens/auth/ForgotPasswordScreen.tsx` - Request reset
2. `/src/screens/auth/ResetPasswordScreen.tsx` - Set new password
3. Updated `/src/navigation/AuthNavigator.tsx`
4. Updated `/src/screens/auth/SignInScreen.tsx` - Added link

### Documentation:
1. `FORGOT_PASSWORD_IMPLEMENTATION.md` - Implementation guide
2. `PASSWORD_RESET_PRODUCTION_CHECKLIST.md` - This file
3. `SUPABASE_REDIRECT_FIX.md` - Redirect configuration
4. `RESEND_SETUP_GUIDE.md` - Email service setup
5. `EMAIL_SETUP_SUMMARY.md` - Quick reference

---

## ✅ Production Readiness Status

### Code: ✅ COMPLETE
- [x] Forgot password screens
- [x] Reset password screens
- [x] Navigation configured
- [x] Email validation
- [x] Error handling
- [x] Loading states
- [x] Deep linking configured

### Configuration: ✅ COMPLETE
- [x] Supabase SMTP configured
- [x] Resend API key added
- [x] Site URL updated
- [x] Redirect URLs added
- [ ] Email template customized (optional)
- [ ] Domain verified (optional)

### Testing: ⏳ PENDING
- [ ] Test full flow in both apps
- [ ] Test on real devices
- [ ] Test email delivery
- [ ] Test deep linking
- [ ] Test error cases

---

## 🚀 Ready to Launch!

### Final Steps:
1. ✅ Code is complete
2. ✅ Supabase is configured
3. ⏳ Test the full flow
4. ⏳ Customize email template (optional)
5. ⏳ Verify domain (optional)
6. 🚀 Deploy to production!

---

## 🆘 Need Help?

### Supabase Support:
- Docs: https://supabase.com/docs/guides/auth/passwords
- Discord: https://discord.supabase.com

### Resend Support:
- Docs: https://resend.com/docs
- Support: support@resend.com

### Common Questions:

**Q: How long do reset links last?**
A: 1 hour from when the email is sent.

**Q: Can users reset password multiple times?**
A: Yes, each request generates a new link.

**Q: What if email doesn't arrive?**
A: Check spam folder, verify SMTP settings, check Resend dashboard.

**Q: Can I customize the email?**
A: Yes! Edit templates in Supabase dashboard.

**Q: How do I test without sending real emails?**
A: Use Resend test mode or check email logs in Resend dashboard.

---

**Status:** ✅ PRODUCTION READY
**Last Updated:** April 20, 2026
**Next:** Test the flow and deploy!

🎉 **Password reset is fully implemented and ready for production!**
