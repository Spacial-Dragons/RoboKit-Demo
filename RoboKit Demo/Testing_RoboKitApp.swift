import SwiftUI
import RoboKit

@main
struct Testing_RoboKitApp: App {
    private var formManager: FormManager = FormManager()
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
                .environment(formManager)
        }
    }
}
