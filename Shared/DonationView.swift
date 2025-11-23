import SwiftUI
import PassKit

struct DonationView: View {
    @StateObject private var paymentManager = PaymentManager()
    @ObservedObject var orgService: OrganizationService
    
    @State private var amount: Double = 50.0
    @State private var isRecurring: Bool = false
    
    // Initial values from URL
    var initialFundID: String?
    var initialRecurring: Bool?
    
    var body: some View {
        VStack(spacing: 20) {
            if let org = orgService.currentOrganization {
                // Header
                VStack {
                    if let logoURL = org.logoURL {
                        AsyncImage(url: logoURL) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            Color.gray.opacity(0.3)
                        }
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    }
                    
                    Text("Donate to \(org.name)")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .padding(.top, 40)
                
                // Amount Selection
                VStack(alignment: .leading) {
                    Text("Amount")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Text("$")
                        TextField("Amount", value: $amount, format: .number)
                            .keyboardType(.decimalPad)
                            .font(.largeTitle)
                    }
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                
                // Recurring Toggle
                Toggle(isOn: $isRecurring) {
                    VStack(alignment: .leading) {
                        Text("Make this monthly?")
                            .font(.headline)
                        Text("Support \(org.name) with a recurring gift.")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(12)
                .padding(.horizontal)
                
                Spacer()
                
                // Apple Pay Button
                Button(action: {
                    let config = DonationConfig(amount: amount, isRecurring: isRecurring, fundID: initialFundID)
                    paymentManager.startPayment(for: org, config: config)
                }) {
                    HStack {
                        Image(systemName: "applelogo")
                        Text("Donate")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                }
                .padding()
                
                if case .success = paymentManager.paymentStatus {
                    Text("Thank you for your generosity! Manage your giving profile using the tap.giving app.")
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.green)
                        .padding()
                }
                
            } else if orgService.isLoading {
                ProgressView()
            } else {
                Text("Organization not found.")
            }
        }
        .onAppear {
            if let initialRecurring = initialRecurring {
                self.isRecurring = initialRecurring
            }
        }
    }
}
