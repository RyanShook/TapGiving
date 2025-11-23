import Foundation
import PassKit
// import StripeApplePay // Uncomment when SDK is added

class PaymentManager: NSObject, ObservableObject {
    @Published var paymentStatus: PaymentStatus = .idle
    
    enum PaymentStatus {
        case idle
        case processing
        case success
        case failure(Error)
    }
    
    func startPayment(for org: Organization, config: DonationConfig) {
        paymentStatus = .processing
        
        // Configure Stripe
        // Note: Use your TEST key here for Simulator testing
        // STPAPIClient.shared.publishableKey = "pk_test_INSERT_YOUR_KEY_HERE"
        
        // Create Request
        // Note: Using Mock Merchant ID for Simulator
        let paymentRequest = StripeAPI.paymentRequest(withMerchantIdentifier: "merchant.com.tapgiving", country: "US", currency: "USD")
        
        if config.isRecurring {
            // Recurring Payment (Subscription)
            let recurringRequest = PKRecurringPaymentRequest()
            recurringRequest.paymentDescription = "Monthly Donation to \(org.name)"
            
            let regularBilling = PKRecurringPaymentSummaryItem(label: "Monthly Donation", amount: NSDecimalNumber(value: config.amount))
            regularBilling.intervalUnit = .month
            regularBilling.intervalCount = 1
            recurringRequest.regularBilling = regularBilling
            
            recurringRequest.managementURL = URL(string: "https://tap.giving/manage")!
            
            // Merge with Stripe request
            paymentRequest.paymentSummaryItems = [regularBilling]
            // Note: PKRecurringPaymentRequest is a subclass, so we might need to cast or configure differently depending on Stripe SDK version
            // For simplicity in this snippet, we assume standard PKPaymentRequest configuration for the token
        } else {
            // One-Time Payment
            paymentRequest.paymentSummaryItems = [
                PKPaymentSummaryItem(label: "Donation to \(org.name)", amount: NSDecimalNumber(value: config.amount))
            ]
        }

        // Required Contact Fields
        paymentRequest.requiredBillingContactFields = [.emailAddress, .phoneNumber, .name]
        
        // Present Apple Pay Sheet
        // let applePayContext = STPApplePayContext(paymentRequest: paymentRequest, delegate: self)
        // applePayContext?.presentApplePay()
        
        print("Presenting Apple Pay for \(org.name) - Amount: $\(config.amount) - Recurring: \(config.isRecurring)")
    }
    
    // Mock Backend Call to Create Subscription/Charge
    func processPayment(payment: PKPayment, for org: Organization) {
        // 1. Extract Contact Info
        let email = payment.billingContact?.emailAddress
        let phone = payment.billingContact?.phoneNumber?.stringValue
        let name = payment.billingContact?.name
        let fullName = PersonNameComponentsFormatter().string(from: name ?? PersonNameComponents())
        
        print("📦 Contact Info Captured:")
        print("   - Name: \(fullName)")
        print("   - Email: \(email ?? "N/A")")
        print("   - Phone: \(phone ?? "N/A")")
        
        // 2. Extract Token
        let token = payment.token
        
        // 3. Send to Backend
        // Backend would use Stripe Connect to transfer funds to org.stripeAccountID
        // AND create a Customer with this email/phone.
        
        // Calculate Application Fee (1%)
        // Note: This calculation happens on the Backend, but documenting the logic here.
        // let donationAmount = payment.paymentSummaryItems.last?.amount.decimalValue ?? 0
        // let appFee = donationAmount * 0.01 
        
        print("🚀 Processing Stripe Token for Connected Account: \(org.stripeAccountID)")
        print("💰 Platform Fee (1%): Will be deducted by Connect")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.paymentStatus = .success
        }
    }
}
