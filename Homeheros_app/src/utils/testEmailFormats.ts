// Test different email formats to understand Supabase validation
export const testEmailFormats = async () => {
  const testEmails = [
    'user@gmail.com',
    'test@outlook.com', 
    'demo@yahoo.com',
    'admin@company.com',
    'user123@hotmail.com',
    'testuser@protonmail.com',
    'demo@icloud.com',
    'user@live.com'
  ];

  console.log('🧪 Testing different email formats...');

  for (const email of testEmails) {
    try {
      console.log(`Testing: ${email}`);
      
      const response = await fetch('https://vttzuaerdwagipyocpha.supabase.co/auth/v1/signup', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'apikey': process.env.EXPO_PUBLIC_SUPABASE_KEY || '',
        },
        body: JSON.stringify({
          email,
          password: 'testpassword123',
        }),
      });

      const responseText = await response.text();
      
      if (response.status === 400) {
        const errorData = JSON.parse(responseText);
        if (errorData.error_code === 'email_address_invalid') {
          console.log(`❌ ${email}: Invalid`);
        } else {
          console.log(`⚠️ ${email}: ${errorData.msg}`);
        }
      } else if (response.status === 200 || response.status === 201) {
        console.log(`✅ ${email}: Valid (account created or already exists)`);
      } else {
        console.log(`❓ ${email}: Status ${response.status} - ${responseText}`);
      }
      
      // Small delay to avoid rate limiting
      await new Promise(resolve => setTimeout(resolve, 500));
      
    } catch (error) {
      console.log(`❌ ${email}: Network error - ${error}`);
    }
  }
  
  console.log('Email format testing complete!');
};
