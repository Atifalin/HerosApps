import { StatusBar } from 'expo-status-bar';
import { StyleSheet, Text, View, Button } from 'react-native';
import { useEffect, useState } from 'react';
import { supabase } from './src/lib/supabase';

export default function App() {
  const [isConnected, setIsConnected] = useState<boolean | null>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    checkConnection();
  }, []);

  const checkConnection = async () => {
    try {
      const { data, error } = await supabase.from('_dummy_query').select('*').limit(1);
      if (error) {
        setError(error.message);
        setIsConnected(false);
      } else {
        setIsConnected(true);
        setError(null);
      }
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Unknown error');
      setIsConnected(false);
    }
  };

  return (
    <View style={styles.container}>
      <Text style={styles.title}>HomeHeros Admin Portal</Text>
      <Text style={styles.subtitle}>Supabase Connection Status:</Text>
      {isConnected === null ? (
        <Text>Checking connection...</Text>
      ) : isConnected ? (
        <Text style={styles.success}>Connected to Supabase! ✅</Text>
      ) : (
        <Text style={styles.error}>Connection failed ❌</Text>
      )}
      {error && <Text style={styles.errorText}>{error}</Text>}
      <Button title="Check Connection" onPress={checkConnection} />
      <StatusBar style="auto" />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 20,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    marginBottom: 20,
  },
  subtitle: {
    fontSize: 18,
    marginBottom: 10,
  },
  success: {
    color: 'green',
    fontSize: 16,
    marginBottom: 20,
  },
  error: {
    color: 'red',
    fontSize: 16,
    marginBottom: 10,
  },
  errorText: {
    color: 'red',
    fontSize: 14,
    marginBottom: 20,
    textAlign: 'center',
  },
});
