# HomeHeros — Master QRD

This document is the **master specification** for the HomeHeros ecosystem.  
It covers all three projects and ensures their interaction and shared components are clearly defined.

---

## Projects Overview

1. **HomeHeros (Customer App)**  
   - iOS/Android app (Expo/React Native).  
   - Customers browse, select, and book *Heros* (service providers).  
   - Unique USP: customers can **choose individual Heros** even for one-time jobs.

2. **HomeHeros Go (Provider App)**  
   - iOS/Android app (Expo/React Native).  
   - For Heros (supplied by Contractors).  
   - Provides onboarding, job offers, navigation, job status updates, and earnings dashboard.

3. **Admin Portal / CRM**  
   - Web-based app (Next.js or Vite + Vercel).  
   - For Admin, Ops/CS, Finance, and Contractor Managers.  
   - Includes live ops board, disputes, payments, contractors/Heros management, and reports.

---

## Shared Components

- **Authentication & RBAC**  
  - JWT short-lived tokens + refresh.  
  - Roles: customer, hero, contractor_manager, admin, cs, finance.

- **Booking Lifecycle**  
  - `requested → awaiting_hero_accept → enroute → arrived → in_progress → completed → rated`  
  - Side states: declined, expired, cancelled_by_customer, cancelled_by_admin, reassigned, dispute.

- **Payments**  
  - Stripe (PaymentIntents for customers, Connect Transfers for contractors).  
  - Platform keeps commission; contractor pays Hero outside system.

- **Notifications**  
  - Push (expo-notifications) with SMS/email fallback.  
  - Key events: booking confirmed, Hero en-route, arrived, completed, receipt.

- **Compliance & Privacy (Canada)**  
  - PIPEDA consent.  
  - Background location disclosure.  
  - Audit logs for Admin actions.  
  - WorkSafeBC/WCB numbers stored for contractors.

- **Data Model**  
  - Shared schema includes Contractors, Heros, Users, Bookings, BookingEvents, GPSPings, Payments, Payouts, Reviews, Promos, CSNotes.

---

## Parallel Development Notes

- Each project can be developed independently but **must respect shared API contracts**.  
- The **backend services** (API, DB, notifications, payments) are a **single shared system**.  
- **Common libraries**: auth, booking lifecycle state machine, Stripe integration, notifications.  
- **Integration testing**: end-to-end flows will involve both Customer and Provider apps plus Admin actions.

---

## Individual QRDs

- [HomeHeros (Customer App)](homeheros_customer.md)  
- [HomeHeros Go (Provider App)](homeheros_provider.md)  
- [Admin Portal / CRM](homeheros_admin.md)
