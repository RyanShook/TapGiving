# Implementation Plan - TapGiving App Clip

## Goal Description
Create a native iOS experience where users can tap an NFC tag to open an App Clip and make a one-time or recurring donation. The app will use SwiftUI, Apple Pay, and Stripe.

## User Review Required
> [!IMPORTANT]
> **Apple Developer Account**: You will need a paid Apple Developer account to configure App Clip entitlements and Apple Pay Merchant IDs.
> **Physical Device**: NFC testing requires a real iPhone; it does not work in the Simulator.

## Proposed Changes

### Project Structure
We will create a standard Xcode project structure with a main app target and an App Clip target.

#### [NEW] [TapGivingApp.swift](file:///Users/ryan/Dropbox/Projects/code/TapGiving/TapGiving/TapGivingApp.swift)
- Main entry point for the full app.
- Checks for `NSUserActivity` to handle App Clip invocation upgrades.

#### [NEW] [TapGivingClipApp.swift](file:///Users/ryan/Dropbox/Projects/code/TapGiving/TapGivingClip/TapGivingClipApp.swift)
- Entry point for the App Clip.
- **Logic**: Handles invocation URL `https://appclip.tap.giving/[OrgName]?f=[id]&r=[0/1]`.
- Calls `OrganizationService` to fetch details for `OrgName`.
- Passes `Organization` object to `DonationView`.

#### [NEW] [OrganizationService.swift](file:///Users/ryan/Dropbox/Projects/code/TapGiving/Shared/OrganizationService.swift)
- **Purpose**: Fetches organization details (Name, Logo URL, Stripe Account ID) based on the identifier.
- **Implementation**: Initially a mock service returning hardcoded data for "WoodlandsChurch", but designed to call an API later.

#### [NEW] [DonationView.swift](file:///Users/ryan/Dropbox/Projects/code/TapGiving/Shared/DonationView.swift)
- Shared SwiftUI view for the donation interface.
- **UI Specs**:
    - **Header**: Displays Organization Logo (AsyncImage) and Name.
    - Amount Field: Editable, defaults to **$50**.
    - Recurring Toggle: "Make this a recurring monthly donation?" (Default set by URL param `r`).
    - Button: "Give Now via Apple Pay".
    - Success: "Thank you for your generosity! Manage your giving profile using the tap.giving app."

### Platform Backend (New)
- **Tech Stack**: Node.js / Firebase Functions (Mocked for now).
- **Responsibilities**:
    - **Onboarding**: Generate Stripe Connect Express login links for organizations.
    - **Directory**: Store `OrgID` -> `StripeAccountID` mapping.
    - **Subscriptions**: Create Stripe Subscriptions for recurring donations (safer to do on backend).

#### [MODIFY] [PaymentManager.swift](file:///Users/ryan/Dropbox/Projects/code/TapGiving/Shared/PaymentManager.swift)
- **Logic**:
    - **One-Time**: Uses `PKPaymentRequest` -> Stripe `PaymentIntent`.
    - **Recurring**: Uses `PKRecurringPaymentRequest` -> Stripe `Subscription`.
- **Configuration**:
    - Sets `requiredBillingContactFields = [.emailAddress, .phoneNumber, .name]`.
    - Uses `StripeApplePay` to tokenize.
- **Platform Logic**:
    - Passes `StripeAccountID` (of the church) as the `transfer_data[destination]` in the Stripe call.

#### [NEW] [OrganizationService.swift](file:///Users/ryan/Dropbox/Projects/code/TapGiving/Shared/OrganizationService.swift)
- **Purpose**: Fetches organization details (Name, Logo URL, **Stripe Account ID**) based on the identifier.
- **Implementation**: Mocked to return a test Connected Account ID for "WoodlandsChurch".

### Dependencies
- **Stripe iOS SDK**: We will use Swift Package Manager to add `StripeApplePay` (specifically this module to save space).

## Verification Plan

### Automated Tests
- We will write a simple unit test for `PaymentManager` to ensure it constructs valid payment requests.
- Command: `xcodebuild test -scheme TapGiving` (Note: Requires Xcode installed on host).

### Manual Verification
1.  **Preview**: I will generate SwiftUI Previews code so you can see the UI logic.
2.  **Build**: You will need to open the folder in Xcode and run the `TapGivingClip` scheme on your iPhone.
3.  **NFC Simulation**: In Xcode, you can simulate an App Clip invocation via `Product > Scheme > Edit Scheme > Arguments > Environment Variables` (`_XCAppClipURL`).
