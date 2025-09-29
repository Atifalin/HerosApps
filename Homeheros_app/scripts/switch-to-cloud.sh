#!/bin/bash

echo "🌐 Switching to Cloud Supabase..."

cd "Homeheros_app"

# Update .env for cloud
cat > .env << EOF
EXPO_PUBLIC_SUPABASE_URL=https://vttzuaerdwagipyocpha.supabase.co
EXPO_PUBLIC_SUPABASE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ0dHp1YWVyZHdhZ2lweW9jcGhhIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTg0Nzc1NDMsImV4cCI6MjA3NDA1MzU0M30.-QyK-_-jrVowVoMFy8IpCeVaeP59VNUCZtRmTD6Pfwc
EOF

echo "✅ Switched to Cloud Supabase!"
echo "🌐 URL: https://vttzuaerdwagipyocpha.supabase.co"
echo "📱 Ready to run: npx expo start --ios"
