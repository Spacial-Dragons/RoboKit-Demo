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

    public var body: some View {
        VStack(alignment: .leading) {
            switch client.selectedDataMode {
            case .live:
                ForEach(Axis.allCases, id: \.self) { axis in
                    RoboKit.InputSpherePositionText(axis: axis)
                }
            case .set:
                ForEach(Axis.allCases, id: \.self) { axis in
                    RoboKit.FormPositionTextField(axis: axis)
                }
            }
        }
    }
}
