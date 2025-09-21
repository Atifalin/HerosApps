# 🚀 Local Supabase Management Guide

## 🔄 Starting/Stopping Local Supabase

### Start Local Supabase
```bash
cd "/Users/atifali/Code/Paid Apps/Homeheros"
npx supabase start
```

### Stop Local Supabase
```bash
npx supabase stop
```

### Check Status
```bash
npx supabase status
```

## 🔧 Daily Development Workflow

### 1. Start Your Development Session
```bash
# Navigate to project
cd "/Users/atifali/Code/Paid Apps/Homeheros"

# Start local Supabase
npx supabase start

# Start your Expo app
cd Homeheros_app
npx expo start --ios
```

### 2. Access Local Services
- **API**: http://127.0.0.1:54321
- **Studio**: http://127.0.0.1:54323
- **Email Testing**: http://127.0.0.1:54324

### 3. End Your Session
```bash
# Stop Supabase (optional - saves resources)
npx supabase stop
```

## 📱 App Configuration

Your app is configured to automatically use local Supabase when running locally:

**Environment Variables** (`.env` file):
```
EXPO_PUBLIC_SUPABASE_URL=http://127.0.0.1:54321
EXPO_PUBLIC_SUPABASE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0
```

## 🔄 Switching Between Local and Production

### For Local Development (Current Setup)
```bash
# In Homeheros_app/.env
EXPO_PUBLIC_SUPABASE_URL=http://127.0.0.1:54321
EXPO_PUBLIC_SUPABASE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0
```

### For Production/Cloud Supabase
```bash
# In Homeheros_app/.env
EXPO_PUBLIC_SUPABASE_URL=https://vttzuaerdwagipyocpha.supabase.co
EXPO_PUBLIC_SUPABASE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ0dHp1YWVyZHdhZ2lweW9jcGhhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg0Nzc1NDMsImV4cCI6MjA3NDA1MzU0M30.-QyK-_-jrVowVoMFy8IpCeVaeP59VNUCZtRmTD6Pfwc
```

## 💾 Data Persistence

### Local Data Survives Restarts
- Your local database data persists between `supabase stop` and `supabase start`
- Users and profiles you create locally will still be there

### Reset Local Database (if needed)
```bash
npx supabase db reset
```

## 🚀 Quick Start Script

Create this script for easy startup:

**`start-dev.sh`**:
```bash
#!/bin/bash
echo "🚀 Starting HomeHeros Development Environment..."

# Start Supabase
echo "📦 Starting local Supabase..."
npx supabase start

echo "✅ Supabase started!"
echo "📱 Now run: cd Homeheros_app && npx expo start --ios"
echo "🌐 Studio: http://127.0.0.1:54323"
```

Make it executable:
```bash
chmod +x start-dev.sh
./start-dev.sh
```

## 🔧 Troubleshooting

### If Supabase Won't Start
```bash
# Stop all containers
npx supabase stop

# Start fresh
npx supabase start
```

### If Ports Are Busy
```bash
# Check what's using the ports
lsof -i :54321
lsof -i :54323

# Kill processes if needed
kill -9 <PID>
```

### If Database Issues
```bash
# Reset everything
npx supabase db reset
```

## 📝 Development Tips

1. **Always start Supabase first** before your Expo app
2. **Use Studio** to monitor database changes in real-time
3. **Check Inbucket** for email confirmations during testing
4. **Local data is isolated** from production - safe to experiment!

---

**Your local development environment is now fully set up!** 🎉
