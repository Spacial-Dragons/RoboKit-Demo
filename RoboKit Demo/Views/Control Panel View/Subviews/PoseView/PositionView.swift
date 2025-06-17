//
//  PositionView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 20.05.2025.
//

import SwiftUI
import RoboKit

/// Displays position of the input cube in live mode
/// and allows to set the position using input fields in the "Set" mode
public struct PositionView: View {
    @Environment(\.accessibilityReduceMotion) var isReduceMotionEnabled
    @Environment(ControlPanelModel.self) private var controlPanelModel: ControlPanelModel

    public var body: some View {

        VStack(alignment: .leading) {
            switch controlPanelModel.selectedDataMode {
            case .live:
                ForEach(Array(Axis.allCases.enumerated()), id: \.element) { index, axis in
                    RoboKit.InputEntityPositionText(axis: axis, showFullDescription: true)
                    if index != RoboKit.Axis.allCases.count - 1 {
                        Spacer()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .transition(.move(edge: .leading).combined(with: .opacity))

            case .set:
                ForEach(Axis.allCases, id: \.self) { axis in
                    RoboKit.FormPositionTextField(axis: axis)
                }
                .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .animation(isReduceMotionEnabled ? nil : .spring(), value: controlPanelModel.selectedDataMode)

    }
}
