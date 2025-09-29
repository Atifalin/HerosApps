#!/bin/bash

echo "🏠 Switching to Local Supabase..."

# Start local Supabase if not running
echo "📦 Starting local Supabase..."
npx supabase start

cd "Homeheros_app"

# Update .env for local
cat > .env << EOF
EXPO_PUBLIC_SUPABASE_URL=http://127.0.0.1:54321
EXPO_PUBLIC_SUPABASE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0
EOF

echo "✅ Switched to Local Supabase!"
echo "🏠 URL: http://127.0.0.1:54321"
echo "🌐 Studio: http://127.0.0.1:54323"
echo "📱 Ready to run: npx expo start --ios"
