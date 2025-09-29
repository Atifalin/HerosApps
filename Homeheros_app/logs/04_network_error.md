# 🛠️ Fix for Network Request Failed Error

## 🔍 Problem Identified

Your app is showing `Network request failed` errors when trying to connect to Supabase. This is happening because:

1. **Docker is not running** - Docker Desktop is required for local Supabase
2. **Local Supabase is not started** - The services need to be running
3. **App is trying to connect to Supabase** - But can't reach it

## 🚀 Solution Steps

### 1️⃣ Start Docker Desktop

```bash
# Open Docker Desktop application on your Mac
# Wait until it's fully started (whale icon in menu bar is solid)
```

### 2️⃣ Start Local Supabase

```bash
# Run this command in your terminal
cd "/Users/atifali/Code/Paid Apps/Homeheros"
bash start-dev.sh
```

You should see output confirming Supabase is running:
```
✅ Local Supabase is running!
🌐 Available Services:
   • API: http://127.0.0.1:54321
   • Studio: http://127.0.0.1:54323
   • Email Testing: http://127.0.0.1:54324
```

### 3️⃣ Ensure App Uses Local Supabase

```bash
# Run this command to configure app for local Supabase
cd "/Users/atifali/Code/Paid Apps/Homeheros"
bash switch-to-local.sh
```

### 4️⃣ Start Your App

```bash
cd "/Users/atifali/Code/Paid Apps/Homeheros/Homeheros_app"
npx expo start --ios
```

## 🔄 Switching Between Local and Cloud

### For Local Development:
```bash
bash switch-to-local.sh
```

### For Cloud Testing:
```bash
bash switch-to-cloud.sh
```

## 🔍 Verifying Connection

You can verify your Supabase connection is working by:

1. Opening Supabase Studio: http://127.0.0.1:54323
2. Checking the app logs for successful authentication
3. Testing login with test@test.com (password: password123)

## 🧪 Troubleshooting

If you still see network errors:

1. **Check Docker** - Make sure Docker Desktop is running
2. **Restart Supabase** - Try `npx supabase stop` then `npx supabase start`
3. **Check Ports** - Ensure nothing else is using ports 54321, 54323, 54324
4. **Check Firewall** - Ensure your firewall allows local connections
5. **Restart Metro** - Stop and restart your Expo development server

## 🔌 Alternative: Use Cloud Supabase

If local development is problematic, you can temporarily use the cloud instance:

```bash
bash switch-to-cloud.sh
```

This will configure your app to use the production Supabase instance instead of local.
