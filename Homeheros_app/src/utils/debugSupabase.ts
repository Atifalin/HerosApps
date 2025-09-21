// Debug Supabase configuration and connectivity
import { supabase } from '../lib/supabase';

export const debugSupabaseSetup = async () => {
  console.log('🔍 Debugging Supabase Setup...');
  
  // 1. Check environment variables
  console.log('Environment Variables:');
  console.log('EXPO_PUBLIC_SUPABASE_URL:', process.env.EXPO_PUBLIC_SUPABASE_URL);
  console.log('EXPO_PUBLIC_SUPABASE_KEY length:', process.env.EXPO_PUBLIC_SUPABASE_KEY?.length);
  
  // 2. Test basic REST API connectivity
  try {
    console.log('Testing REST API connectivity...');
    const response = await fetch('https://vttzuaerdwagipyocpha.supabase.co/rest/v1/profiles?select=count', {
      method: 'GET',
      headers: {
        'apikey': process.env.EXPO_PUBLIC_SUPABASE_KEY || '',
        'Authorization': `Bearer ${process.env.EXPO_PUBLIC_SUPABASE_KEY || ''}`,
        'Content-Type': 'application/json',
        'Prefer': 'count=exact'
      },
    });
    
    console.log('REST API Response Status:', response.status);
    if (response.ok) {
      const data = await response.text();
      console.log('✅ REST API working, Response:', data);
    } else {
      const errorText = await response.text();
      console.log('❌ REST API Error:', errorText);
    }
  } catch (error) {
    console.log('❌ REST API Network Error:', error);
  }
  
  // 3. Test Supabase Auth endpoint specifically
  try {
    console.log('Testing Auth API connectivity...');
    const authResponse = await fetch('https://vttzuaerdwagipyocpha.supabase.co/auth/v1/signup', {
      method: 'POST',
      headers: {
        'apikey': process.env.EXPO_PUBLIC_SUPABASE_KEY || '',
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        email: 'test@example.com',
        password: 'testpassword123'
      }),
    });
    
    console.log('Auth API Response Status:', authResponse.status);
    const authData = await authResponse.text();
    console.log('Auth API Response:', authData);
    
    if (authResponse.status === 422) {
      console.log('✅ Auth API is reachable (422 = validation error, which is expected for test data)');
    } else if (authResponse.ok) {
      console.log('✅ Auth API working');
    }
  } catch (error) {
    console.log('❌ Auth API Network Error:', error);
  }
  
  // 4. Test Supabase client initialization
  try {
    console.log('Testing Supabase client...');
    const { data, error } = await supabase.from('profiles').select('count').limit(1);
    if (error) {
      console.log('Supabase client error (might be expected):', error.message);
    } else {
      console.log('✅ Supabase client working:', data);
    }
  } catch (error) {
    console.log('❌ Supabase client error:', error);
  }
};
