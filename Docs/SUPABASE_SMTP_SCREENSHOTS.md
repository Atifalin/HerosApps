# 📸 Supabase SMTP Configuration - Visual Guide

## Quick Reference: What to Click Where

### Step 1: Open Supabase Dashboard
```
URL: https://supabase.com/dashboard/project/vttzuaerdwagipyocpha
```

### Step 2: Navigate to Settings
```
Left Sidebar → Click the ⚙️ (gear icon) at the bottom
This opens "Project Settings"
```

### Step 3: Go to Authentication Settings
```
In Project Settings sidebar (left side):
Click "Authentication"
```

### Step 4: Scroll to SMTP Settings
```
Scroll down the page until you see:
"SMTP Settings" section
```

### Step 5: Enable Custom SMTP
```
Toggle switch: "Enable Custom SMTP" → Turn it ON (blue)
```

### Step 6: Fill in the Form

Copy and paste these exact values:

#### Sender Details
```
Sender name: HomeHeros
Sender email: noreply@homeheros.ca
```

#### SMTP Server Details
```
Host: smtp.resend.com
Port number: 465
```

#### Authentication
```
Username: resend
Password: re_Uq1EP6pb_2vU5WHXJo9aExJK9BpsNa7Qq
```

#### Rate Limiting
```
Minimum interval between emails being sent: 60
(This means 60 seconds between emails to the same user)
```

### Step 7: Save Configuration
```
Scroll to bottom of page
Click green "Save" button
Wait for success message (green toast notification)
```

---

## What Each Field Means

### Sender Name
- **What it is:** The name that appears in the "From" field
- **Example:** When users receive email, they see "HomeHeros"
- **Best practice:** Use your app/company name

### Sender Email
- **What it is:** The email address emails come from
- **Example:** noreply@homeheros.ca
- **Best practice:** Use noreply@ or support@ with your domain

### Host
- **What it is:** The SMTP server address
- **For Resend:** Always `smtp.resend.com`
- **Don't change this**

### Port Number
- **What it is:** The connection port for SMTP
- **For Resend:** Use `465` (SSL/TLS)
- **Alternative:** `587` (STARTTLS) also works

### Username
- **What it is:** SMTP authentication username
- **For Resend:** Always `resend`
- **Don't change this**

### Password
- **What it is:** Your Resend API key
- **Security:** This is sensitive - never share publicly
- **Format:** Starts with `re_`

### Minimum Interval
- **What it is:** Seconds to wait between emails to same user
- **Purpose:** Prevents spam and abuse
- **Recommended:** 60 seconds (1 minute)

---

## After Saving - What Happens?

### Immediate Changes
✅ Supabase will now use Resend for ALL auth emails:
- Signup confirmation emails
- Password reset emails
- Magic link emails
- Email change confirmations

### What Supabase Does Automatically
✅ Validates SMTP connection
✅ Tests credentials
✅ Shows error if configuration is wrong
✅ Saves settings if everything is correct

---

## Testing Your Configuration

### Method 1: Quick Test (Recommended)

1. **Open SQL Editor** in Supabase
   - Left sidebar → SQL Editor
   - Click "New query"

2. **Run this command:**
   ```sql
   SELECT auth.send_password_reset_email('your-email@example.com');
   ```
   Replace `your-email@example.com` with your actual email

3. **Check your inbox**
   - Should receive email within 30 seconds
   - Check spam folder if not in inbox

### Method 2: Test via App

1. **Open HomeHeros app**
2. **Try to sign up** with a new email
3. **Check for confirmation email**
4. **Try "Forgot Password"** feature
5. **Verify email arrives**

### Method 3: Check Resend Dashboard

1. **Go to:** https://resend.com/emails
2. **View recent emails** sent
3. **Check delivery status**
4. **Look for any errors**

---

## Common Issues & Solutions

### Issue: "Invalid SMTP credentials"
**Solution:**
- Double-check API key is copied correctly
- Make sure no extra spaces before/after
- Verify API key is active in Resend dashboard

### Issue: "Connection timeout"
**Solution:**
- Check port number is 465
- Try port 587 as alternative
- Verify host is `smtp.resend.com`

### Issue: Emails not arriving
**Solution:**
- Check spam/junk folder
- Verify sender email format is correct
- Check Resend dashboard for delivery status
- Verify you haven't hit rate limits

### Issue: "Rate limit exceeded"
**Solution:**
- Wait 60 seconds between test emails
- Check Resend free tier limits (100/day)
- Upgrade Resend plan if needed

---

## Visual Checklist

Before clicking Save, verify:

```
✅ Enable Custom SMTP toggle is ON (blue)
✅ Sender name: HomeHeros
✅ Sender email: noreply@homeheros.ca
✅ Host: smtp.resend.com
✅ Port: 465
✅ Username: resend
✅ Password: re_Uq1EP6pb_2vU5WHXJo9aExJK9BpsNa7Qq
✅ Minimum interval: 60
```

---

## What to Do After Configuration

### Immediate (Next 5 minutes)
1. ✅ Click Save
2. ✅ Wait for success message
3. ✅ Test with SQL command
4. ✅ Check email arrives

### Short Term (Next hour)
1. ✅ Customize email templates
2. ✅ Test signup flow in app
3. ✅ Test password reset flow
4. ✅ Verify emails look professional

### Long Term (Next week)
1. ✅ Monitor delivery rates in Resend
2. ✅ Set up domain verification
3. ✅ Add SPF/DKIM records
4. ✅ Monitor for spam complaints

---

## Quick Reference Card

**Copy this for easy access:**

```
SUPABASE SMTP CONFIGURATION
============================
Service: Resend
Host: smtp.resend.com
Port: 465
Username: resend
Password: re_Uq1EP6pb_2vU5WHXJo9aExJK9BpsNa7Qq
Sender: noreply@homeheros.ca
Name: HomeHeros
Rate Limit: 60 seconds

Dashboard: https://resend.com/dashboard
Supabase: https://supabase.com/dashboard/project/vttzuaerdwagipyocpha
```

---

**Configuration Time:** ~5 minutes  
**Testing Time:** ~2 minutes  
**Total Setup Time:** ~7 minutes  

**You're ready to go! 🚀**
