// Test authentication using direct fetch instead of Supabase client
export const testDirectAuth = async (email: string, password: string) => {
  // Use a realistic email format for testing
  const testEmail = email.includes('@') && email.includes('.') ? email : 'user@gmail.com';
  try {
    console.log('🧪 Testing direct auth with fetch...');
    
    const response = await fetch('https://vttzuaerdwagipyocpha.supabase.co/auth/v1/signup', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'apikey': process.env.EXPO_PUBLIC_SUPABASE_KEY || '',
      },
      body: JSON.stringify({
        email: testEmail,
        password,
      }),
    });
    
    console.log('Direct auth response status:', response.status);
    console.log('Direct auth response headers:', Object.fromEntries(response.headers.entries()));
    
    const responseText = await response.text();
    console.log('Direct auth response body:', responseText);
    
    if (response.ok) {
      console.log('✅ Direct auth successful!');
      return { success: true, data: JSON.parse(responseText) };
    } else {
      console.log('❌ Direct auth failed');
      return { success: false, error: responseText };
    }
  } catch (error) {
    console.log('❌ Direct auth network error:', error);
    return { success: false, error };
  }
};
