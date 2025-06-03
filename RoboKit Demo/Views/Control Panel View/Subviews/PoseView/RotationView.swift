//
//  RotationView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 22.05.2025.
//

import SwiftUI
import RoboKit
import RealityFoundation

// View that allows us to set the orientation of the Input Sphere using Sliders
// The view will display the orientation of the sphere, if the root point is not defined yet.
public struct RotationView: View {
    @Environment(TCPClient.self) private var client: TCPClient
    @Environment(ImageTracker.self) private var imageTracker: ImageTracker

    public var body: some View {
        VStack(alignment: .leading) {
            switch client.selectedDataMode {
            case .live:
                Group {
                    if let rootTransform = imageTracker.rootTransform {
                        ForEach(Array(EulerAngle.allCases.enumerated()), id: \.element) { index, eulerAngle in
                            RoboKit.InputSphereRotationSlider(
                                rootPoint: getRootPointEntity(from: rootTransform),
                                eulerAngle: eulerAngle
                            )
                            if index != RoboKit.EulerAngle.allCases.count - 1 {
                                Spacer()
                            }
                        }
                    } else {
                        ForEach(EulerAngle.allCases, id: \.self) { eulerAngle in
                            RoboKit.InputSphereRotationText(eulerAngle: eulerAngle)
                        }
                    }
                }
                .transition(.move(edge: .leading).combined(with: .opacity))
            case .set:
                ForEach(EulerAngle.allCases, id: \.self) { eulerAngle in
                    RoboKit.FormRotationTextField(eulerAngle: eulerAngle)
                }
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .animation(.spring, value: client.selectedDataMode)
    }

    // Create an entity that represents the transformation of the root entity
    private func getRootPointEntity(from transformMatrix: simd_float4x4) -> Entity {
        let rootPoint = Entity()
        rootPoint.transform = Transform(matrix: transformMatrix)
        return rootPoint
    }
}
