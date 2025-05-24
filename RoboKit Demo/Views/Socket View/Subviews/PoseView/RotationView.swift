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
    @Environment(InputSphereManager.self) private var inputSphereManager: InputSphereManager
    @Environment(FormManager.self) private var formManager: FormManager
    
    public var body: some View {
        
        VStack(alignment: .leading, spacing: -10) {
            switch client.selectedDataMode {
            case .live:
                HStack(spacing: 37) {
                    ForEach(EulerAngle.allCases, id: \.self) { eulerAngle in
                        RoboKit.InputSphereRotationText(eulerAngle: eulerAngle)
                    }
                }
                .padding(.top)
            case .set:
                VStack(alignment: .leading, spacing: -10) {
                    ForEach(EulerAngle.allCases, id: \.self) { eulerAngle in
                        RoboKit.FormRotationTextField(eulerAngle: eulerAngle)
                    }
                    .frame(width: 280)
                }
            }
        }
    }
}
