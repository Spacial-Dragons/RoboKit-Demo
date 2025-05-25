import SwiftUI
import RoboKit

@main
struct Testing_RoboKitApp: App {
    private var inputSphereManager = InputSphereManager()
    private var formManager: FormManager = FormManager()
    @State var socketCollapsed: Bool = false
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
            VStack(alignment: .center) {
                SocketView(socketCollapsed: $socketCollapsed)
                    .environment(inputSphereManager)
                    .environment(formManager)
            }
        }
        .defaultSize(width: 390, height: 800)
        .windowResizability(.contentMinSize)
    }
}
