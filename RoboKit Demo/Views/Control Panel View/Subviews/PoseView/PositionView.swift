//
//  PositionView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 20.05.2025.
//

import SwiftUI
import RoboKit

/// Displays position of the input sphere in live mode
/// and allows to set the position using input fields in the "Set" mode
public struct PositionView: View {
    @Environment(TCPClient.self) private var client: TCPClient

    public var body: some View {

        Group {
            switch client.selectedDataMode {
            case .live:
                HStack {
                    ForEach(Array(Axis.allCases.enumerated()), id: \.element) { index, axis in
                        RoboKit.InputSpherePositionText(axis: axis)
                        if index != RoboKit.Axis.allCases.count - 1 {
                            Spacer()
                        }
                    }
                }
                .transition(.move(edge: .leading).combined(with: .opacity))

            case .set:
                VStack(alignment: .leading) {
                    ForEach(Axis.allCases, id: \.self) { axis in
                        RoboKit.FormPositionTextField(axis: axis)
                            .padding(.vertical, 3)
                    }
                }
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .animation(.spring, value: client.selectedDataMode)

    }
}
