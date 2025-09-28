import React, { useState, useEffect } from 'react';
import {
  View,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  TextInput,
  FlatList,
  ActivityIndicator,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { StatusBar } from 'expo-status-bar';
import { Ionicons } from '@expo/vector-icons';
import { Typography, Card } from '../../components/ui';
import { theme } from '../../theme';
import { useLocation } from '../../contexts/LocationContext';

interface SearchScreenProps {
  navigation: any;
  route: {
    params?: {
      initialQuery?: string;
    };
  };
}

interface SearchResult {
  id: string;
  type: 'service' | 'subcategory' | 'hero';
  title: string;
  description: string;
  icon?: keyof typeof Ionicons.glyphMap;
  image?: any;
  parentId?: string;
  parentName?: string;
  price?: string;
  rating?: number;
  color?: string;
}

// Mock search data - in a real app, this would come from an API
const mockSearchResults: SearchResult[] = [
  {
    id: '1-1',
    type: 'service',
    title: 'Maid Services',
    description: 'Professional Cleaning',
    icon: 'home-outline',
    color: '#4A5D23',
  },
  {
    id: '1-2',
    type: 'subcategory',
    title: 'Deep Cleaning',
    description: 'Complete home cleaning service',
    parentId: '1',
    parentName: 'Maid Services',
    price: 'From $250',
  },
  {
    id: '1-3',
    type: 'subcategory',
    title: 'Swimming Pool Cleaning',
    description: 'Pool cleaning service',
    parentId: '1',
    parentName: 'Maid Services',
    price: '$500',
  },
  {
    id: '2-1',
    type: 'service',
    title: 'Cooks & Chefs',
    description: 'Personal Chef Services',
    icon: 'restaurant-outline',
    color: '#FF6B35',
  },
  {
    id: '2-2',
    type: 'subcategory',
    title: 'Home Cooking',
    description: 'Daily meals tailored to your taste & diet',
    parentId: '2',
    parentName: 'Cooks & Chefs',
    price: '$75/hour',
  },
  {
    id: '3-1',
    type: 'service',
    title: 'Event Planning',
    description: 'Complete Event Management',
    icon: 'calendar-outline',
    color: '#6C5CE7',
  },
  {
    id: '4-1',
    type: 'service',
    title: 'Travel Services',
    description: 'Tour Guides & Travel',
    icon: 'airplane-outline',
    color: '#00B894',
  },
  {
    id: '5-1',
    type: 'service',
    title: 'Handymen',
    description: 'Home Improvements',
    icon: 'build-outline',
    color: '#FDCB6E',
  },
  {
    id: '5-2',
    type: 'subcategory',
    title: 'Electrical',
    description: 'Switches, fans, lighting, smart home',
    parentId: '5',
    parentName: 'Handymen',
    price: '$65 call out fee',
  },
  {
    id: '5-3',
    type: 'subcategory',
    title: 'Plumbing',
    description: 'Drains, toilet repairs, shower fittings',
    parentId: '5',
    parentName: 'Handymen',
    price: '$65 call out fee',
  },
  {
    id: '6-1',
    type: 'service',
    title: 'Auto Services',
    description: 'Repair & Detailing',
    icon: 'car-outline',
    color: '#E84393',
  },
  {
    id: '7-1',
    type: 'service',
    title: 'Personal Care',
    description: 'Massage & Salon at Home',
    icon: 'flower-outline',
    color: '#A29BFE',
  },
  {
    id: 'h1',
    type: 'hero',
    title: 'John Smith',
    description: 'Professional Cleaner',
    rating: 4.8,
    parentId: '1',
    parentName: 'Maid Services',
  },
  {
    id: 'h2',
    type: 'hero',
    title: 'Maria Johnson',
    description: 'Professional Chef',
    rating: 4.9,
    parentId: '2',
    parentName: 'Cooks & Chefs',
  },
];

export const SearchScreen: React.FC<SearchScreenProps> = ({ navigation, route }) => {
  const { currentCity } = useLocation();
  const [query, setQuery] = useState(route.params?.initialQuery || '');
  const [results, setResults] = useState<SearchResult[]>([]);
  const [loading, setLoading] = useState(false);
  const [recentSearches, setRecentSearches] = useState<string[]>([
    'cleaning', 'chef', 'plumbing'
  ]);

  // Perform search when query changes
  useEffect(() => {
    if (query.trim() === '') {
      setResults([]);
      return;
    }

    setLoading(true);
    
    // Simulate API call delay
    const timer = setTimeout(() => {
      // Filter mock results based on query
      const filteredResults = mockSearchResults.filter(item => 
        item.title.toLowerCase().includes(query.toLowerCase()) ||
        item.description.toLowerCase().includes(query.toLowerCase()) ||
        (item.parentName && item.parentName.toLowerCase().includes(query.toLowerCase()))
      );
      
      setResults(filteredResults);
      setLoading(false);
      
      // Add to recent searches if not already there
      if (query.trim() !== '' && !recentSearches.includes(query.trim())) {
        setRecentSearches(prev => [query.trim(), ...prev.slice(0, 4)]);
      }
    }, 500);
    
    return () => clearTimeout(timer);
  }, [query]);

  const handleClearSearch = () => {
    setQuery('');
    setResults([]);
  };

  const handleResultPress = (result: SearchResult) => {
    if (result.type === 'service') {
      // Find the full service object and navigate to service detail
      const serviceId = result.id.split('-')[0];
      // In a real app, you would fetch the full service object
      console.log(`Navigate to service: ${result.title}`);
      navigation.navigate('ServiceDetail', { 
        service: {
          id: serviceId,
          name: result.title,
          description: result.description,
          icon: result.icon,
          color: result.color,
          // Add other required properties
        }
      });
    } else if (result.type === 'subcategory') {
      // Navigate to booking flow with subcategory
      console.log(`Navigate to booking for subcategory: ${result.title}`);
      // navigation.navigate('Booking', { subcategory: result });
    } else if (result.type === 'hero') {
      // Navigate to hero profile
      console.log(`Navigate to hero profile: ${result.title}`);
      // navigation.navigate('HeroProfile', { heroId: result.id });
    }
  };

  const handleRecentSearchPress = (searchTerm: string) => {
    setQuery(searchTerm);
  };

  const renderResultItem = ({ item }: { item: SearchResult }) => (
    <TouchableOpacity
      style={styles.resultItem}
      onPress={() => handleResultPress(item)}
      activeOpacity={0.7}
    >
      {item.type === 'service' && item.icon && (
        <View style={[styles.serviceIcon, { backgroundColor: `${item.color}15` }]}>
          <Ionicons name={item.icon} size={24} color={item.color} />
        </View>
      )}
      
      {item.type === 'subcategory' && (
        <View style={styles.subcategoryIcon}>
          <Ionicons name="list-outline" size={20} color={theme.colors.text.secondary} />
        </View>
      )}
      
      {item.type === 'hero' && (
        <View style={styles.heroIcon}>
          <Ionicons name="person-outline" size={20} color={theme.colors.text.secondary} />
        </View>
      )}
      
      <View style={styles.resultContent}>
        <Typography variant="body1" weight="medium">
          {item.title}
        </Typography>
        
        <View style={styles.resultMeta}>
          {item.parentName && (
            <Typography variant="caption" color="secondary" style={styles.parentName}>
              {item.parentName}
            </Typography>
          )}
          
          <Typography variant="body2" color="secondary">
            {item.description}
          </Typography>
        </View>
        
        {item.price && (
          <Typography variant="caption" color="brand" weight="medium">
            {item.price}
          </Typography>
        )}
        
        {item.rating && (
          <View style={styles.ratingContainer}>
            <Ionicons name="star" size={14} color="#FFD700" />
            <Typography variant="caption" weight="medium" style={styles.rating}>
              {item.rating}
            </Typography>
          </View>
        )}
      </View>
      
      <Ionicons name="chevron-forward" size={20} color={theme.colors.text.secondary} />
    </TouchableOpacity>
  );

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar style="dark" backgroundColor={theme.colors.background.primary} />
      
      {/* Search Header */}
      <View style={styles.searchHeader}>
        <TouchableOpacity
          style={styles.backButton}
          onPress={() => navigation.goBack()}
        >
          <Ionicons name="arrow-back" size={24} color={theme.colors.text.primary} />
        </TouchableOpacity>
        
        <View style={styles.searchInputContainer}>
          <Ionicons name="search-outline" size={20} color={theme.colors.text.secondary} style={styles.searchIcon} />
          <TextInput
            style={styles.searchInput}
            placeholder="Search for services..."
            placeholderTextColor={theme.colors.text.tertiary}
            value={query}
            onChangeText={setQuery}
            autoFocus
            returnKeyType="search"
          />
          {query.length > 0 && (
            <TouchableOpacity onPress={handleClearSearch}>
              <Ionicons name="close-circle" size={20} color={theme.colors.text.secondary} />
            </TouchableOpacity>
          )}
        </View>
      </View>
      
      {/* Search Results */}
      {loading ? (
        <View style={styles.loadingContainer}>
          <ActivityIndicator size="large" color={theme.colors.primary.main} />
        </View>
      ) : results.length > 0 ? (
        <FlatList
          data={results}
          renderItem={renderResultItem}
          keyExtractor={item => item.id}
          contentContainerStyle={styles.resultsList}
          showsVerticalScrollIndicator={false}
          ListHeaderComponent={
            <Typography variant="body2" color="secondary" style={styles.resultsHeader}>
              {results.length} results in {currentCity}
            </Typography>
          }
        />
      ) : query.trim() !== '' ? (
        <View style={styles.noResultsContainer}>
          <Ionicons name="search-outline" size={48} color={theme.colors.text.tertiary} />
          <Typography variant="h6" weight="medium" style={styles.noResultsTitle}>
            No results found
          </Typography>
          <Typography variant="body2" color="secondary" align="center">
            We couldn't find any matches for "{query}"
          </Typography>
          <Typography variant="body2" color="secondary" align="center">
            Try different keywords or browse services
          </Typography>
        </View>
      ) : (
        <ScrollView style={styles.recentSearchesContainer}>
          <Typography variant="h6" weight="medium" style={styles.recentSearchesTitle}>
            Recent Searches
          </Typography>
          
          {recentSearches.map((search, index) => (
            <TouchableOpacity
              key={index}
              style={styles.recentSearchItem}
              onPress={() => handleRecentSearchPress(search)}
            >
              <Ionicons name="time-outline" size={20} color={theme.colors.text.secondary} />
              <Typography variant="body1" style={styles.recentSearchText}>
                {search}
              </Typography>
            </TouchableOpacity>
          ))}
          
          <Typography variant="h6" weight="medium" style={styles.popularTitle}>
            Popular Services
          </Typography>
          
          <View style={styles.popularContainer}>
            {mockSearchResults
              .filter(item => item.type === 'service')
              .slice(0, 4)
              .map(service => (
                <TouchableOpacity
                  key={service.id}
                  style={styles.popularItem}
                  onPress={() => handleResultPress(service)}
                >
                  <View style={[styles.popularIcon, { backgroundColor: `${service.color}15` }]}>
                    <Ionicons name={service.icon as any} size={24} color={service.color} />
                  </View>
                  <Typography variant="body2" weight="medium" style={styles.popularText}>
                    {service.title}
                  </Typography>
                </TouchableOpacity>
              ))
            }
          </View>
        </ScrollView>
      )}
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: theme.colors.background.primary,
  },
  searchHeader: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: theme.semanticSpacing.md,
    paddingVertical: theme.semanticSpacing.md,
    borderBottomWidth: 1,
    borderBottomColor: theme.colors.border.light,
  },
  backButton: {
    marginRight: theme.semanticSpacing.sm,
    padding: theme.semanticSpacing.xs,
  },
  searchInputContainer: {
    flex: 1,
    flexDirection: 'row',
    alignItems: 'center',
    backgroundColor: theme.colors.background.secondary,
    borderRadius: theme.borderRadius.md,
    paddingHorizontal: theme.semanticSpacing.sm,
    height: 40,
  },
  searchIcon: {
    marginRight: theme.semanticSpacing.xs,
  },
  searchInput: {
    flex: 1,
    height: '100%',
    fontSize: 16,
    color: theme.colors.text.primary,
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  resultsList: {
    paddingHorizontal: theme.semanticSpacing.screenPadding,
    paddingBottom: theme.semanticSpacing.xl,
  },
  resultsHeader: {
    marginTop: theme.semanticSpacing.md,
    marginBottom: theme.semanticSpacing.sm,
  },
  resultItem: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: theme.semanticSpacing.md,
    borderBottomWidth: 1,
    borderBottomColor: theme.colors.border.light,
  },
  serviceIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: theme.semanticSpacing.md,
  },
  subcategoryIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: theme.colors.background.secondary,
    marginRight: theme.semanticSpacing.md,
  },
  heroIcon: {
    width: 40,
    height: 40,
    borderRadius: 20,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: theme.colors.background.secondary,
    marginRight: theme.semanticSpacing.md,
  },
  resultContent: {
    flex: 1,
  },
  resultMeta: {
    marginTop: 2,
  },
  parentName: {
    marginBottom: 2,
  },
  ratingContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: 4,
  },
  rating: {
    marginLeft: 4,
  },
  noResultsContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    paddingHorizontal: theme.semanticSpacing.screenPadding,
  },
  noResultsTitle: {
    marginTop: theme.semanticSpacing.md,
    marginBottom: theme.semanticSpacing.sm,
  },
  recentSearchesContainer: {
    flex: 1,
    paddingHorizontal: theme.semanticSpacing.screenPadding,
    paddingTop: theme.semanticSpacing.md,
  },
  recentSearchesTitle: {
    marginBottom: theme.semanticSpacing.md,
  },
  recentSearchItem: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingVertical: theme.semanticSpacing.sm,
    borderBottomWidth: 1,
    borderBottomColor: theme.colors.border.light,
  },
  recentSearchText: {
    marginLeft: theme.semanticSpacing.sm,
  },
  popularTitle: {
    marginTop: theme.semanticSpacing.xl,
    marginBottom: theme.semanticSpacing.md,
  },
  popularContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    justifyContent: 'space-between',
  },
  popularItem: {
    width: '48%',
    alignItems: 'center',
    marginBottom: theme.semanticSpacing.lg,
  },
  popularIcon: {
    width: 60,
    height: 60,
    borderRadius: 30,
    justifyContent: 'center',
    alignItems: 'center',
    marginBottom: theme.semanticSpacing.sm,
  },
  popularText: {
    textAlign: 'center',
  },
});
