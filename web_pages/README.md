# HomeHeros Web Pages

Static HTML pages hosted on GoDaddy as fail-safes for mobile-app flows that originate from email links on desktop browsers.

## Files

### `reset-password.html`
Password reset fallback page for users who click the email link on a desktop browser (where mobile deep links do not work).

**Upload to:** `https://homeheros.ca/reset-password.html`

**Also configure the path** `https://homeheros.ca/reset-password` to serve this file (either rename to `reset-password/index.html` or configure GoDaddy URL rewriting).

## How It Works

1. User on desktop requests a password reset from the mobile app.
2. Supabase sends an email with a link like:
   `https://vttzuaerdwagipyocpha.supabase.co/auth/v1/verify?token=...&type=recovery&redirect_to=https://homeheros.ca/reset-password`
3. User clicks the link → Supabase validates the token.
4. Supabase redirects to `https://homeheros.ca/reset-password#access_token=...&refresh_token=...&type=recovery`.
5. This page's embedded Supabase JS client reads the tokens from the URL hash and lets the user set a new password.
6. On success, the user is signed out and instructed to return to the mobile app.

## Security Notes

- The anon key embedded in the page is safe — it's designed to be public. All write access is governed by Row Level Security policies in Supabase.
- `updateUser({ password })` requires a valid recovery session (created from the email link), so attackers cannot change arbitrary users' passwords.
- Recovery links expire after 1 hour and are one-time use.

## GoDaddy Upload Steps

1. Log in to your GoDaddy hosting control panel → **cPanel / File Manager**.
2. Navigate to `public_html` (or your site's root directory).
3. Upload `reset-password.html` directly into `public_html/`, **or**:
   - Create a folder `reset-password/`.
   - Upload the file as `reset-password/index.html`.
   - This lets the URL `https://homeheros.ca/reset-password` work without the `.html` extension.
4. Make the file accessible (permissions 644).
5. Test by visiting `https://homeheros.ca/reset-password` in your browser — you should see the form (it will show an error about invalid link because no token was provided, which is expected).

## Testing End-to-End

1. In the mobile app, request a password reset.
2. On a desktop, click the link in the email.
3. You should be taken to this page with a valid recovery token in the URL hash.
4. Enter a new password and submit.
5. You should see a success message.
6. Return to the mobile app and sign in with the new password.
