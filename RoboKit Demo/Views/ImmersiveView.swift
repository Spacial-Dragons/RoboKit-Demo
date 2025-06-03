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

    // ID of Input Sphere's Attachment.
    internal let inputSphereAttachmentID: String = "InputSphereAttachment"

    var body: some View {
        // Initialize RealityView and add the parent entity to the scene.
        RealityView { content, attachments in
            content.add(parentEntity)

            // Add Input Sphere attachment.
            if let inputSphereAttachment = attachments.entity(for: inputSphereAttachmentID) {
                content.add(inputSphereAttachment)
            }
        } update: { _, attachments in
            // Dynamically update attachment position to follow input sphere
            updateInputSphereAttachmentPosition(attachments: attachments)
        } attachments: {
            // Add attachment with orientation controls to the Input Sphere
            if let rootPoint {
                Attachment(id: inputSphereAttachmentID) {
                    InputSphereAttachmentView(rootPoint: rootPoint)
                        .padding(.all, 30)
                        .frame(width: 500)
                        .glassBackgroundEffect()
                }
            }
        }

        /// Updates the root entity and tracked image entities upon successful initialization.
        .onAppear {
            updateRootEntity(with: imageTracker.rootTransform)
            updateTrackingEntities(with: imageTracker.trackedImagesTransform)

            // Add Input Sphere entity to the parent entity above the root point if it doesn't exist yet.
            inputSphereManager.addInputSphere(parentEntity: parentEntity, rootPoint: rootPoint)
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
            inputSphereManager.addInputSphere(parentEntity: parentEntity, rootPoint: rootPoint)
        }

        .onChange(of: imageTracker.trackedImagesTransform) {
            // When the tracked images transform changes, update the sphere entities accordingly.
            updateTrackingEntities(with: imageTracker.trackedImagesTransform)
        }
    }
}
