import SwiftUI
import RoboKit

@main
struct RoboKitDemo: App {

    private let windowGroupID: String = "WindowGroup"

    private var imageTracker: RoboKit.ImageTracker
    private var inputSphereManager: InputSphereManager
    private var formManager: FormManager
    private var client: TCPClient

    @Environment(\.openWindow) private var openWindow

    init() {
        // 1. ImageTracker
        do {
            imageTracker = try RoboKit.ImageTracker(
                arResourceGroupName: "AR Resources",
                images: [
                    .init(imageName: "Tracking-Image-1", rootOffset: .init(x: -0.11, y: 0, z: 0.169)),
                    .init(imageName: "Tracking-Image-2", rootOffset: .init(x: -0.11, y: 0, z: -0.169)),
                    .init(imageName: "Tracking-Image-3", rootOffset: .init(x: 0.11, y: 0, z: -0.169))
                ]
            )
        } catch {
            fatalError("Failed to initialize image tracker: \(error)")
        }

        // 2. InputSphereManager
        inputSphereManager = InputSphereManager()

        // 3. FormManager
        formManager = FormManager()

        // 4. TCPClient
        client = TCPClient(host: "localhost", port: 12345)
    }

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
        .environment(imageTracker)
    }
}
