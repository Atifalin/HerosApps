import React, { useState } from 'react';
import {
  View,
  TextInput,
  Text,
  StyleSheet,
  TouchableOpacity,
  ViewStyle,
  TextInputProps,
} from 'react-native';
import { Ionicons } from '@expo/vector-icons';
import { theme } from '../../theme';

interface InputProps extends TextInputProps {
  label?: string;
  error?: string;
  helperText?: string;
  leftIcon?: keyof typeof Ionicons.glyphMap;
  rightIcon?: keyof typeof Ionicons.glyphMap;
  onRightIconPress?: () => void;
  variant?: 'default' | 'filled' | 'outline';
  size?: 'sm' | 'md' | 'lg';
  containerStyle?: ViewStyle;
}

export const Input: React.FC<InputProps> = ({
  label,
  error,
  helperText,
  leftIcon,
  rightIcon,
  onRightIconPress,
  variant = 'outline',
  size = 'md',
  containerStyle,
  style,
  secureTextEntry,
  ...props
}) => {
  const [isFocused, setIsFocused] = useState(false);
  const [isSecure, setIsSecure] = useState(secureTextEntry);

  const handleRightIconPress = () => {
    if (secureTextEntry) {
      setIsSecure(!isSecure);
    } else if (onRightIconPress) {
      onRightIconPress();
    }
  };

  const inputContainerStyle = [
    styles.inputContainer,
    styles[variant],
    styles[size],
    isFocused && styles.focused,
    error && styles.error,
  ];

  const inputStyle = [
    styles.input,
    styles[`${size}Input`],
    leftIcon && styles.inputWithLeftIcon,
    (rightIcon || secureTextEntry) && styles.inputWithRightIcon,
    style,
  ];

  return (
    <View style={[styles.container, containerStyle]}>
      {label && <Text style={styles.label}>{label}</Text>}
      
      <View style={inputContainerStyle}>
        {leftIcon && (
          <Ionicons
            name={leftIcon}
            size={20}
            color={theme.colors.text.secondary}
            style={styles.leftIcon}
          />
        )}
        
        <TextInput
          style={inputStyle}
          placeholderTextColor={theme.colors.text.tertiary}
          secureTextEntry={isSecure}
          onFocus={() => setIsFocused(true)}
          onBlur={() => setIsFocused(false)}
          {...props}
        />
        
        {(rightIcon || secureTextEntry) && (
          <TouchableOpacity
            onPress={handleRightIconPress}
            style={styles.rightIcon}
          >
            <Ionicons
              name={
                secureTextEntry
                  ? isSecure
                    ? 'eye-off-outline'
                    : 'eye-outline'
                  : rightIcon!
              }
              size={20}
              color={theme.colors.text.secondary}
            />
          </TouchableOpacity>
        )}
      </View>
      
      {(error || helperText) && (
        <Text style={[styles.helperText, error && styles.errorText]}>
          {error || helperText}
        </Text>
      )}
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    marginBottom: theme.semanticSpacing.md,
  },
  
  label: {
    ...theme.typography.label,
    color: theme.colors.text.primary,
    marginBottom: theme.semanticSpacing.xs,
  },
  
  inputContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    borderRadius: theme.borderRadius.md,
  },
  
  // Variants
  default: {
    backgroundColor: theme.colors.background.secondary,
    borderWidth: 0,
  },
  
  filled: {
    backgroundColor: theme.colors.neutral[100],
    borderWidth: 0,
  },
  
  outline: {
    backgroundColor: theme.colors.background.primary,
    borderWidth: 1,
    borderColor: theme.colors.border.light,
  },
  
  // Sizes
  sm: {
    minHeight: 40,
    paddingHorizontal: theme.semanticSpacing.sm,
  },
  
  md: {
    minHeight: 48,
    paddingHorizontal: theme.semanticSpacing.inputPaddingHorizontal,
  },
  
  lg: {
    minHeight: 56,
    paddingHorizontal: theme.semanticSpacing.md,
  },
  
  // Input styles
  input: {
    flex: 1,
    ...theme.typography.input,
    color: theme.colors.text.primary,
  },
  
  smInput: {
    fontSize: theme.fontSizes.sm,
  },
  
  mdInput: {
    fontSize: theme.fontSizes.base,
  },
  
  lgInput: {
    fontSize: theme.fontSizes.lg,
  },
  
  inputWithLeftIcon: {
    marginLeft: theme.semanticSpacing.sm,
  },
  
  inputWithRightIcon: {
    marginRight: theme.semanticSpacing.sm,
  },
  
  // Icons
  leftIcon: {
    marginLeft: theme.semanticSpacing.xs,
  },
  
  rightIcon: {
    padding: theme.semanticSpacing.xs,
    marginRight: theme.semanticSpacing.xs,
  },
  
  // States
  focused: {
    borderColor: theme.colors.primary.main,
    borderWidth: 2,
  },
  
  error: {
    borderColor: theme.colors.error.main,
    borderWidth: 1,
  },
  
  // Helper text
  helperText: {
    ...theme.typography.caption,
    color: theme.colors.text.secondary,
    marginTop: theme.semanticSpacing.xs,
  },
  
  errorText: {
    color: theme.colors.error.main,
  },
});
