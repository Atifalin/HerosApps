import React from 'react';
import {
  View,
  StyleSheet,
  ViewStyle,
  TouchableOpacity,
  TouchableOpacityProps,
} from 'react-native';
import { theme } from '../../theme';

interface CardProps extends TouchableOpacityProps {
  children: React.ReactNode;
  variant?: 'default' | 'elevated' | 'outlined';
  padding?: 'none' | 'sm' | 'md' | 'lg';
  margin?: 'none' | 'sm' | 'md' | 'lg';
  borderRadius?: 'sm' | 'md' | 'lg' | 'xl';
  onPress?: () => void;
  style?: ViewStyle;
}

export const Card: React.FC<CardProps> = ({
  children,
  variant = 'default',
  padding = 'md',
  margin = 'none',
  borderRadius = 'md',
  onPress,
  style,
  ...props
}) => {
  const cardStyle = [
    styles.base,
    styles[variant],
    styles[`padding${padding.charAt(0).toUpperCase() + padding.slice(1)}`],
    styles[`margin${margin.charAt(0).toUpperCase() + margin.slice(1)}`],
    styles[`radius${borderRadius.charAt(0).toUpperCase() + borderRadius.slice(1)}`],
    style,
  ];

  if (onPress) {
    return (
      <TouchableOpacity
        style={cardStyle}
        onPress={onPress}
        activeOpacity={0.8}
        {...props}
      >
        {children}
      </TouchableOpacity>
    );
  }

  return <View style={cardStyle}>{children}</View>;
};

const styles = StyleSheet.create({
  base: {
    backgroundColor: theme.colors.background.card,
  },
  
  // Variants
  default: {
    ...theme.shadows.sm,
  },
  
  elevated: {
    ...theme.shadows.md,
  },
  
  outlined: {
    borderWidth: 1,
    borderColor: theme.colors.border.light,
    ...theme.shadows.none,
  },
  
  // Padding
  paddingNone: {
    padding: 0,
  },
  
  paddingSm: {
    padding: theme.semanticSpacing.sm,
  },
  
  paddingMd: {
    padding: theme.semanticSpacing.cardPadding,
  },
  
  paddingLg: {
    padding: theme.semanticSpacing.lg,
  },
  
  // Margin
  marginNone: {
    margin: 0,
  },
  
  marginSm: {
    margin: theme.semanticSpacing.sm,
  },
  
  marginMd: {
    margin: theme.semanticSpacing.cardMargin,
  },
  
  marginLg: {
    margin: theme.semanticSpacing.lg,
  },
  
  // Border Radius
  radiusSm: {
    borderRadius: theme.borderRadius.sm,
  },
  
  radiusMd: {
    borderRadius: theme.borderRadius.md,
  },
  
  radiusLg: {
    borderRadius: theme.borderRadius.lg,
  },
  
  radiusXl: {
    borderRadius: theme.borderRadius.xl,
  },
});
