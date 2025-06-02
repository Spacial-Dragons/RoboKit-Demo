//
//  ExpandCollapseButton.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 25.05.2025.
//

import SwiftUI

struct ExpandCollapseButton: View {
    @Binding var panelCollapsed: Bool

    var body: some View {
        Button(
            panelCollapsed ? "Expand Control Panel" : "Collapse Control Panel",
            systemImage: "arrow.down.\(panelCollapsed ? "backward" : "forward").and.arrow.up.\(panelCollapsed ? "forward" : "backward")"
        ) {
            withAnimation {
                panelCollapsed.toggle()
            }
        }
        .contentTransition(.symbolEffect(.replace))
        .labelStyle(.iconOnly)
    }
}
