//
//  Attachment Update Method.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 06.05.2025.
//

import SwiftUI
import RealityKit

extension ImmersiveView {
    internal func updateInputSphereAttachmentPosition(attachments: RealityViewAttachments) {
        guard let attachment = attachments.entity(for: inputSphereAttachmentID) else { return }
        attachment.position = inputSphereManager.inputSpherePositionRelativeToParent + SIMD3<Float>(0.3, 0.18, 0)
    }
}
