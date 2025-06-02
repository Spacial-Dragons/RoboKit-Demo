import SwiftUI
import RoboKit

@main
struct RoboKitDemo: App {
    private var inputSphereManager = InputSphereManager()
    private var formManager: FormManager = FormManager()
    private var client: TCPClient = TCPClient(host: "localhost", port: 12345)
    private let windowGroupID: String = "WindowGroup"

    @Environment(\.openWindow) private var openWindow

    var body: some Scene {

        Group {
            // Immersive space for rendering 3D content (example: Tracked Entities, Input Sphere)
            ImmersiveSpace {
                ImmersiveView()
                    .onAppear {
                        openWindow(id: windowGroupID)
                    }
            }
            .immersionStyle(selection: .constant(.mixed), in: .mixed)

            WindowGroup(id: windowGroupID) {
                ControlPanelView()
            }
            .windowStyle(.plain)
            .windowResizability(.contentSize)
        }
        .environment(inputSphereManager)
        .environment(formManager)
        .environment(client)

    }
}
