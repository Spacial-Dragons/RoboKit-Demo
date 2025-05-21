import SwiftUI
import RoboKit

@main
struct Testing_RoboKitApp: App {
    private var inputSphereManager = InputSphereManager()
    private var formManager: FormManager = FormManager()
    @Environment(\.openWindow) private var openWindow
    
    var body: some Scene {
        ImmersiveSpace() {
            ImmersiveView()
                .onAppear{
                    openWindow(id: "WindowGroup")
                }
                .environment(inputSphereManager)
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        
        WindowGroup(id: "WindowGroup") {
            SocketView()
                .environment(inputSphereManager)
                .environment(formManager)
        }
    }
}
