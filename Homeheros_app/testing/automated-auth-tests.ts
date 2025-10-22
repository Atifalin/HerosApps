/**
 * Automated Auth Tests
 * 
 * This file contains automated test functions to verify authentication flows.
 * Run these in the app's test environment or manually trigger from a test screen.
 */

import { supabase } from '../src/lib/supabase';

// Test data
const TEST_USERS = [
  { email: 'test1@homeheros.test', password: 'Test123!' },
  { email: 'test2@homeheros.test', password: 'Test456!' },
  { email: 'test3@homeheros.test', password: 'Test789!' },
  { email: 'test4@homeheros.test', password: 'TestABC!' },
  { email: 'test5@homeheros.test', password: 'TestXYZ!' },
];

interface TestResult {
  testName: string;
  passed: boolean;
  message: string;
  duration: number;
  error?: any;
}

const results: TestResult[] = [];

/**
 * Test 1: Sign up with valid credentials
 */
export async function testSignUpValid(): Promise<TestResult> {
  const startTime = Date.now();
  const testUser = TEST_USERS[0];
  
  try {
    console.log('🧪 Test 1: Sign up with valid credentials');
    
    const { data, error } = await supabase.auth.signUp({
      email: testUser.email,
      password: testUser.password,
    });
    
    if (error) {
      return {
        testName: 'Sign Up Valid',
        passed: false,
        message: `Sign up failed: ${error.message}`,
        duration: Date.now() - startTime,
        error,
      };
    }
    
    if (!data.user) {
      return {
        testName: 'Sign Up Valid',
        passed: false,
        message: 'No user returned from sign up',
        duration: Date.now() - startTime,
      };
    }
    
    if (!data.session) {
      return {
        testName: 'Sign Up Valid',
        passed: false,
        message: 'No session created (email confirmation may be required)',
        duration: Date.now() - startTime,
      };
    }
    
    // Wait for profile creation
    await new Promise(resolve => setTimeout(resolve, 1500));
    
    // Check if profile exists
    const { data: profile, error: profileError } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', data.user.id)
      .single();
    
    if (profileError || !profile) {
      return {
        testName: 'Sign Up Valid',
        passed: false,
        message: 'Profile not created after sign up',
        duration: Date.now() - startTime,
        error: profileError,
      };
    }
    
    // Sign out
    await supabase.auth.signOut();
    
    return {
      testName: 'Sign Up Valid',
      passed: true,
      message: `User created successfully with profile (role: ${profile.role})`,
      duration: Date.now() - startTime,
    };
  } catch (error) {
    return {
      testName: 'Sign Up Valid',
      passed: false,
      message: 'Unexpected error during sign up',
      duration: Date.now() - startTime,
      error,
    };
  }
}

/**
 * Test 2: Sign up with existing email
 */
export async function testSignUpDuplicate(): Promise<TestResult> {
  const startTime = Date.now();
  const testUser = TEST_USERS[0]; // Same as test 1
  
  try {
    console.log('🧪 Test 2: Sign up with existing email');
    
    const { data, error } = await supabase.auth.signUp({
      email: testUser.email,
      password: testUser.password,
    });
    
    // Should get an error about existing user
    if (error && (error.message.toLowerCase().includes('already') || 
                  error.message.toLowerCase().includes('exists'))) {
      return {
        testName: 'Sign Up Duplicate',
        passed: true,
        message: 'Correctly rejected duplicate email',
        duration: Date.now() - startTime,
      };
    }
    
    // If no error but user exists, that's also acceptable (Supabase behavior)
    if (data.user && !data.session) {
      return {
        testName: 'Sign Up Duplicate',
        passed: true,
        message: 'User exists, no session created (expected behavior)',
        duration: Date.now() - startTime,
      };
    }
    
    return {
      testName: 'Sign Up Duplicate',
      passed: false,
      message: 'Should have rejected duplicate email',
      duration: Date.now() - startTime,
    };
  } catch (error) {
    return {
      testName: 'Sign Up Duplicate',
      passed: false,
      message: 'Unexpected error',
      duration: Date.now() - startTime,
      error,
    };
  }
}

/**
 * Test 3: Sign in with valid credentials
 */
