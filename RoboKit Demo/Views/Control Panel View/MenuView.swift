//
//  ControlPanelView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 26.05.2025.
//

import SwiftUI
import RoboKit

extension ControlPanelView {
    struct MenuView: View {
        @Environment(TCPClient.self) private var client: TCPClient
        @Binding var selectedTabs: Set<TabItem>
        
        @ViewBuilder
        func viewForAxis(_ axis: RoboKit.Axis) -> some View {
            switch client.selectedDataMode {
            case .live:
                RoboKit.InputSpherePositionText(axis: axis)
            case .set:
                RoboKit.FormPositionText(axis: axis)
            }
        }

        var body: some View {
            HStack(spacing: 20) {
                TabsView(selectedTabs: $selectedTabs, showLabels: true)
                    .labelStyle(.iconOnly)

                Divider()

                ForEach(Axis.allCases, id: \.self) { axis in
                    viewForAxis(axis)
                }

                Divider()

                DataModeIndicator(dataMode: client.selectedDataMode)
            }
        }
    }
}
