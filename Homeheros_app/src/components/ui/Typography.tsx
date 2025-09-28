import React from 'react';
import { Text, StyleSheet, TextProps, TextStyle } from 'react-native';
import { theme } from '../../theme';

interface TypographyProps extends TextProps {
  variant?: 'h1' | 'h2' | 'h3' | 'h4' | 'h5' | 'h6' | 'body1' | 'body2' | 'button' | 'caption' | 'overline';
  color?: 'primary' | 'secondary' | 'tertiary' | 'inverse' | 'brand' | 'success' | 'warning' | 'error';
  align?: 'left' | 'center' | 'right' | 'justify';
  weight?: 'light' | 'regular' | 'medium' | 'semibold' | 'bold' | 'extrabold';
  style?: TextStyle;
}

export const Typography: React.FC<TypographyProps> = ({
  children,
  variant = 'body1',
  color = 'primary',
  align = 'left',
  weight,
  style,
  ...props
}) => {
  const textStyle = [
    styles[variant],
    styles[`color${color.charAt(0).toUpperCase() + color.slice(1)}`],
    styles[`align${align.charAt(0).toUpperCase() + align.slice(1)}`],
    weight && styles[`weight${weight.charAt(0).toUpperCase() + weight.slice(1)}`],
    style,
  ];

  return (
    <Text style={textStyle} {...props}>
      {children}
    </Text>
  );
};

const styles = StyleSheet.create({
  // Variants
  h1: theme.typography.h1,
  h2: theme.typography.h2,
  h3: theme.typography.h3,
  h4: theme.typography.h4,
  h5: theme.typography.h5,
  h6: theme.typography.h6,
  body1: theme.typography.body1,
  body2: theme.typography.body2,
  button: theme.typography.button,
  caption: theme.typography.caption,
  overline: theme.typography.overline,
  
  // Colors
  colorPrimary: {
    color: theme.colors.text.primary,
  },
  
  colorSecondary: {
    color: theme.colors.text.secondary,
  },
  
  colorTertiary: {
    color: theme.colors.text.tertiary,
  },
  
  colorInverse: {
    color: theme.colors.text.inverse,
  },
  
  colorBrand: {
    color: theme.colors.text.brand,
  },
  
  colorSuccess: {
    color: theme.colors.success.main,
  },
  
  colorWarning: {
    color: theme.colors.warning.main,
  },
  
  colorError: {
    color: theme.colors.error.main,
  },
  
  // Alignment
  alignLeft: {
    textAlign: 'left',
  },
  
  alignCenter: {
    textAlign: 'center',
  },
  
  alignRight: {
    textAlign: 'right',
  },
  
  alignJustify: {
    textAlign: 'justify',
  },
  
  // Weights
  weightLight: {
    fontWeight: theme.fontWeights.light,
  },
  
  weightRegular: {
    fontWeight: theme.fontWeights.regular,
  },
  
  weightMedium: {
    fontWeight: theme.fontWeights.medium,
  },
  
  weightSemibold: {
    fontWeight: theme.fontWeights.semibold,
  },
  
  weightBold: {
    fontWeight: theme.fontWeights.bold,
  },
  
  weightExtrabold: {
    fontWeight: theme.fontWeights.extrabold,
  },
});
