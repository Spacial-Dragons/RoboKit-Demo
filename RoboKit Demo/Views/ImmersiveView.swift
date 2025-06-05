import SwiftUI
import RealityKit
import RoboKit

// MARK: - ImmersiveView Demo
// This demo project illustrates how to use RoboKit's image tracker with SwiftUI and RealityKit.
// It sets up a parent entity and dynamically adds sphere entities representing tracked images in an immersive view.
struct ImmersiveView: View {

    // Parent entity that holds all child entities (tracked images, root point, Input Sphere).
    @State internal var parentEntity = Entity()

    // Placeholder for the computed root point entity.
    @State internal var rootPoint: Entity?

    // Array to store entities representing tracked images.
    @State internal var trackedSpheres: [Entity] = []

    // Image tracker with AR resource group and images with specified offsets.
    @Environment(ImageTracker.self) var imageTracker: ImageTracker

    // Input Sphere Manager used to control properties of the Input Sphere
    @Environment(InputSphereManager.self) var inputSphereManager: InputSphereManager

    var body: some View {
        // Initialize RealityView and add the parent entity to the scene.
        RealityView { content in
            content.add(parentEntity)
        }

        /// Updates the root entity and tracked image entities upon successful initialization.
        .onAppear {
            updateRootEntity(with: imageTracker.rootTransform)
            updateTrackingEntities(with: imageTracker.trackedImagesTransform)

            // Add Input Sphere entity to the parent entity above the root point if it doesn't exist yet.
            Task {
                await self.setupInputSphere()
            }
        }

        // Add Input Sphere Drag Gesture recognition and handling.
        .inputSphereDragGesture(
            parentEntity: parentEntity,
            rootPoint: rootPoint,
            inputSphereManager: inputSphereManager
        )

        .onChange(of: imageTracker.rootTransform) {
            // When the root transform changes, update the corresponding entity.
            updateRootEntity(with: imageTracker.rootTransform)

            // Add Input Sphere entity to the parent entity above the root point if it doesn't exist yet.
            Task {
                await self.setupInputSphere()
            }
        }

        .onChange(of: imageTracker.trackedImagesTransform) {
            // When the tracked images transform changes, update the sphere entities accordingly.
            updateTrackingEntities(with: imageTracker.trackedImagesTransform)
        }
    }

    // Add Input Sphere entity to the parent entity above the root point if it doesn't exist yet.
    func setupInputSphere() async {
        let brandedCube = await brandedCubeModelEntity()

        inputSphereManager.addInputSphere(
            parentEntity: parentEntity,
            rootPoint: rootPoint,
            modelEntity: brandedCube
        )
    }
}
