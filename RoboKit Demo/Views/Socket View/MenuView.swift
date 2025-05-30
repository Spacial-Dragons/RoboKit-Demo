//
//  SocketCollapsedView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 26.05.2025.
//

import SwiftUI
import RoboKit

extension SocketView {
    struct MenuView: View {
        @Environment(TCPClient.self) private var client: TCPClient

        @Binding var selectedTabs: Set<TabItem>

        init(selectedTabs: Binding<Set<TabItem>>) {
            self._selectedTabs = selectedTabs
        }

        var body: some View {
            HStack(spacing: 20) {
                TabsView(selectedTabs: $selectedTabs, showLabels: true)
                    .labelStyle(.iconOnly)

                Divider()

                HStack {
                    switch client.selectedDataMode {
                    case .live:
                        ForEach(Axis.allCases, id: \.self) { axis in
                            RoboKit.InputSpherePositionText(axis: axis)
                        }
                    case .set:
                        ForEach(Axis.allCases, id: \.self) { axis in
                            RoboKit.FormPositionText(axis: axis)
                        }
                    }
                }

                Divider()

                DataModeIndicator(dataMode: client.selectedDataMode)
            }
        }
    }
}
