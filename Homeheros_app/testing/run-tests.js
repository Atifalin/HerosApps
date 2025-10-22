/**
 * Test Runner Script
 * Run automated auth tests from command line
 */

// Import the test functions
const { runAllTests, cleanupTestUsers } = require('./automated-auth-tests.ts');

async function main() {
  console.log('🚀 Starting Automated Auth Tests\n');
  console.log('=' .repeat(60));
  
  try {
    // Run all tests
    const results = await runAllTests();
    
    console.log('\n' + '='.repeat(60));
    console.log('\n✅ Test execution complete!\n');
    
    // Show cleanup instructions
    console.log('🧹 Cleanup Instructions:');
    console.log('After testing, delete these users from Supabase dashboard:');
    console.log('  - test1@homeheros.test');
    console.log('  - test2@homeheros.test');
    console.log('  - test3@homeheros.test');
    console.log('  - test4@homeheros.test');
    console.log('  - test5@homeheros.test');
    
    // Exit with appropriate code
    const failed = results.filter(r => !r.passed).length;
    process.exit(failed > 0 ? 1 : 0);
    
  } catch (error) {
    console.error('❌ Error running tests:', error);
    process.exit(1);
  }
}

main();
