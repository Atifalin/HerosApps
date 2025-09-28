import { ServiceCategory, AddOn } from '../navigation/types';

// Add-ons catalog
export const addOnsCatalog: Record<string, AddOn[]> = {
  maidServices: [
    {
      id: 'fridge-cleaning',
      name: 'Fridge Cleaning',
      description: 'Deep clean inside and outside of refrigerator',
      price: 50,
      category: 'kitchen'
    },
    {
      id: 'oven-cleaning',
      name: 'Oven Cleaning',
      description: 'Deep clean oven interior and exterior',
      price: 75,
      category: 'kitchen'
    },
    {
      id: 'garage-cleaning',
      name: 'Garage Cleaning',
      description: 'Sweep and organize garage space',
      price: 75,
      category: 'exterior'
    },
    {
      id: 'basement-cleaning',
      name: 'Basement Cleaning',
      description: 'Clean and organize basement area',
      price: 100,
      category: 'interior'
    },
    {
      id: 'window-cleaning',
      name: 'Window Cleaning',
      description: 'Clean interior and exterior windows',
      price: 60,
      category: 'windows'
    }
  ],
  handymen: [
    {
      id: 'additional-outlet',
      name: 'Additional Outlet Installation',
      description: 'Install additional electrical outlet',
      price: 150,
      category: 'electrical'
    },
    {
      id: 'fixture-installation',
      name: 'Light Fixture Installation',
      description: 'Install new light fixture',
      price: 100,
      category: 'electrical'
    },
    {
      id: 'furniture-assembly',
      name: 'Furniture Assembly',
      description: 'Assemble furniture pieces',
      price: 80,
      category: 'assembly'
    }
  ],
  cooksChefs: [
    {
      id: 'grocery-shopping',
      name: 'Grocery Shopping',
      description: 'Purchase ingredients for meal preparation',
      price: 25,
      category: 'preparation'
    },
    {
      id: 'meal-prep',
      name: 'Meal Prep Service',
      description: 'Prepare multiple meals for the week',
      price: 150,
      category: 'preparation'
    },
    {
      id: 'special-diet',
      name: 'Special Diet Accommodation',
      description: 'Accommodate special dietary requirements',
      price: 50,
      category: 'customization'
    }
  ]
};

