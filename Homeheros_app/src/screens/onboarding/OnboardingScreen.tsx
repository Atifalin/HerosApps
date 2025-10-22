import React, { useState, useRef } from 'react';
import {
  View,
  StyleSheet,
  Dimensions,
  FlatList,
  Image,
  StatusBar,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { LinearGradient } from 'expo-linear-gradient';
import { Ionicons } from '@expo/vector-icons';
import { Button, Typography, Card } from '../../components/ui';
import { theme } from '../../theme';

const { width: screenWidth, height: screenHeight } = Dimensions.get('window');

interface OnboardingSlide {
  id: string;
  title: string;
  subtitle: string;
  description: string;
  icon: keyof typeof Ionicons.glyphMap;
  gradient: readonly [string, string, ...string[]];
}

const onboardingData: OnboardingSlide[] = [
  {
    id: '1',
    title: 'Welcome to HomeHeros',
    subtitle: 'Your Trusted Service Platform',
    description: 'Connect with verified professionals for all your home service needs. From cleaning to repairs, we\'ve got you covered.',
    icon: 'home-outline',
    gradient: [theme.colors.primary.light, theme.colors.primary.main],
  },
  {
    id: '2',
    title: 'Verified Professionals',
    subtitle: 'Quality You Can Trust',
    description: 'All our service providers are thoroughly vetted, insured, and rated by real customers for your peace of mind.',
    icon: 'shield-checkmark-outline',
    gradient: [theme.colors.primary.main, theme.colors.primary.dark],
  },
  {
    id: '3',
    title: 'Book with Confidence',
    subtitle: 'Simple & Secure',
    description: 'Easy booking, transparent pricing, and secure payments. Track your service from booking to completion.',
    icon: 'calendar-outline',
    gradient: [theme.colors.primary.dark, theme.colors.primary[800]],
  },
];

interface OnboardingScreenProps {
  navigation: any;
}

export const OnboardingScreen: React.FC<OnboardingScreenProps> = ({ navigation }) => {
  const [currentIndex, setCurrentIndex] = useState(0);
  const flatListRef = useRef<FlatList>(null);

  const handleNext = () => {
    if (currentIndex < onboardingData.length - 1) {
      const nextIndex = currentIndex + 1;
      flatListRef.current?.scrollToIndex({ index: nextIndex, animated: true });
      setCurrentIndex(nextIndex);
    } else {
      handleGetStarted();
    }
  };

  const handleSkip = () => {
    handleGetStarted();
  };

  const handleGetStarted = () => {
    navigation.replace('Auth');
  };

  const renderSlide = ({ item, index }: { item: OnboardingSlide; index: number }) => (
    <View style={styles.slide}>
      <LinearGradient
        colors={item.gradient}
        style={styles.gradientBackground}
        start={{ x: 0, y: 0 }}
        end={{ x: 1, y: 1 }}
      >
        <View style={styles.iconContainer}>
          <View style={styles.iconBackground}>
            <Ionicons
              name={item.icon}
              size={80}
              color={theme.colors.neutral.white}
            />
          </View>
        </View>
      </LinearGradient>

      <View style={styles.contentContainer}>
        <Card variant="default" padding="lg" style={styles.contentCard}>
          <Typography variant="h2" align="center" color="brand" style={styles.title}>
            {item.title}
          </Typography>
          
          <Typography variant="h5" align="center" color="primary" style={styles.subtitle}>
            {item.subtitle}
          </Typography>
          
          <Typography variant="body1" align="center" color="secondary" style={styles.description}>
            {item.description}
          </Typography>
        </Card>
      </View>
    </View>
  );

  const renderPagination = () => (
    <View style={styles.pagination}>
      {onboardingData.map((_, index) => (
        <View
          key={index}
          style={[
            styles.paginationDot,
            index === currentIndex && styles.paginationDotActive,
          ]}
        />
      ))}
    </View>
  );

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar barStyle="light-content" backgroundColor={theme.colors.primary.main} />
      
      {/* Skip Button */}
      <View style={styles.header}>
        <Button
          title="Skip"
          variant="ghost"
          size="sm"
          onPress={handleSkip}
          textStyle={styles.skipText}
        />
      </View>

      {/* Slides */}
      <FlatList
        ref={flatListRef}
        data={onboardingData}
        renderItem={renderSlide}
        keyExtractor={(item) => item.id}
        horizontal
        pagingEnabled
        showsHorizontalScrollIndicator={false}
        onMomentumScrollEnd={(event) => {
          const index = Math.round(event.nativeEvent.contentOffset.x / screenWidth);
          setCurrentIndex(index);
        }}
      />

      {/* Bottom Section */}
      <View style={styles.bottomSection}>
        {renderPagination()}
        
        <View style={styles.buttonContainer}>
          <Button
            title={currentIndex === onboardingData.length - 1 ? 'Get Started' : 'Next'}
            variant="primary"
            size="lg"
            fullWidth
            onPress={handleNext}
          />
        </View>
      </View>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: theme.colors.background.primary,
  },
  
  header: {
    flexDirection: 'row',
    justifyContent: 'flex-end',
    paddingHorizontal: theme.semanticSpacing.screenPadding,
    paddingTop: theme.semanticSpacing.sm,
  },
  
  skipText: {
    color: theme.colors.text.secondary,
  },
  
  slide: {
    width: screenWidth,
    flex: 1,
  },
  
  gradientBackground: {
    height: screenHeight * 0.5,
    justifyContent: 'center',
    alignItems: 'center',
  },
  
  iconContainer: {
    alignItems: 'center',
    justifyContent: 'center',
  },
  
  iconBackground: {
    width: 160,
    height: 160,
    borderRadius: 80,
    backgroundColor: 'rgba(255, 255, 255, 0.2)',
    justifyContent: 'center',
    alignItems: 'center',
    borderWidth: 2,
    borderColor: 'rgba(255, 255, 255, 0.3)',
  },
  
  contentContainer: {
    flex: 1,
    paddingHorizontal: theme.semanticSpacing.screenPadding,
    paddingTop: theme.semanticSpacing.xl,
  },
  
  contentCard: {
    marginTop: -theme.semanticSpacing.xl,
    ...theme.shadows.lg,
  },
  
  title: {
    marginBottom: theme.semanticSpacing.sm,
  },
  
  subtitle: {
    marginBottom: theme.semanticSpacing.md,
  },
  
  description: {
    lineHeight: 24,
  },
  
  bottomSection: {
    paddingHorizontal: theme.semanticSpacing.screenPadding,
    paddingBottom: theme.semanticSpacing.lg,
  },
  
  pagination: {
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: theme.semanticSpacing.xl,
  },
  
  paginationDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
    backgroundColor: theme.colors.neutral[300],
    marginHorizontal: 4,
  },
  
  paginationDotActive: {
    backgroundColor: theme.colors.primary.main,
    width: 24,
  },
  
  buttonContainer: {
    marginTop: theme.semanticSpacing.md,
  },
});
