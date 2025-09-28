// Test Supabase connection
import { supabase } from '../lib/supabase';

export const testSupabaseConnection = async () => {
  try {
    console.log('Testing Supabase connection...');
    
    // Use a more reliable method to test connection - just check if we can get the server timestamp
    const { data, error } = await supabase.rpc('get_server_timestamp');
    
    if (error) {
      // If the RPC function doesn't exist, try a simpler approach
      if (error.message.includes('does not exist')) {
        // Try to get the current timestamp from Postgres
        const { data: timestamp, error: timestampError } = await supabase.from('profiles').select('created_at').limit(1);
        
        if (timestampError) {
          console.log('❌ Connection test failed:', timestampError.message);
          return { success: false, error: timestampError };
        }
        
        console.log('✅ Connection successful - can reach Supabase');
        return { success: true, message: 'Connection successful' };
      }
      
      console.log('❌ Connection test failed:', error.message);
      return { success: false, error };
    }
    
    console.log('✅ Connection successful - server timestamp:', data);
    return { success: true, data };
  } catch (err) {
    console.log('❌ Connection failed:', err);
    return { success: false, error: err };
  }
};
