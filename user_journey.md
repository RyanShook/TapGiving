# User Journey: tap.giving

## The "Magic" Moment
The goal is to make donating as frictionless as buying a coffee.

### 1. Discovery & Trigger
- **Context**: A user is at a charity event, a museum, or a church.
- **Action**: They see a sign: "Tap here to donate to Woodlands Church."
- **Interaction**: They hold the top of their iPhone near the NFC sticker.
- **System**: iOS detects the NFC tag containing the URL `https://appclip.tap.giving/WoodlandsChurch?f=1&r=0`.

> **Backend Note**: No backend call yet. This is purely iOS reading the NDEF data from the NFC tag.

### 2. The App Clip Card (System UI)
- **Visual**: A system sheet slides up from the bottom (the "App Clip Card").
- **Content**:
    - **Title**: "Donate to Woodlands Church" (Derived from URL path).
    - **Image**: A high-quality photo of the organization.
    - **Action Button**: "Open".
- **Decision**: The user taps "Open".

> **Backend Note**: iOS checks the `apple-app-site-association` file hosted at `https://appclip.tap.giving` to verify the App Clip is valid and trusted.

### 3. The App Clip Experience (Our Code)
- **Load**: The App Clip launches.
    - Parses Organization Name from path: `WoodlandsChurch`.
    - Parses Fund ID (`f`): `1`.
    - Parses Recurring default (`r`): `0` (No).
- **Screen**: "Donation View"
    - **Header**: "Donate to Woodlands Church"
    - **Amount Field**: $50 (Pre-filled, editable).
    - **Recurring Toggle**: "Make this a recurring monthly donation?" (Pre-selected: No).
- **Action**: User taps "Donate via Apple Pay".

> **Backend Note**: The App Clip calls `OrganizationService.fetch("WoodlandsChurch")`. Our backend looks up the `OrgID` and returns the `StripeAccountID` (e.g., `acct_123`) and the Logo URL.

### 4. Payment (Apple Pay)
- **Sheet**: The standard Apple Pay sheet slides up.
- **Line Item**: Shows "Subscription" if recurring is selected.
- **Contact Info**: Sheet requests **Name**, **Email**, and **Phone Number** (Required).
- **Confirmation**: User double-clicks the side button and glances at FaceID.
- **Processing**:
    - **One-Time**: Stripe processes charge immediately.
    - **Recurring**: Backend creates a Stripe Subscription.
- **Result**: "Ding!" Success checkmark.

> **Backend Note**: 
> 1. **Tokenization**: iOS sends the encrypted payment data to Stripe to get a `Token`.
> 2. **Charge**: Our backend receives the `Token` + `StripeAccountID`.
> 3. **Connect**: We use the Stripe API to create a Charge (or Subscription) *on behalf of* the Connected Account (`acct_123`), deducting our 1% application fee.
> 4. **Customer**: We create a Stripe Customer record with the Name/Email/Phone for future retention.

### 5. Post-Donation & Retention
- **Success Screen**: "Thank you for your generosity! Manage your giving profile using the tap.giving app."
- **Action**: Button: "Download tap.giving".
- **Exit**: User puts phone away.

## Key Technical Requirements derived from Journey
1.  **URL Parsing**: Must handle path (`/OrgName`) and short query params (`f`, `r`).
2.  **UI Specifics**: Editable amount field defaulting to 50. Recurring toggle defaults to value in URL.
3.  **Fast Load**: The App Clip binary must be < 15MB (using StripeApplePay).
