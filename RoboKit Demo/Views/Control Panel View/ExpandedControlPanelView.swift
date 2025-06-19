//
//  ControlPanelView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 26.05.2025.
//

import SwiftUI
import RoboKit

// A view for Expanded Control Panel, containing different sections for controlling properties of the Data
extension ControlPanelView {
    struct ExpandedControlPanelView: View {
        @Environment(\.accessibilityReduceMotion) var isReduceMotionEnabled
        @Binding var selectedTabs: Set<TabItem>

        var body: some View {
            VStack(alignment: .leading, spacing: 30) {
                // Object dimensions view allows us to set measurement of the object for the gripper
                if selectedTabs.contains(.dimensions) {
                    ObjectDimensionsView()
                        .transition(.opacity)
                    Divider()
                }

                // Set the position and orientation of the Input Cube
                if selectedTabs.contains(.pose) {
                    PoseView()
                        .transition(.opacity)
                    Divider()
                }

                // Accessories View allows to take control over the robot's accessories, such as Gripper
                if selectedTabs.contains(.accessories) {
                    AccessoriesView()
                        .transition(.opacity)
                }
            }
            .frame(width: 350)
            .padding(.bottom, 50)
            .padding(.all, 30)
            .animation(isReduceMotionEnabled ? nil : .spring(), value: selectedTabs)
        }
    }
}
