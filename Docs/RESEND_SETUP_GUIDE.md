# 📧 Resend Email Setup Guide for Supabase

## Step-by-Step Configuration

### 1. Access Supabase Dashboard

1. Go to: https://supabase.com/dashboard/project/vttzuaerdwagipyocpha
2. Sign in with your Supabase account
3. Navigate to: **Project Settings** (gear icon in sidebar)

### 2. Configure SMTP Settings

1. In Project Settings, click **Authentication** in the left sidebar
2. Scroll down to **SMTP Settings** section
3. Click **Enable Custom SMTP**

### 3. Enter Resend Configuration

Fill in the following details:

```
Enable Custom SMTP: ✅ ON

Sender name: HomeHeros
Sender email: noreply@homeheros.ca

Host: smtp.resend.com
Port number: 465
Username: resend
Password: re_Uq1EP6pb_2vU5WHXJo9aExJK9BpsNa7Qq

Minimum interval between emails being sent: 60 (seconds)
```

### 4. Save Configuration

1. Click **Save** at the bottom of the page
2. Wait for confirmation message

### 5. Test Email Delivery

#### Option A: Test via Supabase Dashboard

1. Go to **Authentication** → **Users**
2. Click **Invite User**
3. Enter a test email address
4. Check if email is received

#### Option B: Test via SQL

Run this in SQL Editor:

```sql
-- Test password reset email
SELECT auth.send_password_reset_email('your-test-email@example.com');
```

#### Option C: Test via App

1. Open the HomeHeros app
2. Try to sign up with a new email
3. Check if confirmation email arrives
4. Try "Forgot Password" feature

### 6. Customize Email Templates

1. In Supabase Dashboard, go to **Authentication** → **Email Templates**
2. Customize these templates:

#### Confirm Signup Template
```html
<h2>Welcome to HomeHeros!</h2>
<p>Click the link below to confirm your email address:</p>
<p><a href="{{ .ConfirmationURL }}">Confirm Email</a></p>
<p>If you didn't create an account, you can safely ignore this email.</p>
```

#### Reset Password Template
```html
<h2>Reset Your Password</h2>
<p>Click the link below to reset your password:</p>
<p><a href="{{ .ConfirmationURL }}">Reset Password</a></p>
<p>If you didn't request this, you can safely ignore this email.</p>
<p>This link expires in 1 hour.</p>
```

#### Magic Link Template
```html
<h2>Sign in to HomeHeros</h2>
<p>Click the link below to sign in:</p>
<p><a href="{{ .ConfirmationURL }}">Sign In</a></p>
<p>If you didn't request this, you can safely ignore this email.</p>
```

### 7. Configure Email Rate Limits

In **Authentication** settings:

```
Rate Limits:
- Max frequency: 1 email per 60 seconds per user
- This prevents spam and abuse
```

### 8. Verify Sender Domain (Optional but Recommended)

For better deliverability:

1. Go to Resend Dashboard: https://resend.com/domains
2. Add your domain: `homeheros.ca`
3. Add DNS records provided by Resend
4. Wait for verification (usually 5-10 minutes)
5. Update Sender email in Supabase to use verified domain

### 9. Monitor Email Delivery

**In Resend Dashboard:**
- View sent emails: https://resend.com/emails
- Check delivery status
- View bounce/complaint rates

**In Supabase Dashboard:**
- Check auth logs for email-related errors
- Monitor user signup success rates

---

## Troubleshooting

### Emails Not Sending

1. **Check SMTP credentials** - Verify API key is correct
2. **Check Resend dashboard** - Look for errors or blocks
3. **Check spam folder** - Emails might be filtered
4. **Verify sender email** - Must match verified domain

### Emails Going to Spam

1. **Verify domain** - Add SPF, DKIM, DMARC records
2. **Use professional content** - Avoid spam trigger words
3. **Warm up domain** - Start with low volume, increase gradually
4. **Monitor reputation** - Check Resend dashboard for issues

### Rate Limit Errors

1. **Increase minimum interval** - Set to 120 seconds if needed
2. **Check Resend limits** - Free tier: 100 emails/day, 3000/month
3. **Upgrade plan** - If hitting limits regularly

---

## Current Configuration Summary

✅ **Service:** Resend  
✅ **API Key:** Stored in `Docs/api-keys.md` (gitignored)  
✅ **Free Tier:** 3,000 emails/month, 100 emails/day  
✅ **SMTP Host:** smtp.resend.com  
✅ **Port:** 465 (SSL)  
✅ **Sender:** noreply@homeheros.ca  

---

## Next Steps After Setup

1. ✅ Configure SMTP in Supabase (follow steps above)
2. ✅ Test email delivery
3. ✅ Customize email templates
4. ✅ Verify domain for better deliverability
5. ✅ Monitor first 100 emails for issues
6. ✅ Set up alerts for delivery failures

---

## Production Checklist

Before going live:

- [ ] SMTP configured in Supabase
- [ ] Test emails received successfully
- [ ] Email templates customized with branding
- [ ] Domain verified in Resend
- [ ] SPF/DKIM/DMARC records added
- [ ] Rate limits configured appropriately
- [ ] Monitoring set up in Resend dashboard
- [ ] Backup email service configured (optional)

---

**Last Updated:** April 20, 2026  
**Resend Account:** https://resend.com/dashboard  
**Supabase Project:** vttzuaerdwagipyocpha
