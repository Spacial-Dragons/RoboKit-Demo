import SwiftUI
import RoboKit

@main
struct DemoRoboKitApp: App {
    private var inputSphereManager = InputSphereManager()
    private var formManager: FormManager = FormManager()
    private var client: TCPClient = TCPClient(host: "localhost", port: 12345)
    private let windowGroupID: String = "WindowGroup"

    @Environment(\.openWindow) private var openWindow

    var body: some Scene {

        Group {
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
