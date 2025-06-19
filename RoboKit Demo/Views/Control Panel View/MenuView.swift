//
//  ControlPanelView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 26.05.2025.
//

import SwiftUI
import RoboKit

// A menu view that is displayed as an attachment (ornament) below the Control Panel
extension ControlPanelView {
    struct MenuView: View {
        @Environment(ControlPanelModel.self) private var controlPanelModel: ControlPanelModel
        @Binding var selectedTabs: Set<TabItem>

        // Dynamically update the axis View based on the Data Transmission mode
        @ViewBuilder
        func viewForAxis(_ axis: RoboKit.Axis) -> some View {
            switch controlPanelModel.selectedDataMode {
            case .live:
                RoboKit.InputEntityPositionText(axis: axis)
            case .set:
                RoboKit.FormPositionText(axis: axis)
            }
        }

        var body: some View {
            HStack(spacing: 20) {
                // Tabs View allows us to dynamically turn on and turn off sections in the Control Panel
                TabsView(selectedTabs: $selectedTabs, showLabels: true)
                    .labelStyle(.iconOnly)

                Divider()

                // Initialize positional view for each axis: lateral, longitudinal, vertical
                ForEach(Axis.allCases, id: \.self) { axis in
                    viewForAxis(axis)
                }

                Divider()

                // Indicates currently selected transmission mode from the Control Panel - Live or Set
                DataModeIndicator(dataMode: controlPanelModel.selectedDataMode)
            }
        }
    }
}
