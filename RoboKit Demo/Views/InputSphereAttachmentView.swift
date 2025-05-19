//
//  InputSphereAttachmentView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 03.05.2025.
//

import RoboKit
import SwiftUI
import RealityKit

// Main view for attaching and configuring the input sphere
struct InputSphereAttachmentView: View {
    // Access the shared InputSphereManager from the environment
    @Environment(InputSphereManager.self) private var inputSphereManager: InputSphereManager

    // The root entity used for calculation of positioning and rotation
    let rootPoint: Entity

    var body: some View {
        VStack(spacing: 40) {
            VStack(alignment: .leading, spacing: 40) {
                // Section for sphere position configuration
                VStack(alignment: .leading, spacing: 10) {
                    Text("Position")
                        .font(.title)
                    Divider()
                    // View for adjusting the sphere's position relative to the root point
                    RoboKit.InputSpherePositionView(relativeToRootPoint: rootPoint)
                }

                // Section for sphere rotation configuration
                VStack(alignment: .leading, spacing: 10) {
                    Text("Rotation")
                        .font(.title)
                    Divider()
                    // Slider for adjusting the yaw rotation of the input sphere
                    RoboKit.InputSphereRotationSlider(eulerAngle: .yaw)
                }
            }

            // Button for accessing transform of the root point and sending it to the server
            SocketButtonView(relativeToRootPoint: rootPoint)
        }
        .padding()
    }
}
