/**
 * Run Tests in App
 * 
 * Import this in your App.tsx temporarily to run tests on app launch
 * 
 * Usage:
 * 1. Add to App.tsx: import './testing/run-tests-in-app';
 * 2. Reload app
 * 3. Check console for results
 * 4. Remove import before production
 */

import { runAllTests } from './automated-auth-tests';

// Run tests after a short delay to let app initialize
setTimeout(async () => {
  console.log('\n\n');
  console.log('═'.repeat(70));
  console.log('🧪 AUTOMATED AUTH TESTS - STARTING');
  console.log('═'.repeat(70));
  console.log('\n');
  
  try {
    const results = await runAllTests();
    
    console.log('\n');
    console.log('═'.repeat(70));
    console.log('✅ AUTOMATED AUTH TESTS - COMPLETE');
    console.log('═'.repeat(70));
    
    // Show results summary
    const passed = results.filter(r => r.passed).length;
    const failed = results.filter(r => !r.passed).length;
    
    if (failed === 0) {
      console.log('\n🎉 ALL TESTS PASSED! 🎉\n');
    } else {
      console.log(`\n⚠️ ${failed} TEST(S) FAILED\n`);
    }
    
    // Show failed tests
    if (failed > 0) {
      console.log('Failed Tests:');
      results.filter(r => !r.passed).forEach(r => {
        console.log(`  ❌ ${r.testName}: ${r.message}`);
      });
      console.log('');
    }
    
  } catch (error) {
    console.error('❌ Error running tests:', error);
  }
}, 3000); // Wait 3 seconds for app to initialize

export {};
