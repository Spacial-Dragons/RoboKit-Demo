//
//  PositionView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 20.05.2025.
//

import SwiftUI
import RoboKit

public struct PositionView: View {
    @Environment(TCPClient.self) private var client: TCPClient
    @Environment(InputSphereManager.self) private var inputSphereManager: InputSphereManager
    @Environment(FormManager.self) private var formManager: FormManager
    
    public var body: some View {
        
        VStack(alignment: .leading, spacing: -10) {
            switch client.selectedDataMode {
            case .live:
                HStack(spacing: 40) {
                    ForEach(Axis.allCases, id: \.self) { axis in
                        RoboKit.InputSpherePositionText(axis: axis)
                    }
                }
                .padding(.top)
            case .set:
                VStack(spacing: -10) {
                    ForEach(Axis.allCases, id: \.self) { axis in
                        RoboKit.FormPositionTextField(axis: axis)
                    }
                    .frame(width: 210)
                }
            }
        }
    }
}
