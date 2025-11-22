# Task: TapGiving App Clip

## Planning
- [x] Research App Clip limitations (Binary size < 15MB) <!-- id: 0 -->
- [x] Define User Journey (NFC -> App Clip -> Apple Pay) <!-- id: 1 -->
- [x] Create `implementation_plan.md` <!-- id: 2 -->

## Implementation
### iOS App Clip
- [x] Scaffold Xcode Project Structure (Main App + App Clip Target) <!-- id: 3 -->
- [ ] Add StripeApplePay SDK via Swift Package Manager <!-- id: 10 -->
- [x] Implement `DonationView` with specific UI (Header, $50 default, Toggle) <!-- id: 4 -->
- [x] Integrate Apple Pay (PassKit) with StripeApplePay <!-- id: 5 -->
- [x] Implement URL Parsing (`/OrgName?f=&r=`) <!-- id: 11 -->
- [x] Configure `Info.plist` and Entitlements for App Clip <!-- id: 6 -->
- [x] Create Associated Domains entitlement file <!-- id: 7 -->

### Platform Backend (Mocked for MVP)
- [x] Create `OrganizationService` (Mock Data for "WoodlandsChurch") <!-- id: 12 -->
- [ ] Create `SubscriptionService` (Mock Logic for Recurring) <!-- id: 13 -->

## Verification
- [x] Verify project structure (files exist) <!-- id: 8 -->
- [x] Create walkthrough for user to open in Xcode and test <!-- id: 9 -->