export async function testSignInValid(): Promise<TestResult> {
  const startTime = Date.now();
  const testUser = TEST_USERS[0];
  
  try {
    console.log('🧪 Test 3: Sign in with valid credentials');
    
    const { data, error } = await supabase.auth.signInWithPassword({
      email: testUser.email,
      password: testUser.password,
    });
    
    if (error) {
      return {
        testName: 'Sign In Valid',
        passed: false,
        message: `Sign in failed: ${error.message}`,
        duration: Date.now() - startTime,
        error,
      };
    }
    
    if (!data.session) {
      return {
        testName: 'Sign In Valid',
        passed: false,
        message: 'No session created',
        duration: Date.now() - startTime,
      };
    }
    
    // Check if profile exists
    const { data: profile, error: profileError } = await supabase
      .from('profiles')
      .select('*')
      .eq('id', data.user.id)
      .single();
    
    if (profileError || !profile) {
      return {
        testName: 'Sign In Valid',
        passed: false,
        message: 'Profile not found after sign in',
        duration: Date.now() - startTime,
        error: profileError,
      };
    }
    
    // Sign out
    await supabase.auth.signOut();
    
    return {
      testName: 'Sign In Valid',
      passed: true,
      message: 'Sign in successful with profile loaded',
      duration: Date.now() - startTime,
    };
  } catch (error) {
    return {
      testName: 'Sign In Valid',
      passed: false,
      message: 'Unexpected error during sign in',
      duration: Date.now() - startTime,
      error,
    };
  }
}

/**
 * Test 4: Sign in with invalid password
 */
export async function testSignInInvalidPassword(): Promise<TestResult> {
  const startTime = Date.now();
  const testUser = TEST_USERS[0];
  
  try {
    console.log('🧪 Test 4: Sign in with invalid password');
    
    const { data, error } = await supabase.auth.signInWithPassword({
      email: testUser.email,
      password: 'WrongPassword123!',
    });
    
    if (error && (error.message.toLowerCase().includes('invalid') || 
                  error.message.toLowerCase().includes('credentials'))) {
      return {
        testName: 'Sign In Invalid Password',
        passed: true,
        message: 'Correctly rejected invalid password',
        duration: Date.now() - startTime,
      };
    }
    
    if (data.session) {
      return {
        testName: 'Sign In Invalid Password',
        passed: false,
        message: 'Should not have created session with wrong password',
        duration: Date.now() - startTime,
      };
    }
    
    return {
      testName: 'Sign In Invalid Password',
      passed: true,
      message: 'Invalid password rejected',
      duration: Date.now() - startTime,
    };
  } catch (error) {
    return {
      testName: 'Sign In Invalid Password',
      passed: false,
      message: 'Unexpected error',
      duration: Date.now() - startTime,
      error,
    };
  }
}

/**
 * Test 5: Sign in with non-existent email
 */
export async function testSignInNonExistent(): Promise<TestResult> {
  const startTime = Date.now();
  
  try {
    console.log('🧪 Test 5: Sign in with non-existent email');
    
    const { data, error } = await supabase.auth.signInWithPassword({
      email: 'nonexistent@homeheros.test',
      password: 'Test123!',
    });
    
    if (error) {
      return {
        testName: 'Sign In Non-Existent',
        passed: true,
        message: 'Correctly rejected non-existent email',
        duration: Date.now() - startTime,
      };
    }
    
    if (data.session) {
      return {
        testName: 'Sign In Non-Existent',
        passed: false,
        message: 'Should not have created session for non-existent user',
        duration: Date.now() - startTime,
      };
    }
    
    return {
      testName: 'Sign In Non-Existent',
      passed: true,
      message: 'Non-existent email rejected',
      duration: Date.now() - startTime,
    };
  } catch (error) {
    return {
      testName: 'Sign In Non-Existent',
      passed: false,
      message: 'Unexpected error',
      duration: Date.now() - startTime,
      error,
    };
  }
}

/**
 * Test 6: Session persistence
 */
