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
        VStack(alignment: .leading, spacing: 40) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Position")
                    .font(.title)
                Divider()
                RoboKit.InputSpherePositionView(relativeToRootPoint: rootPoint)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Rotation")
                    .font(.title)
                Divider()
                RoboKit.InputSphereRotationSlider(eulerAngle: .yaw)
            }
            
            HStack {
                Spacer()
                PrintInputSphereDataButton(relativeToRootPoint: rootPoint)
                Spacer()
            }
        }
        .padding(40)
        .fontDesign(.rounded)
    }
}
