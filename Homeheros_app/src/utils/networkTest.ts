// Test network connectivity to Supabase
export const testNetworkConnectivity = async () => {
  try {
    console.log('Testing network connectivity to Supabase...');
    
    // Use environment variables to get the correct Supabase URL
    const SUPABASE_URL = process.env.EXPO_PUBLIC_SUPABASE_URL || 'http://127.0.0.1:54321';
    const SUPABASE_ANON_KEY = process.env.EXPO_PUBLIC_SUPABASE_KEY || 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0';
    
    // Test basic HTTP connectivity to Supabase
    const response = await fetch(`${SUPABASE_URL}/rest/v1/`, {
      method: 'GET',
      headers: {
        'apikey': SUPABASE_ANON_KEY,
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
        'Content-Type': 'application/json',
      },
    });
    
    console.log('Response status:', response.status);
    console.log('Response headers:', response.headers);
    
    if (response.ok) {
      const text = await response.text();
      console.log('✅ Network connectivity successful');
      console.log('Response:', text);
      return { success: true };
    } else {
      console.log('❌ Network request failed with status:', response.status);
      return { success: false, status: response.status };
    }
  } catch (error) {
    console.log('❌ Network connectivity test failed:', error);
    return { success: false, error };
  }
};
