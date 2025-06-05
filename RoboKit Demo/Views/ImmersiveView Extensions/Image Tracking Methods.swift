//
//  Image Tracking Methods.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 06.05.2025.
//

import SwiftUI
import RoboKit
import RealityFoundation

extension ImmersiveView {

    /// Updates the root entity using the provided transformation matrix.
    /// - Parameter rootTransform: The optional transformation matrix for the root point.
    internal func updateRootEntity(with rootTransform: float4x4? = nil) {
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
    internal func updateTrackingEntities(with imageTransforms: [float4x4]) {
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
