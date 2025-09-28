import { NavigatorScreenParams } from '@react-navigation/native';

// Service and subcategory types
export interface SubCategory {
  id: string;
  name: string;
  description: string;
  price?: string;
  icon?: string;
  duration?: number; // in minutes
  addOns?: AddOn[];
}

export interface ServiceCategory {
  id: string;
  name: string;
  icon: string;
  color: string;
  description: string;
  image: any;
  subcategories: SubCategory[];
  callOutFee?: string;
  minDuration?: number;
  maxDuration?: number;
}

export interface AddOn {
  id: string;
  name: string;
  description: string;
  price: number;
  category: string;
}

export interface Hero {
  id: string;
  name: string;
  rating: number;
  reviewCount: number;
  avatar?: string;
  skills: string[];
  isAvailable: boolean;
  distance?: number;
  priceMultiplier?: number;
}

export interface BookingRequest {
  serviceId: string;
  subcategoryId: string;
  serviceName?: string;
  variantName?: string;
  scheduledDate: string; // ISO string for navigation serialization
  scheduledTime: string;
  duration: number;
  address: {
    street: string;
    city: string;
    postalCode: string;
    coordinates?: {
      latitude: number;
      longitude: number;
    };
  };
  addOns: string[]; // AddOn IDs
  specialInstructions?: string;
  heroId?: string; // Optional - for hero selection
}

export interface Booking {
  id: string;
  status: 'draft' | 'requested' | 'confirmed' | 'en_route' | 'in_progress' | 'completed' | 'cancelled' | 'no_show';
  request: BookingRequest;
  hero?: Hero;
  pricing: {
    basePrice: number;
    callOutFee: number;
    addOnTotal: number;
    subtotal: number;
    tax: number;
    total: number;
    promoDiscount?: number;
  };
  createdAt: Date;
  updatedAt: Date;
  estimatedArrival?: Date;
  actualArrival?: Date;
  completedAt?: Date;
}

// Navigation param lists
export type RootStackParamList = {
  // Auth flow
  Auth: NavigatorScreenParams<AuthStackParamList>;
  
  // Main app
  MainTabs: NavigatorScreenParams<MainTabParamList>;
  
  // Booking flow
  ServiceDetail: {
    service: ServiceCategory;
  };
  Booking: {
    service: ServiceCategory;
    subcategory: SubCategory;
  };
  BookingConfirm: {
    bookingRequest: BookingRequest;
    pricing: Booking['pricing'];
    availableHeroes: Hero[];
  };
  BookingStatus: {
    bookingId: string;
  };
  HeroSelection: {
    bookingRequest: BookingRequest;
    availableHeroes: Hero[];
  };
  
  // Other screens
  Search: {
    initialQuery?: string;
  };
  Profile: undefined;
  Notifications: undefined;
  PaymentMethods: undefined;
  BookingHistory: undefined;
  HelpCenter: undefined;
};

export type AuthStackParamList = {
  Login: undefined;
  SignUp: undefined;
  ForgotPassword: undefined;
};

export type MainTabParamList = {
  HomeTab: undefined;
  PromosTab: undefined;
  AccountTab: undefined;
};

// Screen props types
export type ScreenProps<T extends keyof RootStackParamList> = {
  navigation: any;
  route: {
    params: RootStackParamList[T];
  };
};
