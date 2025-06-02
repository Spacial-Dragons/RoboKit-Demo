//
//  RotationView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 22.05.2025.
//

import SwiftUI
import RoboKit
import RealityFoundation

public struct RotationView: View {
    @Environment(TCPClient.self) private var client: TCPClient
    @Environment(ImageTracker.self) private var imageTracker: ImageTracker

    public var body: some View {
        VStack(alignment: .leading) {
            switch client.selectedDataMode {
            case .live:
                ForEach(EulerAngle.allCases, id: \.self) { eulerAngle in
                    RoboKit.InputSphereRotationText(eulerAngle: eulerAngle)
                }
            case .set:
                if let rootTransform = imageTracker.rootTransform {
                    ForEach(EulerAngle.allCases, id: \.self) { eulerAngle in
                        RoboKit.InputSphereRotationSlider(
                            rootPoint: getRootPointEntity(from: rootTransform),
                            eulerAngle: eulerAngle
                        )
                        .padding(.vertical, 8)
                    }
                } else {
                    ForEach(EulerAngle.allCases, id: \.self) { eulerAngle in
                        RoboKit.FormRotationTextField(eulerAngle: eulerAngle)
                    }
                }
            }
        }
    }

    private func getRootPointEntity(from transformMatrix: simd_float4x4) -> Entity {
        let rootPoint = Entity()
        rootPoint.transform = Transform(matrix: transformMatrix)
        return rootPoint
    }
}
