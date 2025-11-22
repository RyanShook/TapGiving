# TapGiving App Clip - Setup Guide

I have scaffolded the source code for your App Clip. Since I cannot generate the `.xcodeproj` file directly, please follow these steps to assemble the project in Xcode.

## 1. Create the Project
1.  Open **Xcode**.
2.  Select **Create a new Xcode project**.
3.  Choose **App** (iOS).
4.  Product Name: `TapGiving`.
5.  Organization Identifier: `com.tapgiving`.
6.  Interface: **SwiftUI**.
7.  Save it in: `/Users/ryan/Dropbox/Projects/code/TapGiving` (Overwrite if asked, or merge).
    *   *Tip: If Xcode complains about existing files, just create it in a temp folder and move the `.xcodeproj` file here.*

## 2. Add the App Clip Target
1.  In Xcode, go to **File > New > Target**.
2.  Search for **App Clip**.
3.  Product Name: `TapGivingClip`.
4.  Finish.

## 3. Add Source Files
I have created the source code in the `TapGiving` folder. You need to link these files in Xcode.

### Shared Code (Drag this folder into Xcode)
-   `TapGiving/Shared`
    -   `Models.swift`
    -   `OrganizationService.swift`
    -   `PaymentManager.swift`
    -   `DonationView.swift`
-   **Target Membership**: Check **BOTH** `TapGiving` and `TapGivingClip` for all these files.

### App Clip Code
-   Replace the default `TapGivingClipApp.swift` with the one I created in `TapGiving/TapGivingClip/TapGivingClipApp.swift`.
-   Add `TapGiving/TapGivingClip/Info.plist` (if not already there).
-   Add `TapGiving/TapGivingClip/TapGivingClip.entitlements`.

## 4. Add Dependencies (Stripe)
1.  Select the Project in the navigator.
2.  Go to **Package Dependencies**.
3.  Click **+**.
4.  Search URL: `https://github.com/stripe/stripe-ios`.
5.  **Important**: When asked which libraries to add, select **StripeApplePay** (Lightweight SDK). Do **NOT** select the full `Stripe` library.
6.  Add it to the `TapGivingClip` target.

## 5. Run It
1.  Select the `TapGivingClip` scheme.
2.  Select a Simulator (e.g., iPhone 15).
3.  **Run** (Cmd+R).
4.  **Test Invocation**:
    -   In Xcode, go to **Product > Scheme > Edit Scheme**.
    -   Under **Run > Arguments**, check **Environment Variables**.
    -   You can simulate an invocation URL here: `_XCAppClipURL` = `https://appclip.tap.giving/WoodlandsChurch?f=1&r=0`.

## Next Steps
-   [ ] Add your **Stripe Publishable Key** in `PaymentManager.swift`.
-   [ ] Configure your **Apple Merchant ID** in `PaymentManager.swift` and in the "Signing & Capabilities" tab.
