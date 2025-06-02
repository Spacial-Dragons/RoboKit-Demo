//
//  Attachment Update Method.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 06.05.2025.
//

import SwiftUI
import RealityKit

extension ImmersiveView {
    /// Updates the position of the input sphere attachment entity within the RealityView.
    /// - Parameter attachments: The collection of `RealityViewAttachments`
    /// from which the input sphere attachment is retrieved.
    internal func updateInputSphereAttachmentPosition(attachments: RealityViewAttachments) {
        guard let attachment = attachments.entity(for: inputSphereAttachmentID) else { return }
        guard let inputSpherePosition = inputSphereManager.inputSpherePositionRelativeToParent else { return }
        attachment.position = inputSpherePosition + SIMD3<Float>(0.25, 0.14, 0)
    }
}
