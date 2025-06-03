//
//  InputSphereAttachmentView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 03.05.2025.
//

import RoboKit
import SwiftUI
import RealityFoundation

// View that holds all of the sliders to control orientation of the Input Sphere
struct InputSphereAttachmentView: View {
    let rootPoint: Entity

    // Initialize a Slider for each of the axises: pitch, roll, yaw
    var body: some View {
        ForEach(EulerAngle.allCases, id: \.self) { eulerAngle in
            RoboKit.InputSphereRotationSlider(rootPoint: rootPoint, eulerAngle: eulerAngle)
        }
    }
}
