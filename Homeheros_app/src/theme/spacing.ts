// HomeHeros Design System - Spacing
export const spacing = {
  // Base spacing unit (4px)
  unit: 4,
  
  // Spacing scale
  0: 0,
  1: 4,   // 0.25rem
  2: 8,   // 0.5rem
  3: 12,  // 0.75rem
  4: 16,  // 1rem
  5: 20,  // 1.25rem
  6: 24,  // 1.5rem
  8: 32,  // 2rem
  10: 40, // 2.5rem
  12: 48, // 3rem
  16: 64, // 4rem
  20: 80, // 5rem
  24: 96, // 6rem
  32: 128, // 8rem
  40: 160, // 10rem
  48: 192, // 12rem
  56: 224, // 14rem
  64: 256, // 16rem
};

// Semantic spacing
export const semanticSpacing = {
  // Component spacing
  xs: spacing[1],    // 4px
  sm: spacing[2],    // 8px
  md: spacing[4],    // 16px
  lg: spacing[6],    // 24px
  xl: spacing[8],    // 32px
  '2xl': spacing[12], // 48px
  '3xl': spacing[16], // 64px
  
  // Layout spacing
  screenPadding: spacing[4],      // 16px
  sectionSpacing: spacing[6],     // 24px
  componentSpacing: spacing[4],   // 16px
  
  // Card spacing
  cardPadding: spacing[4],        // 16px
  cardMargin: spacing[4],         // 16px
  
  // Button spacing
  buttonPaddingVertical: spacing[3],   // 12px
  buttonPaddingHorizontal: spacing[6], // 24px
  
  // Input spacing
  inputPaddingVertical: spacing[3],    // 12px
  inputPaddingHorizontal: spacing[4],  // 16px
};

// Border radius
export const borderRadius = {
  none: 0,
  sm: 4,
  md: 8,
  lg: 12,
  xl: 16,
  '2xl': 24,
  '3xl': 32,
  full: 9999,
};

// Shadows
export const shadows = {
  none: {
    shadowColor: 'transparent',
    shadowOffset: { width: 0, height: 0 },
    shadowOpacity: 0,
    shadowRadius: 0,
    elevation: 0,
  },
  
  sm: {
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 1 },
    shadowOpacity: 0.05,
    shadowRadius: 2,
    elevation: 2,
  },
  
  md: {
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 4,
    elevation: 4,
  },
  
  lg: {
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.15,
    shadowRadius: 8,
    elevation: 8,
  },
  
  xl: {
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 8 },
    shadowOpacity: 0.2,
    shadowRadius: 16,
    elevation: 16,
  },
};
