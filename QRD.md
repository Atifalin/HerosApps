HomeHeros — Full QRD (Customer, Provider, Admin)

Model: Contractor-supplied “Heros” that customers can choose, even for one-off jobs. HomeHeros signs B2B contracts with Contractors; Contractors onboard and manage their Heros (service providers).

0) Product North Star

Promise: “Pick your Hero.” Customers in BC Interior can browse real Heros (profiles, pricing, ratings) from vetted Contractors, then book and track them in real time—with secure payments and proactive support.

Differentiator: Customer choice of individual Hero (not blind auto-match), while maintaining B2B control via Contractor agreements (pricing floors, SLAs, coverage).

A) HomeHeros (Customer App)
A1. Scope & Platforms

Platforms: iOS 15+, Android 8+, built with Expo/React Native (EAS builds + OTA for JS/asset changes).

Regions (MVP): Kamloops, Kelowna, Vernon, Penticton, West Kelowna, Salmon Arm (America/Vancouver TZ).

Out of scope (MVP): complex bid/quote projects, materials procurement, in-app translations, subscriptions.

A2. MVP User Stories

Sign up/login with email/phone + 2FA; consent to privacy & background location use when tracking.

Select city → browse categories (Cleaning, Handyman, Moving, Auto Detailing, Personal Care, Pest, Appliances…).

See Heros list for a category: photo, rating, price (fixed/hourly), badges (insured, licensed), next slot.

Tap a Hero → profile (bio, portfolio photos, contractor brand, insurance badge), available times.

Create a booking (address → timeslot → notes/photos → price preview) and authorize payment.

Receive push updates: confirmed, Hero acceptance, en-route, arrived, completed; map tracking.

Rate/tip; get receipt/invoice (email/PDF).

Manage bookings: reschedule/cancel within policy; contact support.

A3. MVP Onboarding (Customer)

Auth: email or phone + OTP/2FA; optional Apple/Google sign-in.

Profile: name, phone, email; optional default address.

Consent: PIPEDA-aligned privacy, location permission (When Using App; later “Always” for tracking day).

Payment: add card via Stripe PaymentSheet; store payment method (SetupIntent).

A4. Key Features (MVP → V1)

Discovery & Filters: category, price, rating, earliest availability, contractor brand (MVP).

Maps & Tracking: live Hero ETA & progress (MVP).

Payments: Card + Apple Pay/Google Pay; holds, capture on completion; refunds (MVP).

Receipts & Taxes: receipts w/ GST display; PST rules by category/city V1.

Promos: basic one-time promo codes V1.

Support: “Call/Text support”, help center (MVP); in-app CS chat V1.

A5. Policies (Configurable)

Cancellation: free until en-route; else fee (default 20%).

No-show: if Hero >15 min late, customer may cancel → full refund suggested; CS override allowed.

Disputes: photo evidence + CS adjudication.

A6. Non-Functional Targets

P95 app cold start < 2.5s; crash-free sessions > 99.7%; API P95 create-booking < 400ms; 99.5% API uptime.

B) HomeHeros Go (Provider App)

Audience: Individual Heros employed/contracted by Contractors (our B2B partners).

B1. Scope & Platforms

Expo/React Native with background location + foreground service (Android) requirements.

B2. MVP User Stories

Hero onboarding: invited or added by Contractor; verify email/phone; upload ID, selfie (match), certifications; accept policies/WCB attestation.

Availability: set weekly schedule, blackout dates, service areas (city polygons).

Job offers: receive offers (customer-selected or system fallback); accept/decline within SLA.

Navigation & Status: deep-link to Apple/Google Maps; set statuses: en-route, arrived, in-progress, complete.

Media & Proof: before/after photos; optional customer signature.

Earnings view: per job totals, tips, adjustments (informational; payouts go to Contractor).

Ratings/Feedback: view recent ratings and CS notes (limited).

B3. MVP Onboarding (Provider)

Identity & Docs: government ID photo, selfie liveness, certifications; insurance & WCB recorded at Contractor level, surfaced on Hero.

Association: Hero linked to one Contractor (MVP); multi-contractor later.

Training: short policy quiz; must pass to go live.

Device permissions: background location (iOS background modes; Android foreground service notification).

B4. SLAs & Compliance

Acceptance SLA: e.g., 15 minutes; repeated misses lower sort rank.

On-time arrival: KPI tracked; late arrivals surface to CS.

Privacy: GPS pings only on active jobs; retention policy (e.g., 90 days).

C) Admin Portal / ERD / CRM
C1. Roles

Admin: global config, pricing floors, city enablement, categories, promos, refunds.

Ops/CS: live ops board, booking edits/reassignments, disputes, notes, customer/provider comms.

Finance: payouts, adjustments, reports, tax exports.

Contractor Manager (external): manage their Heros, availability, documents, see their bookings & ratings.

Auditor (read-only).

C2. Admin/CS Features (MVP)

Live Ops Board: city filter; bookings by state; map of active Heros; SLA alerts (acceptance/arrival).

Booking Detail: timeline (events), GPS trace, media, payment/tips/refunds, reassign actions.

