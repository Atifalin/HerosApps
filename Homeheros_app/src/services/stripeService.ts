// Stripe Service - Calls Supabase Edge Function for real payment processing
// Card confirmation is handled by the Stripe SDK's useConfirmPayment hook in the screen.
import { supabase } from '../lib/supabase';

export interface StripePaymentResult {
  success: boolean;
  clientSecret?: string;
  paymentIntentId?: string;
  error?: string;
}

/**
 * Creates a PaymentIntent via the Supabase Edge Function.
 * Returns a clientSecret that the Stripe SDK uses to confirm the payment.
 */
export async function createStripePaymentIntent(params: {
  amountCents: number;
  currency: string;
  bookingId?: string;
  customerEmail?: string;
}): Promise<StripePaymentResult> {
  try {
    const { data, error } = await supabase.functions.invoke('stripe-payment-intent', {
      body: {
        amount_cents: params.amountCents,
        currency: params.currency,
        booking_id: params.bookingId || null,
        customer_email: params.customerEmail || null,
      },
    });

    if (error) {
      // FunctionsHttpError contains the response body with details
      let errorMessage = error.message || 'Failed to create payment intent';
      try {
        if (error.context && typeof error.context.json === 'function') {
          const errorBody = await error.context.json();
          console.error('Edge function error body:', JSON.stringify(errorBody));
          errorMessage = errorBody?.error || errorBody?.message || errorMessage;
        }
      } catch (e) {
        // Couldn't parse error body
      }
      console.error('Edge function error:', errorMessage);
      return {
        success: false,
        error: errorMessage,
      };
    }

    if (data?.error) {
      return {
        success: false,
        error: data.error,
      };
    }

    return {
      success: true,
      clientSecret: data.clientSecret,
      paymentIntentId: data.paymentIntentId,
    };
  } catch (err: any) {
    console.error('Stripe service error:', err);
    return {
      success: false,
      error: err.message || 'Network error',
    };
  }
}

/**
 * Updates the payment status in the database after Stripe confirmation.
 */
export async function updatePaymentStatus(
  paymentIntentId: string,
  status: string,
): Promise<void> {
  try {
    const { error } = await supabase
      .from('payments')
      .update({ status })
      .eq('stripe_pi', paymentIntentId);

    if (error) {
      console.error('Error updating payment status:', error);
    }
  } catch (err) {
    console.error('Payment status update error:', err);
  }
}
