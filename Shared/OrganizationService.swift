import Foundation

class OrganizationService: ObservableObject {
    @Published var currentOrganization: Organization?
    @Published var isLoading = false
    
    // Mock Data for MVP
    private let mockOrgs: [String: Organization] = [
        "WoodlandsChurch": Organization(
            id: "WoodlandsChurch",
            name: "Woodlands Church",
            stripeAccountID: "acct_123456789", // Mock Connect ID
            logoURL: URL(string: "https://ui-avatars.com/api/?name=Woodlands+Church&background=0D8ABC&color=fff&size=200")
        )
    ]
    
    func fetchOrganization(id: String) {
        isLoading = true
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.currentOrganization = self.mockOrgs[id]
            self.isLoading = false
        }
    }
}
