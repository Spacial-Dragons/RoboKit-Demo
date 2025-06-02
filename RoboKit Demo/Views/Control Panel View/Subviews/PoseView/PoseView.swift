//
//  PoseView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 20.05.2025.
//

import SwiftUI
import RoboKit

public struct PoseView: View {

    public var body: some View {
        VStack(alignment: .leading) {
            Text("Pose")
                .font(.title3)

            Text("Set the position and rotation for the robot.")
                .foregroundStyle(.secondary)

            RoboKit.DataModePicker()
                .padding(.vertical)

            VStack(alignment: .leading, spacing: 20) {
                PositionView()
                RotationView()
            }
        }
    }

}
