/**
 * Test Runner Screen
 * 
 * This is a development-only screen to run automated auth tests.
 * Add this to your navigation temporarily for testing.
 * 
 * Usage:
 * 1. Import this screen in your navigator
 * 2. Add a route to access it (e.g., from Account screen)
 * 3. Run tests and view results
 * 4. Remove before production build
 */

import React, { useState } from 'react';
import {
  View,
  Text,
  ScrollView,
  TouchableOpacity,
  StyleSheet,
  ActivityIndicator,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { runAllTests, cleanupTestUsers } from './automated-auth-tests';

interface TestResult {
  testName: string;
  passed: boolean;
  message: string;
  duration: number;
  error?: any;
}

export const TestRunnerScreen: React.FC = () => {
  const [running, setRunning] = useState(false);
  const [results, setResults] = useState<TestResult[]>([]);
  const [summary, setSummary] = useState<string>('');

  const handleRunTests = async () => {
    setRunning(true);
    setResults([]);
    setSummary('');

    try {
      const testResults = await runAllTests();
      setResults(testResults);

      const passed = testResults.filter(r => r.passed).length;
      const failed = testResults.filter(r => !r.passed).length;
      const totalDuration = testResults.reduce((sum, r) => sum + r.duration, 0);
      const successRate = ((passed / testResults.length) * 100).toFixed(1);

      setSummary(
        `Total: ${testResults.length} | Passed: ${passed} | Failed: ${failed} | Duration: ${totalDuration}ms | Success: ${successRate}%`
      );
    } catch (error) {
      console.error('Error running tests:', error);
      setSummary('Error running tests. Check console for details.');
    } finally {
      setRunning(false);
    }
  };

  const handleCleanup = () => {
    cleanupTestUsers();
    alert('Check console for list of test users to delete from Supabase dashboard');
  };

  return (
    <SafeAreaView style={styles.container}>
      <View style={styles.header}>
        <Text style={styles.title}>🧪 Auth Test Runner</Text>
        <Text style={styles.subtitle}>Development Only</Text>
      </View>

      <View style={styles.buttonContainer}>
        <TouchableOpacity
          style={[styles.button, styles.runButton, running && styles.buttonDisabled]}
          onPress={handleRunTests}
          disabled={running}
        >
          {running ? (
            <ActivityIndicator color="#fff" />
          ) : (
            <Text style={styles.buttonText}>Run All Tests</Text>
          )}
        </TouchableOpacity>

        <TouchableOpacity
          style={[styles.button, styles.cleanupButton]}
          onPress={handleCleanup}
        >
          <Text style={styles.buttonText}>Show Cleanup Info</Text>
        </TouchableOpacity>
      </View>

      {summary ? (
        <View style={styles.summaryContainer}>
          <Text style={styles.summaryText}>{summary}</Text>
        </View>
      ) : null}

      <ScrollView style={styles.resultsContainer}>
        {results.map((result, index) => (
          <View
            key={index}
            style={[
              styles.resultCard,
              result.passed ? styles.resultPass : styles.resultFail,
            ]}
          >
            <View style={styles.resultHeader}>
              <Text style={styles.resultIcon}>
                {result.passed ? '✅' : '❌'}
              </Text>
              <Text style={styles.resultName}>{result.testName}</Text>
              <Text style={styles.resultDuration}>{result.duration}ms</Text>
            </View>
            <Text style={styles.resultMessage}>{result.message}</Text>
            {result.error && (
              <Text style={styles.resultError}>
                Error: {JSON.stringify(result.error, null, 2)}
              </Text>
            )}
          </View>
        ))}
      </ScrollView>

      <View style={styles.footer}>
        <Text style={styles.footerText}>
          ⚠️ Remember to delete test users from Supabase after testing
        </Text>
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#f5f5f5',
  },
  header: {
    padding: 20,
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#e0e0e0',
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#333',
  },
  subtitle: {
    fontSize: 14,
    color: '#666',
    marginTop: 4,
  },
  buttonContainer: {
    padding: 16,
    gap: 12,
  },
  button: {
    padding: 16,
    borderRadius: 8,
    alignItems: 'center',
  },
  runButton: {
    backgroundColor: '#007AFF',
  },
  cleanupButton: {
    backgroundColor: '#FF9500',
  },
  buttonDisabled: {
    backgroundColor: '#ccc',
  },
  buttonText: {
    color: '#fff',
    fontSize: 16,
    fontWeight: '600',
  },
  summaryContainer: {
    padding: 16,
    backgroundColor: '#fff',
    marginHorizontal: 16,
    marginBottom: 16,
    borderRadius: 8,
    borderWidth: 1,
    borderColor: '#e0e0e0',
  },
  summaryText: {
    fontSize: 14,
    color: '#333',
    fontWeight: '500',
  },
  resultsContainer: {
    flex: 1,
    padding: 16,
  },
  resultCard: {
    backgroundColor: '#fff',
    padding: 16,
    borderRadius: 8,
    marginBottom: 12,
    borderWidth: 2,
  },
  resultPass: {
    borderColor: '#4CAF50',
  },
  resultFail: {
    borderColor: '#F44336',
  },
  resultHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    marginBottom: 8,
  },
  resultIcon: {
    fontSize: 20,
    marginRight: 8,
  },
  resultName: {
    flex: 1,
    fontSize: 16,
    fontWeight: '600',
    color: '#333',
  },
  resultDuration: {
    fontSize: 12,
    color: '#666',
  },
  resultMessage: {
    fontSize: 14,
    color: '#666',
    marginTop: 4,
  },
  resultError: {
    fontSize: 12,
    color: '#F44336',
    marginTop: 8,
    fontFamily: 'monospace',
  },
  footer: {
    padding: 16,
    backgroundColor: '#FFF3CD',
    borderTopWidth: 1,
    borderTopColor: '#FFE69C',
  },
  footerText: {
    fontSize: 12,
    color: '#856404',
    textAlign: 'center',
  },
});
