# User Journey: tap.giving

## The "Magic" Moment
The goal is to make donating as frictionless as buying a coffee.

### 1. Discovery & Trigger
- **Context**: A user is at a charity event, a museum, or a church.
- **Action**: They see a sign: "Tap here to donate to Woodlands Church."
- **Interaction**: They hold the top of their iPhone near the NFC sticker.
- **System**: iOS detects the NFC tag containing the URL `https://appclip.tap.giving/WoodlandsChurch?f=1&r=0`.

### 2. The App Clip Card (System UI)
- **Visual**: A system sheet slides up from the bottom (the "App Clip Card").
- **Content**:
    - **Title**: "Donate to Woodlands Church" (Derived from URL path).
    - **Image**: A high-quality photo of the organization.
    - **Action Button**: "Open".
- **Decision**: The user taps "Open".

### 3. The App Clip Experience (Our Code)
- **Load**: The App Clip launches.
    - Parses Organization Name from path: `WoodlandsChurch`.
    - Parses Fund ID (`f`): `1`.
    - Parses Recurring default (`r`): `0` (No).
- **Screen**: "Donation View"
    - **Header**: "Donate to Woodlands Church"
    - **Amount Field**: $50 (Pre-filled, editable).
    - **Recurring Toggle**: "Make this a recurring monthly donation?" (Pre-selected: No).
- **Action**: User taps "Give Now via Apple Pay".

### 4. Payment (Apple Pay)
- **Sheet**: The standard Apple Pay sheet slides up.
- **Line Item**: Shows "Subscription" if recurring is selected.
- **Contact Info**: Sheet requests **Name**, **Email**, and **Phone Number** (Required).
- **Confirmation**: User double-clicks the side button and glances at FaceID.
- **Processing**:
    - **One-Time**: Stripe processes charge immediately.
    - **Recurring**: Backend creates a Stripe Subscription.
- **Result**: "Ding!" Success checkmark.

### 5. Post-Donation & Retention
- **Success Screen**: "Thank you for your generosity! Manage your giving profile using the tap.giving app."
- **Action**: Button: "Download tap.giving".
- **Exit**: User puts phone away.

## Key Technical Requirements derived from Journey
1.  **URL Parsing**: Must handle path (`/OrgName`) and short query params (`f`, `r`).
2.  **UI Specifics**: Editable amount field defaulting to 50. Recurring toggle defaults to value in URL.
3.  **Fast Load**: The App Clip binary must be < 15MB (using StripeApplePay).
