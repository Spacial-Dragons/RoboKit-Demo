//
//  PoseView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 20.05.2025.
//

import SwiftUI
import RoboKit

// A view that displays Position and Orientation of the input sphere and allows to input custom values
public struct PoseView: View {
    @Environment(ControlPanelModel.self) private var controlPanelModel: ControlPanelModel

    public var body: some View {
        @Bindable var controlPanelModel = controlPanelModel

        VStack(alignment: .leading) {
            Text("Pose")
                .font(.title3)

            Text("Set the position and rotation for the robot.")
                .foregroundStyle(.secondary)

            RoboKit.DataModePicker(selectedDataMode: $controlPanelModel.selectedDataMode)
                .frame(width: 350)
                .padding(.top)

            Divider()
                .padding(.vertical)

            VStack(alignment: .leading, spacing: 20) {
                PositionView()
                Divider()
                RotationView()
            }
            .frame(height: 263)
        }
    }

}
