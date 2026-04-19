import React from 'react';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import SignInScreen from '../screens/auth/SignInScreen';
import SignUpScreen from '../screens/auth/SignUpScreen';
import LegalAcceptanceScreen from '../screens/auth/LegalAcceptanceScreen';
import BackgroundCheckScreen from '../screens/auth/BackgroundCheckScreen';

const Stack = createNativeStackNavigator();

const AuthNavigator = () => {
  return (
    <Stack.Navigator
      screenOptions={{
        headerShown: false,
      }}
    >
      <Stack.Screen name="SignIn" component={SignInScreen} />
      <Stack.Screen name="LegalAcceptance" component={LegalAcceptanceScreen} />
      <Stack.Screen name="SignUp" component={SignUpScreen} />
      <Stack.Screen name="BackgroundCheck" component={BackgroundCheckScreen} />
    </Stack.Navigator>
  );
};

export default AuthNavigator;