User 360: customer & Hero profiles, KYC docs, history, flags, CS notes.

Contractors: onboard/edit contractors; set categories, coverage, pricing floors, commissions, SLAs.

Payments: view payments, issue refunds/partial refunds, adjustments; linkouts to Stripe dashboards.

Disputes: intake → evaluation → resolution; evidence management; audit log.

Reports: daily/weekly revenue, cancellation rate, acceptance rate, on-time arrival, NPS, city/category split.

Promos: create/cap codes (V1).

CRM Lite: search, tag users, add internal notes, ticketing for escalations.

C3. Contractor Portal (restricted)

Manage team of Heros: invite, documents, availability, coverage.

View their bookings, performance, ratings, disputes outcomes.

Download statements; view Connect payouts (informational).

D) Booking & Matching — Algorithm (Choice-first, Contractor-aware)

Principle: Customer can pick a specific Hero; system respects Contractor contracts (pricing floors, SLAs), and provides graceful fallback.

States

requested → awaiting_hero_accept → enroute → arrived → in_progress → completed → rated
Side paths: declined | expired | cancelled_by_customer | cancelled_by_admin | reassigned | dispute | refund_partial | refund_full.

Pseudocode (core)
on CustomerCreatesBooking(hero_id?):
  eligible_heros = Heros.activeIn(city, category)
                      .where(contractor.status == 'active' && hero.available(slot))
                      .respect(pricing_floors)

  if hero_id provided:
     target = eligible_heros.find(hero_id)
     if !target -> suggestTop3(eligible_heros); return
     sendOffer(target)
  else:
     // system suggestion when customer skips choice
     top = rank(eligible_heros by rating, ETA, acceptance_rate, rotation_bias)
     sendOffer(top[0..2])  // sequential or short broadcast

on OfferTimeoutOrDecline(booking):
  // Fallback preference: same contractor, then open pool
  next = nextBestHero(same_contractor_first=true)
  if next: sendOffer(next)
  else: alertCSandCustomer("No hero available; reschedule/refund")

on ProviderAccepts(booking):
  lockSlot(hero, slot)
  notifyCustomer("Hero accepted")
  status = enroute when hero starts; begin GPS pings


Ranking Inputs: rating (weighted recent), distance/ETA, acceptance SLA, on-time KPI, rotation to avoid hogging, contractor SLA bonus.

E) Data Model / ERD (MVP)

Key relationships (→ one-to-many):
Contractor → Heros → Bookings → BookingEvents/GpsPings/Media/Payments

Contractors(id, name, status, contract_terms, gst_number, insurance_doc_url,
            city_coverage[], categories[], commission_pct, pricing_floors_json, sla_json,
            stripe_connect_id, created_at, updated_at)

Heros(id, contractor_id→Contractors.id, user_id→Users.id, name, alias, photo_url,
      skills[], categories[], rating_avg, rating_count, bio, badges[],
      status, verification_status, availability_json, docs_json,
      created_at, updated_at)

Users(id, role[customer|hero|admin|cs|finance|contractor_manager], name, email, phone,
     password_hash?, status, created_at)

Addresses(id, user_id, label, line1, line2, city, province, postal_code, lat, lng)

Services(id, category, title, unit['fixed'|'hourly'], base_price_cents, city, active)

Bookings(id, customer_id→Users.id, contractor_id→Contractors.id, hero_id→Heros.id,
         service_id→Services.id, address_id→Addresses.id,
         scheduled_at, duration_min, status, price_cents, currency,
         tip_cents, notes, created_at, updated_at)

BookingEvents(id, booking_id, type, meta_json, created_at)

GpsPings(id, booking_id, hero_id, lat, lng, speed, ts)

Payments(id, booking_id, stripe_pi, amount_cents, currency, status,
         captured_at, refunded_cents, refund_reason)

Payouts(id, contractor_id, stripe_transfer_id, amount_cents, status, period_start, period_end)

Reviews(id, booking_id, rater_user_id, ratee_type['hero'|'contractor'], ratee_id,
        rating, comment, created_at)

Promos(id, code, type['amount'|'percent'], value, city, start_at, end_at, max_uses, used)

CSNotes(id, subject_type['booking'|'user'|'hero'|'contractor'], subject_id,
        author_user_id, note, created_at)

F) APIs (REST sketch)
Customer

POST /auth/signup POST /auth/login POST /auth/otp/verify

GET /cities GET /categories

GET /heros?city=&category=&sort=&contractor_id=

GET /heros/:id

POST /bookings (body: hero_id? service_id, address_id, scheduled_at, notes, payment_method_id/pmt_sheet)

GET /bookings/:id POST /bookings/:id/cancel POST /bookings/:id/reschedule

POST /payments/intent POST /payments/refund

POST /reviews

Provider (Hero)

POST /hero/onboard (docs upload, selfie, checks)

GET /jobs/queue POST /jobs/:id/accept POST /jobs/:id/decline

POST /jobs/:id/status (enroute/arrived/in_progress/complete)

POST /jobs/:id/ping (GPS)

GET /earnings

