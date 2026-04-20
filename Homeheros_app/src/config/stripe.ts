// Stripe Configuration
// Only the PUBLISHABLE key goes in the client app - NEVER the secret key
// Secret key must only be used server-side (Supabase Edge Functions)

export const STRIPE_CONFIG = {
  // Test mode publishable key - safe to include in client code
  publishableKey: process.env.EXPO_PUBLIC_STRIPE_PUBLISHABLE_KEY || 
    'pk_test_51Sm727HNOU7L52244XGVwCKKDurnxFz7ZUDFdTar7GiPJ9tkTb5FT4HHaHTBCp67KEEjpdWWIBVltegOHKtAgNjF004IAFIjzx',
  
  // Merchant display name shown on payment sheet
  merchantDisplayName: 'HomeHeros',
  
  // Default currency
  currency: 'cad',
  
  // Country code
  countryCode: 'CA',
};