// Service catalog with detailed configurations
export const serviceCatalog: ServiceCategory[] = [
  {
    id: 'maid-services',
    name: 'Maid Services',
    icon: 'home-outline',
    color: '#4A5D23',
    description: 'Professional Cleaning',
    image: require('../../assets/Services_images/cleaning.png'),
    callOutFee: 'No call-out fee',
    minDuration: 120, // 2 hours
    maxDuration: 480, // 8 hours
    subcategories: [
      {
        id: 'deep-cleaning',
        name: 'Deep Cleaning',
        description: 'Complete home cleaning service',
        price: 'From $250',
        duration: 240, // 4 hours
        addOns: addOnsCatalog.maidServices
      },
      {
        id: 'regular-cleaning',
        name: 'Regular Cleaning',
        description: 'Weekly/bi-weekly maintenance cleaning',
        price: 'From $150',
        duration: 180, // 3 hours
        addOns: addOnsCatalog.maidServices
      },
      {
        id: 'move-in-out',
        name: 'Move In/Out Cleaning',
        description: 'Thorough cleaning for moving',
        price: 'From $300',
        duration: 300, // 5 hours
        addOns: addOnsCatalog.maidServices
      },
      {
        id: 'pool-cleaning',
        name: 'Swimming Pool Cleaning',
        description: 'Pool cleaning service',
        price: '$500',
        duration: 120, // 2 hours
        addOns: []
      }
    ]
  },
  {
    id: 'cooks-chefs',
    name: 'Cooks & Chefs',
    icon: 'restaurant-outline',
    color: '#FF6B35',
    description: 'Personal Chef Services',
    image: require('../../assets/Services_images/cooking.png'),
    callOutFee: 'No call-out fee',
    minDuration: 120, // 2 hours
    maxDuration: 480, // 8 hours
    subcategories: [
      {
        id: 'home-cooking',
        name: 'Home Cooking',
        description: 'Daily meals tailored to your taste & diet',
        price: '$75/hour',
        duration: 180, // 3 hours
        addOns: addOnsCatalog.cooksChefs
      },
      {
        id: 'meal-prep',
        name: 'Meal Prep',
        description: 'Weekly meal preparation service',
        price: '$200/session',
        duration: 240, // 4 hours
        addOns: addOnsCatalog.cooksChefs
      },
      {
        id: 'special-events',
        name: 'Special Event Catering',
        description: 'Private chef for special occasions',
        price: '$150/hour',
        duration: 300, // 5 hours
        addOns: addOnsCatalog.cooksChefs
      }
    ]
  },
  {
    id: 'event-planning',
    name: 'Event Planning',
    icon: 'calendar-outline',
    color: '#6C5CE7',
    description: 'Complete Event Management',
    image: require('../../assets/Services_images/event.png'),
    callOutFee: 'Consultation fee applies',
    minDuration: 240, // 4 hours
    maxDuration: 720, // 12 hours
    subcategories: [
      {
        id: 'birthday-parties',
        name: 'Birthday Parties',
        description: 'Complete birthday party planning',
        price: 'Custom packages',
        duration: 360, // 6 hours
        addOns: []
      },
      {
        id: 'corporate-events',
        name: 'Corporate Events',
        description: 'Professional corporate event planning',
        price: 'Custom packages',
        duration: 480, // 8 hours
        addOns: []
      },
      {
        id: 'weddings',
        name: 'Wedding Planning',
        description: 'Full wedding planning service',
        price: 'Custom packages',
        duration: 720, // 12 hours
        addOns: []
      }
    ]
  },
  {
    id: 'travel-services',
    name: 'Travel Services',
    icon: 'airplane-outline',
    color: '#00B894',
    description: 'Tour Guides & Travel',
    image: require('../../assets/Services_images/travel.png'),
    callOutFee: 'Travel fee may apply',
    minDuration: 240, // 4 hours
    maxDuration: 720, // 12 hours
    subcategories: [
      {
        id: 'city-tours',
        name: 'City Tours',
        description: 'Guided city exploration',
        price: '$100/hour',
        duration: 240, // 4 hours
        addOns: []
      },
      {
        id: 'adventure-tours',
        name: 'Adventure Tours',
        description: 'Outdoor adventure experiences',
        price: '$150/hour',
        duration: 360, // 6 hours
        addOns: []
      },
      {
        id: 'travel-planning',
        name: 'Travel Planning',
        description: 'Complete travel itinerary planning',
        price: 'Custom packages',
        duration: 120, // 2 hours consultation
        addOns: []
      }
    ]
  },
  {
    id: 'handymen',
    name: 'Handymen',
    icon: 'build-outline',
    color: '#FDCB6E',
    description: 'Home Improvements',
    image: require('../../assets/Services_images/handyman.png'),
    callOutFee: '$65 call out fee',
    minDuration: 60, // 1 hour
    maxDuration: 480, // 8 hours
    subcategories: [
      {
        id: 'repairs-installs',
        name: 'Repairs & Installs',
        description: 'Fixtures, furniture assembly, shelves',
        price: '$65 call out fee',
        duration: 120, // 2 hours
        addOns: addOnsCatalog.handymen
      },
      {
        id: 'electrical',
        name: 'Electrical',
        description: 'Switches, fans, lighting, smart home',
        price: '$65 call out fee',
        duration: 90, // 1.5 hours
        addOns: addOnsCatalog.handymen
      },
      {
        id: 'plumbing',
        name: 'Plumbing',
        description: 'Drains, toilet repairs, shower fittings',
        price: '$65 call out fee',
        duration: 120, // 2 hours
        addOns: addOnsCatalog.handymen
      },
      {
        id: 'painting',
        name: 'Painting',
        description: 'Interior and exterior painting',
        price: '$65 call out fee',
        duration: 240, // 4 hours
        addOns: addOnsCatalog.handymen
      }
    ]
  },
  {
    id: 'auto-services',
    name: 'Auto Services',
    icon: 'car-outline',
    color: '#E84393',
    description: 'Repair & Detailing',
    image: require('../../assets/Services_images/auto.png'),
    callOutFee: '$150 call out fee',
    minDuration: 120, // 2 hours
    maxDuration: 480, // 8 hours
    subcategories: [
      {
        id: 'mobile-detailing',
        name: 'Mobile Detailing',
        description: 'Complete car detailing at your location',
        price: '$150 call out fee',
        duration: 180, // 3 hours
        addOns: []
      },
      {
        id: 'mobile-repair',
        name: 'Mobile Repair',
        description: 'On-site automotive repairs',
        price: '$150 call out fee',
        duration: 240, // 4 hours
        addOns: []
      },
      {
        id: 'maintenance',
        name: 'Maintenance',
        description: 'Regular vehicle maintenance',
        price: '$150 call out fee',
        duration: 120, // 2 hours
        addOns: []
      }
    ]
  },
  {
    id: 'personal-care',
    name: 'Personal Care',
    icon: 'flower-outline',
    color: '#A29BFE',
    description: 'Massage & Salon at Home',
    image: require('../../assets/Services_images/personalcare.png'),
    callOutFee: 'No call-out fee',
    minDuration: 60, // 1 hour
    maxDuration: 240, // 4 hours
    subcategories: [
      {
        id: 'massage-therapy',
        name: 'Massage Therapy',
        description: 'Professional massage at home',
        price: '$120/hour',
        duration: 90, // 1.5 hours
        addOns: []
      },
      {
        id: 'hair-styling',
        name: 'Hair Styling',
        description: 'Professional hair styling at home',
        price: '$80/hour',
        duration: 120, // 2 hours
        addOns: []
      },
      {
        id: 'beauty-services',
        name: 'Beauty Services',
        description: 'Makeup, nails, and beauty treatments',
        price: '$100/hour',
        duration: 90, // 1.5 hours
        addOns: []
      }
    ]
  }
];

// Helper functions
export const getServiceById = (serviceId: string): ServiceCategory | undefined => {
  return serviceCatalog.find(service => service.id === serviceId);
};

export const getSubcategoryById = (serviceId: string, subcategoryId: string) => {
  const service = getServiceById(serviceId);
  return service?.subcategories.find(sub => sub.id === subcategoryId);
};

export const getAddOnsByCategory = (serviceId: string): AddOn[] => {
  const categoryKey = serviceId.replace('-', '');
  return addOnsCatalog[categoryKey] || [];
};
