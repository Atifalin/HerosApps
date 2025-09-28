// HomeHeros Design System - Main Theme Export
import { colors } from './colors';
import { typography, fontFamilies, fontWeights, fontSizes } from './typography';
import { spacing, semanticSpacing, borderRadius, shadows } from './spacing';

// Main theme object
export const theme = {
  colors: {
    ...colors,
    status: {
      success: colors.success.main,
      warning: colors.warning.main,
      error: colors.error.main,
      info: colors.info.main,
    }
  },
  typography,
  spacing,
  semanticSpacing,
  borderRadius,
  shadows,
  fontFamilies,
  fontWeights,
  fontSizes,
};

// Export individual modules
export { colors } from './colors';
export { typography, fontFamilies, fontWeights, fontSizes } from './typography';
export { spacing, semanticSpacing, borderRadius, shadows } from './spacing';

// Theme type for TypeScript
export type Theme = typeof theme;

// Default export
export default theme;
