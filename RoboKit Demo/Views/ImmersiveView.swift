import SwiftUI
import RealityKit
import RoboKit

// MARK: - ImmersiveView Demo
// This demo project illustrates how to use RoboKit's image tracker with SwiftUI and RealityKit.
// It sets up a parent entity and dynamically adds sphere entities representing tracked images in an immersive view.
struct ImmersiveView: View {
    
    // Parent entity that holds all child entities (tracked images, root point, Input Sphere).
    @State private var parentEntity = Entity()
    
    // Placeholder for the computed root point entity.
    @State private var rootPoint: Entity?
    
    // Array to store entities representing tracked images.
    @State private var trackedSpheres: [Entity] = []
    
    // Initialize the image tracker with AR resource group and images with specified offsets.
    @State private var imageTracker: RoboKit.ImageTracker?
    
    // Initialize the InputSphereManager class.
    // Input Sphere is a RealityKit entity representing the target position and rotation for robot's end effector.
    @State private var inputSphereManager = RoboKit.InputSphereManager()
    
    var body: some View {
        // Initialize RealityView and add the parent entity to the scene.
        RealityView { content in
            content.add(parentEntity)
        }
        .inputSphereDragGesture(parentEntity: parentEntity, inputSphereManager: inputSphereManager)
        .onAppear {
            // Initialize Image Tracker module and start tracking images.
            initializeImageTracker()
            // Add Input Sphere entity to the parent entity above the root point.
            inputSphereManager.addInputSphere(parentEntity: parentEntity, rootPoint: rootPoint)
        }
        .onChange(of: imageTracker?.rootTransform) {
            // When the root transform changes, update the corresponding entity.
            updateRootEntity(with: imageTracker?.rootTransform)
        }
        .onChange(of: imageTracker?.trackedImagesTransform) {
            // When the tracked images transform changes, update the sphere entities accordingly.
            updateTrackingEntities(with: imageTracker?.trackedImagesTransform ?? [])
        }
    }
    
    // Initialize Image Tracker after view appears.
    private func initializeImageTracker() {
        do {
            imageTracker = try RoboKit.ImageTracker(
                arResourceGroupName: "AR Resources",
                images: [
                    .init(imageName: "Tracking-Image-1", rootOffset: .init(x: -0.11, y: 0, z: 0.169)),
                    .init(imageName: "Tracking-Image-2", rootOffset: .init(x: -0.11, y: 0, z: -0.169)),
                    .init(imageName: "Tracking-Image-3", rootOffset: .init(x: 0.11, y: 0, z: -0.169))
                ]
            )
            
            // On view appearance, update the root entity and the tracking entities using the tracker transforms.
            updateRootEntity(with: imageTracker?.rootTransform)
            updateTrackingEntities(with: imageTracker?.trackedImagesTransform ?? [])
        } catch {
            print("Failed to initialize image tracker:", error)
        }
    }
    
    /// Updates the root entity using the provided transformation matrix.
    /// - Parameter rootTransform: The optional transformation matrix for the root point.
    private func updateRootEntity(with rootTransform: float4x4? = nil) {
        // Ensure a valid transform is provided.
        guard let rootTransform else { return }
        
        // Create the root point entity if it doesn't exist.
        if rootPoint == nil {
            rootPoint = sphereEntity(color: .red)
            parentEntity.addChild(rootPoint!)
        }
        
        // Safely update the root point's transform.
        guard let rootPoint else { return }
        rootPoint.transform = Transform(matrix: rootTransform)
    }
    
    /// Updates the tracked sphere entities to match the provided image transforms.
    /// - Parameter imageTransforms: Array of transformation matrices for each tracked image.
    private func updateTrackingEntities(with imageTransforms: [float4x4]) {
        // Exit if no transforms are provided.
        guard !imageTransforms.isEmpty else { return }
        
        // Adjust the number of sphere entities to match the number of transforms.
        if imageTransforms.count > trackedSpheres.count {
            // Add new sphere entities as needed.
            for _ in 0..<(imageTransforms.count - trackedSpheres.count) {
                let sphere = sphereEntity(color: .blue)
                trackedSpheres.append(sphere)
                parentEntity.addChild(sphere)
            }
        } else if imageTransforms.count < trackedSpheres.count {
            // Remove extra sphere entities if any.
            for _ in 0..<(trackedSpheres.count - imageTransforms.count) {
                if let sphere = trackedSpheres.popLast() {
                    sphere.removeFromParent()
                }
            }
        }
        
        // Update each sphere entity's transform to match the corresponding image transform.
        for (index, transformMatrix) in imageTransforms.enumerated() {
            trackedSpheres[index].transform = Transform(matrix: transformMatrix)
        }
    }
}
