//
//  RotationView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 22.05.2025.
//

import SwiftUI
import RoboKit

public struct RotationView: View {
    @Environment(TCPClient.self) private var client: TCPClient

    public var body: some View {
        VStack(alignment: .leading) {
            switch client.selectedDataMode {
            case .live:
                ForEach(EulerAngle.allCases, id: \.self) { eulerAngle in
                    RoboKit.InputSphereRotationText(eulerAngle: eulerAngle)
                }
            case .set:
                ForEach(EulerAngle.allCases, id: \.self) { eulerAngle in
                    RoboKit.FormRotationTextField(eulerAngle: eulerAngle)
                }
            }
        }
    }
}
