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
        let pathComponents = url.pathComponents
        // pathComponents might be ["/", "WoodlandsChurch"]
        if pathComponents.count > 1 {
            let orgID = pathComponents[1]
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
