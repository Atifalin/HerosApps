// Mock Payment Service - Easily replaceable with Stripe integration
import { supabase } from '../lib/supabase';

export interface PaymentMethod {
  id: string;
  type: 'card' | 'apple_pay' | 'google_pay';
  last4?: string;
  brand?: string;
  expiryMonth?: number;
  expiryYear?: number;
  isDefault: boolean;
}

export interface PaymentIntent {
  id: string;
  amount: number;
  currency: string;
  status: 'pending' | 'authorized' | 'captured' | 'failed' | 'refunded';
  paymentMethodId: string;
  bookingId: string;
}

export interface PaymentResult {
  success: boolean;
  paymentIntent?: PaymentIntent;
  error?: string;
}

/**
 * PaymentServiceInterface defines the contract that any payment provider must implement.
 * This makes it easy to swap between mock payments and real Stripe integration.
 */
export interface PaymentServiceInterface {
  getPaymentMethods(userId: string): Promise<PaymentMethod[]>;
  addPaymentMethod(userId: string, cardDetails: any): Promise<PaymentResult>;
  createPaymentIntent(amount: number, currency: string, paymentMethodId: string, bookingId: string): Promise<PaymentResult>;
  capturePayment(paymentIntentId: string): Promise<PaymentResult>;
  refundPayment(paymentIntentId: string, amount?: number): Promise<PaymentResult>;
  initializeStripe?(): Promise<void>;
}

/**
 * Mock implementation of the PaymentService that simulates payment processing
 * without requiring actual payment infrastructure.
 */
class MockPaymentService implements PaymentServiceInterface {
  // Test cards that match Stripe's test cards for easy migration
  private mockPaymentMethods: PaymentMethod[] = [
    {
      id: 'pm_mock_visa_success',
      type: 'card',
      last4: '4242',
      brand: 'visa',
      expiryMonth: 12,
      expiryYear: 2028,
      isDefault: true
    },
    {
      id: 'pm_mock_visa_declined',
      type: 'card',
      last4: '0341',
      brand: 'visa',
      expiryMonth: 8,
      expiryYear: 2027,
      isDefault: false
    },
    {
      id: 'pm_mock_mastercard',
      type: 'card',
      last4: '5556',
      brand: 'mastercard',
      expiryMonth: 10,
      expiryYear: 2026,
      isDefault: false
    },
    {
      id: 'pm_mock_amex',
      type: 'card',
      last4: '0005',
      brand: 'amex',
      expiryMonth: 4,
      expiryYear: 2025,
      isDefault: false
    },
    {
      id: 'pm_mock_apple_pay',
      type: 'apple_pay',
      isDefault: false
    }
  ];

  // Simulate network delay
  private async delay(ms: number = 1000): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  // Get saved payment methods for user
  async getPaymentMethods(userId: string): Promise<PaymentMethod[]> {
    await this.delay(500);
    // In real implementation, fetch from Stripe/backend
    return this.mockPaymentMethods;
  }

  // Add new payment method
  async addPaymentMethod(
    userId: string, 
    cardDetails: {
      number: string;
      expiryMonth: number;
      expiryYear: number;
      cvc: string;
      holderName: string;
    }
  ): Promise<PaymentResult> {
    await this.delay(1500);
    
    // Mock validation
    if (cardDetails.number.length < 16) {
      return {
        success: false,
        error: 'Invalid card number'
      };
    }

    const newPaymentMethod: PaymentMethod = {
      id: `pm_mock_${Date.now()}`,
      type: 'card',
      last4: cardDetails.number.slice(-4),
      brand: this.getCardBrand(cardDetails.number),
      expiryMonth: cardDetails.expiryMonth,
      expiryYear: cardDetails.expiryYear,
      isDefault: this.mockPaymentMethods.length === 0
    };

    this.mockPaymentMethods.push(newPaymentMethod);

    return {
      success: true,
      paymentIntent: {
        id: `pi_mock_${Date.now()}`,
        amount: 0,
        currency: 'cad',
        status: 'authorized',
        paymentMethodId: newPaymentMethod.id,
        bookingId: ''
      }
    };
  }

