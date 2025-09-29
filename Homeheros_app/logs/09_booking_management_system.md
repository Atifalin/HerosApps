# HomeHeros Booking Management System

## 📌 Overview
The booking management system coordinates customer requests, hero availability, pricing, and payment workflows across all HomeHeros services. It combines a **service-specific configuration layer** (derived from `Service_details.md`) with a **shared booking pipeline** engineered to satisfy QRD requirements (`Docs/QRD.md`).

## 🧱 Architectural Layers
- **Service Configuration (`serviceConfig`)**
  - Stores pricing tiers, call-out fees, add-ons, duration defaults, buffer times, required hero tags.
  - Enables the shared engine to respond differently per service while keeping implementation centralized.
- **Shared Booking Pipeline**
  1. Normalize request (location, subcategory, schedule, add-ons).
  2. Check hero availability and service coverage.
  3. Calculate pricing (base + location adjustments + add-ons).
  4. Match heroes and score candidates.
  5. Confirm booking, reserve payment, notify participants.
  6. Track lifecycle status changes (`requested → confirmed → en_route → in_progress → completed`).
- **Data Persistence (Supabase)**
  - Tables: `services`, `service_variants`, `heroes`, `hero_skills`, `hero_availability`, `bookings`, `booking_items`, `booking_status_history`, `payments`, `promos`.
  - SQL migrations live in `supabase/migrations/` (e.g., `20250929_add_server_timestamp_function.sql`).

## 🔧 Request Normalization
- Validate city against supported list in `LocationContext.tsx`.
- Resolve service + subcategory from `serviceConfig` and `ServiceDetailScreen.tsx` selection.
- Collect schedule window, add-ons, special instructions.
- Reject requests outside service coverage or required lead time.

## 📆 Availability Engine
- Query hero calendar blocks filtered by:
  - City coverage and service skills.
  - Buffer rules (travel/setup, cool-down) per service.
  - Hero status (active, verified) from QRD policies.
- Output ranked set of eligible heroes or trigger manual assignment queue.

## 💰 Pricing Engine
- Start with service base price (flat fee, hourly, tier ladder).
- Apply call-out fees (e.g., Handymen $65, Auto Repair $150).
- Layer add-ons (fridge cleaning +$50, garage +$75, etc.).
- Respect location adjustments (“Prices may vary based on location”).
- Produce line-item breakdown stored in `booking_items` for transparency.

## 🙋‍♂️ Hero Matching
- Score heroes using configurable weights:
  - Rating / NPS (QRD KPI).
  - Proximity to service address.
  - Recent performance / SLA compliance.
- Offer top candidates for customer confirmation or auto-assign (configurable).

## 💳 Payments & Promos
- On confirmation, run Stripe SetupIntent (per QRD) and authorize estimated total.
- Adjust charges at completion (tips, add-ons consumed, refunds).
- Apply promo codes from `PromosScreen.tsx` with validation rules (usage limits, city eligibility, expiration).

## 🔁 Booking Lifecycle
1. `draft` – user configuring request.
2. `requested` – awaiting hero assignment.
3. `confirmed` – hero + schedule locked.
4. `en_route` – hero travelling.
5. `in_progress` – service underway.
6. `completed` – job done, finalize payment.
7. `cancelled` / `no_show` – follow QRD policies for fees/refunds.

Every transition writes to `booking_status_history` and triggers notifications (push, email, SMS) per role.

## 🛎️ Support & Operations Hooks
- Customer support can reassign heroes, adjust pricing, apply credits.
- Ops dashboards consume booking + hero telemetry for SLA monitoring.
- Audit trails maintained for disputes (photos, notes, payment adjustments).

## 🚀 Roadmap
- Implement booking flow UI (launch from `ServiceDetailScreen.tsx` "Book Now" buttons).
- Build Supabase stored procedures for availability + pricing calculations.
- Integrate Stripe for payment holds, receipts, and refunds.
- Add calendar sync and route optimization for heroes.
- Extend analytics for conversion, cancellation reasons, hero utilization.

This document provides the reference foundation for implementing a robust, configurable booking system that scales across HomeHeros service categories while honoring business rules and QRD constraints.
