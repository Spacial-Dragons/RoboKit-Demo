import SwiftUI

@main
struct RoboKitDemo: App {
    @Environment(\.openWindow) private var openWindow

    var body: some Scene {
        // Immersive space for rendering 3D content (example: Tracked Entities, Input Sphere)
        ImmersiveSpace {
            ImmersiveView()
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
    }
}
