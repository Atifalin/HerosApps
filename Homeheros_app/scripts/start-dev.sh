#!/bin/bash

echo "🚀 Starting HomeHeros Development Environment..."
echo ""

# Navigate to project directory
cd "/Users/atifali/Code/Paid Apps/Homeheros"

# Start Supabase
echo "📦 Starting local Supabase..."
npx supabase start

echo ""
echo "✅ Local Supabase is running!"
echo ""
echo "🌐 Available Services:"
echo "   • API: http://127.0.0.1:54321"
echo "   • Studio: http://127.0.0.1:54323"
echo "   • Email Testing: http://127.0.0.1:54324"
echo ""
echo "📱 Next steps:"
echo "   1. cd Homeheros_app"
echo "   2. npx expo start --ios"
echo ""
echo "🎉 Happy coding!"
