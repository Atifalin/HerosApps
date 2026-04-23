import React, { createContext, useContext, useState, useEffect } from 'react';
import * as Location from 'expo-location';

// List of supported cities from QRD
export const SUPPORTED_CITIES = [
  'Kamloops',
  'Kelowna',
  'Vernon',
  'Penticton',
  'West Kelowna',
  'Salmon Arm',
  'Metro Vancouver'
];

interface LocationContextType {
  currentCity: string;
  loading: boolean;
  error: string | null;
  setCity: (city: string) => void;
  supportedCities: string[];
}

const LocationContext = createContext<LocationContextType | undefined>(undefined);

export const useLocation = () => {
  const context = useContext(LocationContext);
  if (context === undefined) {
    throw new Error('useLocation must be used within a LocationProvider');
  }
  return context;
};

interface LocationProviderProps {
  children: React.ReactNode;
}

export const LocationProvider: React.FC<LocationProviderProps> = ({ children }) => {
  const [currentCity, setCurrentCity] = useState<string>('Kelowna'); // Default city
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);

  // Function to determine city from coordinates using a simplified approach
  // In a real app, you would use a proper geocoding service with API key
  const getCityFromCoordinates = async (latitude: number, longitude: number) => {
    try {
      // For demo purposes, we'll use a simple distance calculation to determine the closest city
      // These are approximate coordinates for the supported cities
      const cityCoordinates = {
        'Kamloops': { lat: 50.6745, lng: -120.3273 },
        'Kelowna': { lat: 49.8880, lng: -119.4960 },
        'Vernon': { lat: 50.2671, lng: -119.2720 },
        'Penticton': { lat: 49.4991, lng: -119.5937 },
        'West Kelowna': { lat: 49.8636, lng: -119.5833 },
        'Salmon Arm': { lat: 50.7001, lng: -119.2838 },
        'Metro Vancouver': { lat: 49.2827, lng: -123.1207 },
      };
      
      // Calculate distance to each city
      let closestCity = 'Kelowna';
      let shortestDistance = Number.MAX_VALUE;
      
      for (const [city, coords] of Object.entries(cityCoordinates)) {
        const distance = Math.sqrt(
          Math.pow(latitude - coords.lat, 2) + 
          Math.pow(longitude - coords.lng, 2)
        );
        
        if (distance < shortestDistance) {
          shortestDistance = distance;
          closestCity = city;
        }
      }
      
      return closestCity;
    } catch (error) {
      console.error('Error determining city from coordinates:', error);
      return 'Kelowna'; // Default city
    }
  };

  // Get user's location on component mount
  useEffect(() => {
    const getLocation = async () => {
      setLoading(true);
      setError(null);
      
      try {
        // Request location permissions
        const { status } = await Location.requestForegroundPermissionsAsync();
        
        if (status !== 'granted') {
          console.log('Location permission denied, using default city');
          setLoading(false);
          return; // Keep using default city
        }
        
        // Get current position with timeout and high accuracy
        const location = await Location.getCurrentPositionAsync({
          accuracy: Location.Accuracy.Balanced,
          timeInterval: 5000,
        }).catch(err => {
          console.log('Error getting position, using default city:', err);
          return null;
        });
        
        if (location) {
          const { latitude, longitude } = location.coords;
          
          // Get city name from coordinates
          const city = await getCityFromCoordinates(latitude, longitude);
          setCurrentCity(city);
        }
      } catch (error) {
        console.log('Error in location service, using default city:', error);
        // Keep using default city, don't set error state to avoid showing error to user
      } finally {
        setLoading(false);
      }
    };
    
    getLocation();
  }, []);

  const setCity = (city: string) => {
    if (SUPPORTED_CITIES.includes(city)) {
      setCurrentCity(city);
    } else {
      console.warn(`City ${city} is not supported`);
    }
  };

  const value: LocationContextType = {
    currentCity,
    loading,
    error,
    setCity,
    supportedCities: SUPPORTED_CITIES,
  };

  return (
    <LocationContext.Provider value={value}>
      {children}
    </LocationContext.Provider>
  );
};
