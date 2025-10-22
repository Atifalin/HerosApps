/**
 * Create Persistent Test User
 * 
 * This creates a test user that stays in the database for manual verification
 */

import { supabase } from '../src/lib/supabase';

export async function createPersistentTestUser() {
  console.log('\n🔧 Creating persistent test user...\n');
  
  const testEmail = 'persistent-test@homeheros.test';
  const testPassword = 'Test123!';
  
  try {
    // Check Supabase connection
    console.log('📡 Supabase URL:', process.env.EXPO_PUBLIC_SUPABASE_URL || 'https://vttzuaerdwagipyocpha.supabase.co');
    
    // Try to sign up
    console.log('📝 Attempting to create user:', testEmail);
    const { data, error } = await supabase.auth.signUp({
      email: testEmail,
      password: testPassword,
    });
    
    if (error) {
      console.error('❌ Sign up error:', error.message);
      
      // If user exists, try to sign in
      if (error.message.toLowerCase().includes('already') || 
          error.message.toLowerCase().includes('exists')) {
        console.log('ℹ️  User already exists, trying to sign in...');
        
        const { data: signInData, error: signInError } = await supabase.auth.signInWithPassword({
          email: testEmail,
          password: testPassword,
        });
        
        if (signInError) {
          console.error('❌ Sign in error:', signInError.message);
          return;
        }
        
        console.log('✅ Signed in successfully!');
        console.log('👤 User ID:', signInData.user?.id);
        console.log('📧 Email:', signInData.user?.email);
        console.log('🔑 Session:', signInData.session ? 'Active' : 'None');
        
        // Check profile
        const { data: profile } = await supabase
          .from('profiles')
          .select('*')
          .eq('id', signInData.user!.id)
          .single();
        
        if (profile) {
          console.log('✅ Profile exists:', profile);
        } else {
          console.log('⚠️  No profile found');
        }
        
        // DON'T SIGN OUT - keep user logged in
        console.log('\n✅ User is now signed in and will persist in Supabase');
        console.log('📍 Check Supabase Dashboard → Authentication → Users');
        console.log(`🔍 Search for: ${testEmail}`);
        return;
      }
      
      return;
    }
    
    if (!data.user) {
      console.error('❌ No user returned from sign up');
      return;
    }
    
    console.log('✅ User created successfully!');
    console.log('👤 User ID:', data.user.id);
    console.log('📧 Email:', data.user.email);
    console.log('🔑 Session:', data.session ? 'Active' : 'None');
    
    if (!data.session) {
      console.log('⚠️  No session created - email confirmation may be required');
    }
    
    // Wait for profile creation
    console.log('⏳ Waiting for profile creation...');
    await new Promise(resolve => setTimeout(resolve, 2000));
    
    // Check profile
    const { data: profile, error: profileError } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', data.user.id)
      .single();
    
    if (profileError) {
      console.error('❌ Profile error:', profileError.message);
    } else if (profile) {
      console.log('✅ Profile created:', profile);
    } else {
      console.log('⚠️  No profile found');
    }
    
    // DON'T SIGN OUT - keep user logged in
    console.log('\n✅ User created and will persist in Supabase');
    console.log('📍 Check Supabase Dashboard → Authentication → Users');
    console.log(`🔍 Search for: ${testEmail}`);
    console.log('\n⚠️  DO NOT SIGN OUT - User will remain in database');
    
  } catch (error) {
    console.error('❌ Unexpected error:', error);
  }
}

// Auto-run if imported
setTimeout(() => {
  createPersistentTestUser();
}, 3000);

export {};
