// Test Supabase connection
import { supabase } from '../lib/supabase';

export const testSupabaseConnection = async () => {
  try {
    console.log('Testing Supabase connection...');
    console.log('URL:', 'https://vttzuaerdwagipyocpha.supabase.co');
    
    // Test basic connection
    const { data, error } = await supabase
      .from('_test_connection')
      .select('*')
      .limit(1);
    
    if (error) {
      console.log('Connection test error (expected for non-existent table):', error.message);
      // This error is expected if the table doesn't exist, but it means we can connect
      if (error.message.includes('relation') && error.message.includes('does not exist')) {
        console.log('✅ Connection successful - can reach Supabase');
        return { success: true, message: 'Connection successful' };
      } else {
        console.log('❌ Unexpected error:', error);
        return { success: false, error };
      }
    }
    
    console.log('✅ Connection successful:', data);
    return { success: true, data };
  } catch (err) {
    console.log('❌ Connection failed:', err);
    return { success: false, error: err };
  }
};
