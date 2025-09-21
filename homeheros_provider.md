# HomeHeros Go (Provider App) — QRD

## Scope & Platforms
- iOS/Android (Expo/React Native).  
- For individual Heros, linked to Contractors.

## MVP User Stories
1. Onboarding: invited by Contractor, upload ID, selfie, certifications, accept policies.  
2. Set availability and service areas.  
3. Receive job offers, accept/decline within SLA.  
4. Navigation via Apple/Google Maps deep-link.  
5. Update status (enroute, arrived, in-progress, complete).  
6. Capture before/after photos, signatures.  
7. Earnings dashboard (informational).

## Onboarding (MVP)
- Verify ID, certifications.  
- Link to Contractor.  
- Device permissions: background location, camera.  
- Policy quiz.

## SLAs
- Acceptance SLA: e.g., 15 minutes.  
- On-time arrival KPI tracked.  
- GPS pings required during active jobs.

---

**Shared System Interactions**
- Bookings created in Customer app flow to Provider app.  
- GPS & status updates feed customer tracking and Admin live ops.  
- Payouts tracked via Contractor → Stripe Connect.
