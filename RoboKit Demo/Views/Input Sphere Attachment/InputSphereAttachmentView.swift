//
//  InputSphereAttachmentView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 03.05.2025.
//

import RoboKit
import SwiftUI
import RealityKit

struct InputSphereAttachmentView: View {
    @Environment(InputSphereManager.self) private var inputSphereManager: InputSphereManager
    let rootPoint: Entity
    
    var body: some View {
        VStack() {
            ForEach(EulerAngle.allCases, id: \.self) { eulerAngle in
                RoboKit.InputSphereRotationSlider(rootPoint: rootPoint, eulerAngle: eulerAngle)
            }
        }
        .frame(width: 450)
    }
}
