import SwiftUI

@main
struct Testing_RoboKitApp: App {
    @Environment(\.openWindow) private var openWindow
    
    var body: some Scene {
        ImmersiveSpace() {
            ImmersiveView()
                .onAppear{
                    openWindow(id: "WindowGroup")
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        
        WindowGroup(id: "WindowGroup") {
            SocketView()
        }
    }
}
