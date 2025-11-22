import SwiftUI

@main
struct TapGivingApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "heart.fill")
                .imageScale(.large)
                .foregroundColor(.red)
            Text("Welcome to TapGiving")
                .font(.title)
            Text("Manage your giving profile here.")
                .foregroundColor(.secondary)
        }
        .padding()
    }
}
