import SwiftUI
import RoboKit

@main
struct Testing_RoboKitApp: App {
    private var inputSphereManager = InputSphereManager()
    private var formManager: FormManager = FormManager()
    var client: TCPClient = TCPClient(host: "localhost", port: 12345)
    @State var socketCollapsed: Bool = true
    @Environment(\.openWindow) private var openWindow

    var body: some Scene {

        Group {
            ImmersiveSpace {
                ImmersiveView()
                    .onAppear {
                        openWindow(id: "WindowGroup")
                    }
            }
            .immersionStyle(selection: .constant(.mixed), in: .mixed)

            WindowGroup(id: "WindowGroup") {
                SocketView(socketCollapsed: $socketCollapsed)
            }
            .windowResizability(.contentSize)
        }
        .environment(inputSphereManager)
        .environment(formManager)
        .environment(client)

    }
}
