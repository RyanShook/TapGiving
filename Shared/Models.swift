import Foundation

struct Organization: Identifiable, Codable {
    let id: String
    let name: String
    let stripeAccountID: String // Connect Account ID
    let logoURL: URL?
}

struct DonationConfig {
    var amount: Double = 50.0
    var isRecurring: Bool = false
    var fundID: String?
}
