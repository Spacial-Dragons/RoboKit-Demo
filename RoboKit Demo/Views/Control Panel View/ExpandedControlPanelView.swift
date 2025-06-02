//
//  ControlPanelView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 26.05.2025.
//

import SwiftUI
import RoboKit

extension ControlPanelView {
    struct ExpandedControlPanelView: View {
        @Binding var selectedTabs: Set<TabItem>

        var body: some View {
            VStack(alignment: .leading, spacing: 30) {
                if selectedTabs.contains(.dimensions) {
                    ObjectDimensionsView()
                    Divider()
                }

                if selectedTabs.contains(.pose) {
                    PoseView()
                    Divider()
                }

                if selectedTabs.contains(.accessories) {
                    AccessoriesView()
                }
            }
            .padding(.bottom, 50)
            .padding(.all, 30)
        }
    }
}
