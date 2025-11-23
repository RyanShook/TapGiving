import SwiftUI

@main
struct TapGivingClipApp: App {
    @StateObject private var orgService = OrganizationService()
    @State private var initialFundID: String?
    @State private var initialRecurring: Bool?
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                DonationView(
                    orgService: orgService,
                    initialFundID: initialFundID,
                    initialRecurring: initialRecurring
                )
            }
            .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { userActivity in
                guard let incomingURL = userActivity.webpageURL else { return }
                handleInvocation(url: incomingURL)
            }
        }
    }
    
    private func handleInvocation(url: URL) {
        // URL Format: https://appclip.tap.giving/[OrgName]?f=[id]&r=[0/1]
        
        // 1. Parse OrgName from Path
        // URL: https://appclip.tap.giving/WoodlandsChurch
        // pathComponents: ["/", "WoodlandsChurch"]
        
        // We iterate to find the first non-slash component that isn't "appclip.tap.giving" (if it appears in path)
        // For a standard https URL, pathComponents usually starts with "/"
        
        if let orgID = pathComponents.last, orgID != "/" {
             print("📍 Detected Org ID: \(orgID)")
             orgService.fetchOrganization(id: orgID)
        }
        
        // 2. Parse Query Parameters
        if let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
           let queryItems = components.queryItems {
            
            // Parse 'f' (Fund ID)
            if let f = queryItems.first(where: { $0.name == "f" })?.value {
                self.initialFundID = f
            }
            
            // Parse 'r' (Recurring)
            if let r = queryItems.first(where: { $0.name == "r" })?.value {
                self.initialRecurring = (r == "1")
            }
        }
    }
}