  // Create payment intent (authorize payment)
  async createPaymentIntent(
    amount: number,
    currency: string = 'cad',
    paymentMethodId: string,
    bookingId: string
  ): Promise<PaymentResult> {
    await this.delay(2000);

    // Simulate specific card behaviors for testing
    // This matches Stripe's test card behavior for easy migration later
    const shouldFail = paymentMethodId === 'pm_mock_visa_declined' || 
                      (paymentMethodId !== 'pm_mock_visa_success' && Math.random() < 0.05);

    if (shouldFail) {
      return {
        success: false,
        error: 'Payment authorization failed. Please try again.'
      };
    }

    const paymentIntent: PaymentIntent = {
      id: `pi_mock_${Date.now()}`,
      amount,
      currency,
      status: 'authorized',
      paymentMethodId,
      bookingId
    };

    // Store in Supabase
    try {
      const { error } = await supabase
        .from('payments')
        .insert({
          booking_id: bookingId,
          stripe_pi: paymentIntent.id, // Use stripe_pi instead of payment_intent_id
          amount_cents: amount, // Use amount_cents instead of amount
          currency: currency.toUpperCase(),
          status: 'authorized',
          // Additional fields can be added here if needed
        });

      if (error) {
        console.error('Error storing payment record:', error);
      }
    } catch (err) {
      console.error('Payment storage error:', err);
    }

    return {
      success: true,
      paymentIntent
    };
  }

  // Capture payment (charge the customer)
  async capturePayment(paymentIntentId: string): Promise<PaymentResult> {
    await this.delay(1000);

    try {
      const { error } = await supabase
        .from('payments')
        .update({ 
          status: 'captured',
          captured_at: new Date().toISOString()
        })
        .eq('stripe_pi', paymentIntentId);

      if (error) {
        return {
          success: false,
          error: 'Failed to capture payment'
        };
      }

      return {
        success: true,
        paymentIntent: {
          id: paymentIntentId,
          amount: 0,
          currency: 'cad',
          status: 'captured',
          paymentMethodId: '',
          bookingId: ''
        }
      };
    } catch (err) {
      return {
        success: false,
        error: 'Payment capture failed'
      };
    }
  }

  // Refund payment
  async refundPayment(
    paymentIntentId: string, 
    amount?: number
  ): Promise<PaymentResult> {
    await this.delay(1500);

    try {
      const { error } = await supabase
        .from('payments')
        .update({ 
          status: 'refunded',
          refunded_cents: amount || 0,
          refund_reason: 'Customer requested refund'
        })
        .eq('stripe_pi', paymentIntentId);

      if (error) {
        return {
          success: false,
          error: 'Failed to process refund'
        };
      }

      return {
        success: true,
        paymentIntent: {
          id: paymentIntentId,
          amount: amount || 0,
          currency: 'cad',
          status: 'refunded',
          paymentMethodId: '',
          bookingId: ''
        }
      };
    } catch (err) {
      return {
        success: false,
        error: 'Refund processing failed'
      };
    }
  }

  // Helper methods
  private getCardBrand(cardNumber: string): string {
    const firstDigit = cardNumber.charAt(0);
    const firstTwoDigits = cardNumber.substring(0, 2);
    
    if (firstDigit === '4') return 'visa';
    if (['51', '52', '53', '54', '55'].includes(firstTwoDigits)) return 'mastercard';
    if (['34', '37'].includes(firstTwoDigits)) return 'amex';
    if (firstTwoDigits === '60') return 'discover';
    
    return 'unknown';
  }

  private getPaymentMethodById(id: string): PaymentMethod | undefined {
    return this.mockPaymentMethods.find(pm => pm.id === id);
  }

  // Method to easily replace with Stripe
  async initializeStripe(): Promise<void> {
    // This method will be replaced when integrating with Stripe
    console.log('Mock payment service initialized');
  }
}

// Export singleton instance
export const paymentService: PaymentServiceInterface = new MockPaymentService();

// Types for easy migration to Stripe
export type StripePaymentMethod = PaymentMethod;
export type StripePaymentIntent = PaymentIntent;
export type StripePaymentResult = PaymentResult;

/**
 * When ready to integrate with Stripe, create a new class that implements PaymentServiceInterface
 * and replace the exported instance. Example:
 * 
 * class StripePaymentService implements PaymentServiceInterface {
 *   // Implement all required methods using Stripe SDK
 * }
 * 
 * export const paymentService: PaymentServiceInterface = new StripePaymentService();
 */
