import React from 'react';
import {
  TouchableOpacity,
  Text,
  StyleSheet,
  ActivityIndicator,
  ViewStyle,
  TextStyle,
} from 'react-native';
import { theme } from '../../theme';

interface ButtonProps {
  title: string;
  onPress: () => void;
  variant?: 'primary' | 'secondary' | 'outline' | 'ghost';
  size?: 'sm' | 'md' | 'lg';
  disabled?: boolean;
  loading?: boolean;
  fullWidth?: boolean;
  style?: ViewStyle;
  textStyle?: TextStyle;
  buttonColor?: string;
}

export const Button: React.FC<ButtonProps> = ({
  title,
  onPress,
  variant = 'primary',
  size = 'md',
  disabled = false,
  loading = false,
  fullWidth = false,
  style,
  textStyle,
  buttonColor,
}) => {
  const buttonStyle = [
    styles.base,
    styles[variant],
    styles[size],
    fullWidth && styles.fullWidth,
    (disabled || loading) && styles.disabled,
    style,
  ];
  
  // Apply custom button color if provided
  if (buttonColor && variant === 'primary') {
    buttonStyle.push({ backgroundColor: buttonColor });
  } else if (buttonColor && variant === 'outline') {
    buttonStyle.push({ borderColor: buttonColor });
  }

  const textStyleCombined = [
    styles.text,
    styles[`${variant}Text`],
    styles[`${size}Text`],
    (disabled || loading) && styles.disabledText,
    textStyle,
  ];

  return (
    <TouchableOpacity
      style={buttonStyle}
      onPress={onPress}
      disabled={disabled || loading}
      activeOpacity={0.8}
    >
      {loading ? (
        <ActivityIndicator
          size="small"
          color={variant === 'primary' ? theme.colors.neutral.white : theme.colors.primary.main}
        />
      ) : (
        <Text style={textStyleCombined}>{title}</Text>
      )}
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  base: {
    borderRadius: theme.borderRadius.md,
    alignItems: 'center',
    justifyContent: 'center',
    flexDirection: 'row',
    ...theme.shadows.sm,
  },
  
  // Variants
  primary: {
    backgroundColor: theme.colors.primary.main,
    borderWidth: 0,
  },
  
  secondary: {
    backgroundColor: theme.colors.neutral[100],
    borderWidth: 1,
    borderColor: theme.colors.border.light,
  },
  
  outline: {
    backgroundColor: 'transparent',
    borderWidth: 1,
    borderColor: theme.colors.primary.main,
  },
  
  ghost: {
    backgroundColor: 'transparent',
    borderWidth: 0,
  },
  
  // Sizes
  sm: {
    paddingVertical: theme.semanticSpacing.sm,
    paddingHorizontal: theme.semanticSpacing.md,
    minHeight: 36,
  },
  
  md: {
    paddingVertical: theme.semanticSpacing.buttonPaddingVertical,
    paddingHorizontal: theme.semanticSpacing.buttonPaddingHorizontal,
    minHeight: 48,
  },
  
  lg: {
    paddingVertical: theme.semanticSpacing.md,
    paddingHorizontal: theme.semanticSpacing.xl,
    minHeight: 56,
  },
  
  // Text styles
  text: {
    ...theme.typography.button,
    textAlign: 'center',
  },
  
  primaryText: {
    color: theme.colors.neutral.white,
  },
  
  secondaryText: {
    color: theme.colors.text.primary,
  },
  
  outlineText: {
    color: theme.colors.primary.main,
  },
  
  ghostText: {
    color: theme.colors.primary.main,
  },
  
  // Size text styles
  smText: {
    fontSize: theme.fontSizes.sm,
  },
  
  mdText: {
    fontSize: theme.fontSizes.base,
  },
  
  lgText: {
    fontSize: theme.fontSizes.lg,
  },
  
  // States
  disabled: {
    opacity: 0.5,
  },
  
  disabledText: {
    opacity: 0.7,
  },
  
  fullWidth: {
    width: '100%',
  },
});
