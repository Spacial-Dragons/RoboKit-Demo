import SwiftUI
import RoboKit

@main
struct RoboKitDemo: App {

    // Store ID of the window group
    private let windowGroupID: String = "WindowGroup"

    private var imageTracker: RoboKit.ImageTracker
    private var inputCubeManager: InputEntityManager
    private var formManager: FormManager

    @Environment(\.openWindow) private var openWindow

    init() {
        // Initialize ImageTracker, app crashes if not all images are present in the Assets catalog
        do {
            imageTracker = try RoboKit.ImageTracker(
                arResourceGroupName: "AR Resources",
                images: [
                    .init(imageName: "TrackingImage", rootOffset: .init(x: 0, y: 0, z: 0))
                ]
            )
        } catch {
            fatalError("Failed to initialize image tracker: \(error)")
        }

        // Initialize InputEntityManager
        inputCubeManager = InputEntityManager()

        // Initialize FormManager
        formManager = FormManager()
    }

    var body: some Scene {
        Group {
            // ImmersiveSpace contains Image Tracker and draws all of the 3D content
            ImmersiveSpace {
                ImmersiveView()
                    .onAppear {
                        openWindow(id: windowGroupID)
                    }
            }
            .immersionStyle(selection: .constant(.mixed), in: .mixed)

            // WindowGroup contains Control Panel, where you can customize different properties of the data
            WindowGroup(id: windowGroupID) {
                ControlPanelView()
            }
            .windowStyle(.plain)
            .windowResizability(.contentSize)
        }

        // Pass down environment variables
        .environment(inputCubeManager)
        .environment(formManager)
        .environment(imageTracker)
    }
}