export async function testSessionPersistence(): Promise<TestResult> {
  const startTime = Date.now();
  const testUser = TEST_USERS[0];
  
  try {
    console.log('🧪 Test 6: Session persistence');
    
    // Sign in
    const { data: signInData, error: signInError } = await supabase.auth.signInWithPassword({
      email: testUser.email,
      password: testUser.password,
    });
    
    if (signInError || !signInData.session) {
      return {
        testName: 'Session Persistence',
        passed: false,
        message: 'Failed to sign in for session test',
        duration: Date.now() - startTime,
        error: signInError,
      };
    }
    
    const sessionToken = signInData.session.access_token;
    
    // Wait a bit
    await new Promise(resolve => setTimeout(resolve, 1000));
    
    // Get session again
    const { data: sessionData, error: sessionError } = await supabase.auth.getSession();
    
    if (sessionError || !sessionData.session) {
      await supabase.auth.signOut();
      return {
        testName: 'Session Persistence',
        passed: false,
        message: 'Session not persisted',
        duration: Date.now() - startTime,
        error: sessionError,
      };
    }
    
    if (sessionData.session.access_token !== sessionToken) {
      await supabase.auth.signOut();
      return {
        testName: 'Session Persistence',
        passed: false,
        message: 'Session token changed unexpectedly',
        duration: Date.now() - startTime,
      };
    }
    
    // Sign out
    await supabase.auth.signOut();
    
    return {
      testName: 'Session Persistence',
      passed: true,
      message: 'Session persisted correctly',
      duration: Date.now() - startTime,
    };
  } catch (error) {
    await supabase.auth.signOut();
    return {
      testName: 'Session Persistence',
      passed: false,
      message: 'Unexpected error',
      duration: Date.now() - startTime,
      error,
    };
  }
}

/**
 * Test 7: Sign out
 */
export async function testSignOut(): Promise<TestResult> {
  const startTime = Date.now();
  const testUser = TEST_USERS[0];
  
  try {
    console.log('🧪 Test 7: Sign out');
    
    // Sign in first
    const { data: signInData, error: signInError } = await supabase.auth.signInWithPassword({
      email: testUser.email,
      password: testUser.password,
    });
    
    if (signInError || !signInData.session) {
      return {
        testName: 'Sign Out',
        passed: false,
        message: 'Failed to sign in for sign out test',
        duration: Date.now() - startTime,
        error: signInError,
      };
    }
    
    // Sign out
    const { error: signOutError } = await supabase.auth.signOut();
    
    if (signOutError) {
      return {
        testName: 'Sign Out',
        passed: false,
        message: `Sign out failed: ${signOutError.message}`,
        duration: Date.now() - startTime,
        error: signOutError,
      };
    }
    
    // Verify session is gone
    const { data: sessionData } = await supabase.auth.getSession();
    
    if (sessionData.session) {
      return {
        testName: 'Sign Out',
        passed: false,
        message: 'Session still exists after sign out',
        duration: Date.now() - startTime,
      };
    }
    
    return {
      testName: 'Sign Out',
      passed: true,
      message: 'Sign out successful, session cleared',
      duration: Date.now() - startTime,
    };
  } catch (error) {
    return {
      testName: 'Sign Out',
      passed: false,
      message: 'Unexpected error',
      duration: Date.now() - startTime,
      error,
    };
  }
}

/**
 * Run all tests
 */
export async function runAllTests(): Promise<TestResult[]> {
  console.log('🚀 Starting automated auth tests...\n');
  
  const tests = [
    testSignUpValid,
    testSignUpDuplicate,
    testSignInValid,
    testSignInInvalidPassword,
    testSignInNonExistent,
    testSessionPersistence,
    testSignOut,
  ];
  
  const results: TestResult[] = [];
  
  for (const test of tests) {
    const result = await test();
    results.push(result);
    
    const status = result.passed ? '✅ PASS' : '❌ FAIL';
    console.log(`${status} - ${result.testName} (${result.duration}ms)`);
    console.log(`   ${result.message}`);
    if (result.error) {
      console.log(`   Error:`, result.error);
    }
    console.log('');
    
    // Wait between tests
    await new Promise(resolve => setTimeout(resolve, 500));
  }
  
  // Summary
  const passed = results.filter(r => r.passed).length;
  const failed = results.filter(r => !r.passed).length;
  const totalDuration = results.reduce((sum, r) => sum + r.duration, 0);
  
  console.log('📊 Test Summary:');
  console.log(`   Total: ${results.length}`);
  console.log(`   Passed: ${passed}`);
  console.log(`   Failed: ${failed}`);
  console.log(`   Duration: ${totalDuration}ms`);
  console.log(`   Success Rate: ${((passed / results.length) * 100).toFixed(1)}%`);
  
  return results;
}

/**
 * Clean up test users (run after testing)
 */
export async function cleanupTestUsers(): Promise<void> {
  console.log('🧹 Cleaning up test users...');
  
  // Note: This requires admin access or service role key
  // For now, just log the test emails to delete manually
  console.log('Test users to delete from Supabase dashboard:');
  TEST_USERS.forEach(user => {
    console.log(`  - ${user.email}`);
  });
}
