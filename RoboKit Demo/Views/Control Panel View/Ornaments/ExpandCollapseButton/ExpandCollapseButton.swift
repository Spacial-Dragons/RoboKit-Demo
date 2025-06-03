//
//  ExpandCollapseButton.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 25.05.2025.
//

import SwiftUI

// A view that allows to expand all of the control panel sections all at once
struct ExpandCollapseButton: View {
    let isCollapsed: Bool
    let toggleAction: () -> Void

    var body: some View {
        Button(
            isCollapsed ? "Expand Control Panel" : "Collapse Control Panel",
            systemImage: "arrow.down.\(isCollapsed ? "backward" : "forward")"
                + ".and.arrow.up.\(isCollapsed ? "forward" : "backward")"
        ) {
            withAnimation {
                toggleAction()
            }
        }
        .contentTransition(.symbolEffect(.replace))
        .labelStyle(.iconOnly)
    }
}