Admin / Contractor Manager

POST /admin/contractors PATCH /admin/contractors/:id

POST /admin/heros PATCH /admin/heros/:id

GET /admin/bookings?state=&city= POST /admin/bookings/:id/reassign

POST /admin/refunds

GET /admin/reports/revenue?from=&to= (etc.)

Webhooks

/webhooks/stripe (payment/payout events)

/webhooks/notifications (delivery receipts, optional)

G) Payments & Money Flow

Customer → Stripe PaymentIntent (HomeHeros Platform).

On completion, capture and compute platform commission + contractor share.

Stripe Connect (Transfers) to Contractor (daily/weekly batch).

Contractor pays Heros off-platform (informational in our system).

Refunds: partial/full per CS resolution; tips refundable per policy.

Taxes: show GST line; PST logic by service/city in V1; export tax reports for Finance.

H) Notifications

Push (expo-notifications): booking created, hero accepted, 10/5-min ETA, arrived, completed, receipt sent.

Local notifications for in-progress reminders.

Failover via SMS/email if push undelivered.

Quiet hours per city; urgent overrides.

I) Security, Privacy, Compliance (Canada)

PIPEDA: consent screens, privacy policy, data export/delete (V1).

Background Location Disclosure: clear “why & when”; Android foreground service.

Retention: GPS pings 90 days (configurable).

PII at rest encrypted; TLS in transit; secrets rotation quarterly.

Audit logs for all CS/Admin actions.

WorkSafeBC/WCB numbers & insurance docs recorded for Contractors.

J) Observability & Analytics

Crash/Perf: Sentry.

Product analytics: PostHog/Amplitude events (examples):

city_selected, hero_viewed, booking_created, offer_accepted, eta_updated, job_completed, refund_issued, nps_submitted.

KPIs: conversion %, acceptance SLA, on-time arrival, cancellation/no-show rates, NPS, revenue by city/category, contractor performance league.

K) CI/CD & Environments

Mobile (Expo):

Branches: feature/* → PR checks; develop → Dev (OTA allowed); main → Staging (TestFlight & Play Internal); Production promotion by tag.

EAS Build/Submit; OTA for JS/asset-only changes.

Backend: Node/Go/Python on Fly/Render/Lightsail; blue-green deploy; DB migrations gated; Redis for queues.

Admin Web: Next/Vite on Vercel (preview→staging→prod).

Secrets: GitHub Encrypted Secrets; Stripe/APNs/FCM; Apple/Google keys.

Tests in CI: lint + unit on PR; integration on develop; smoke E2E (Detox) on main.

L) Testing Plan (MVP)

Unit: pricing calc, eligibility filters, ranking/rotation, cancellation fees.

Integration: booking lifecycle incl. accept/decline timeouts; Stripe sandbox (auth→capture→refund); webhooks; GPS processing.

E2E (Detox): Customer: discover→pick Hero→pay→track→rate; Provider: accept→status updates→complete.

Load: 200 concurrent active bookings; GPS pings every 30s; ensure queue latency < 2s P95.

M) Acceptance Criteria (sample)

Customer picks Hero & books

Given valid city/category, when I open a Hero profile and select a free slot, then price preview shows with GST line; after PaymentSheet success, booking is requested, push “Booking created” sent, and the selected Hero receives an offer.

Hero accept SLA

If the Hero does not accept within 15 minutes, the system re-offers: first to same-contractor eligible Heros (rotation), then to open pool top candidates; customer receives status push at each hop.

Arrival rule

If arrived is >15 minutes after window start, and the customer cancels, then system proposes full refund automatically and flags for CS review.

Tracking

When a job is enroute or in_progress, GPS pings ≤30s are stored; customer map updates ≤5s after server receipt.

N) Roadmap

MVP (4–6 weeks build focus)

Customer app: choice-based booking, tracking, payments, receipts, ratings.

Provider app: onboarding, job offers, status updates, GPS, media.

Admin/CS: live ops board, bookings detail, refunds, disputes, contractors & Heros management, basic reports.

Backend: ranking/rotation, fallback flows, Stripe Connect, webhooks, queues, S3 storage.

V1 Enhancements

Promo codes, PST rules, in-app CS chat (masked), automated background checks, surge/multipliers, contractor analytics/heatmaps, self-serve data export/delete.

Later

Subscriptions, multi-contractor Hero association, quotes/bids, inventory/materials, marketplace bundles.

O) Implementation Checklist

 Apple/Google Maps keys + Distance Matrix

 APNs/FCM push credentials; device token registry

 Stripe platform + Connect; Apple Pay Merchant ID + Google Pay profile

 Legal: Terms, Privacy (background location), Contractor agreements metadata

 City geofences & category catalogs seeded

 Sentry + analytics schema events defined

 Admin roles & RBAC tested; audit trails enabled

If you want, I can turn this into:

docs/qrd.md with this structure,

an ASCII ERD diagram file,

and starter repo pieces: eas.json, GitHub Actions, backend folder scaffold (routes, DB schema, worker), and an Admin Web Next.js layout with the Live Ops Board stub.