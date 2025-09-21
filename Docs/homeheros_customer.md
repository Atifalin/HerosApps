# HomeHeros (Customer App) — QRD

## Scope & Platforms
- iOS 15+, Android 8+ via Expo/React Native.  
- Covers BC Interior (Kamloops, Kelowna, Vernon, Penticton, West Kelowna, Salmon Arm).

## MVP User Stories
1. Sign up/login with OTP/2FA.  
2. Browse categories & see list of Heros (profiles, ratings, availability).  
3. Select Hero & book (address, time, notes, photos, payment).  
4. Track Hero in real-time (map, status updates).  
5. Rate, tip, get receipt/invoice.  
6. Manage bookings (reschedule, cancel).  
7. Receive push notifications for booking lifecycle events.

## Onboarding (MVP)
- Email/phone auth + OTP.  
- Profile (name, phone, email, default address).  
- Payment method setup (Stripe PaymentSheet).  
- Consent screens for location & privacy.

## Booking Lifecycle
- States: requested → awaiting_hero_accept → enroute → arrived → in_progress → completed → rated.  
- Cancellation rules: free until enroute, fee thereafter.

## Compliance & NFRs
- PIPEDA consent, location disclosure.  
- Cold start <2.5s, crash-free sessions >99.7%.

---

**Shared System Interactions**
- Uses shared **booking API** and **Stripe integration**.  
- Depends on Provider app for Hero acceptance & tracking.  
- Admin portal overrides bookings, issues refunds, manages disputes.
