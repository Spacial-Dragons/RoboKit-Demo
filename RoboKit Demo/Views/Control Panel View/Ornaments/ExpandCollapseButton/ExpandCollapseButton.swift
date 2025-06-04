//
//  ExpandCollapseButton.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 25.05.2025.
//

import SwiftUI

// A view that allows to expand all of the control panel sections all at once
struct ExpandCollapseButton: View {
    @Environment(\.accessibilityReduceMotion) var isReduceMotionEnabled
    let isCollapsed: Bool
    let toggleAction: () -> Void
    
    private var imageName: String {
        isCollapsed
          ? "arrow.down.backward.and.arrow.up.forward"
          : "arrow.down.forward.and.arrow.up.backward"
    }

    var body: some View {
        Button(
            isCollapsed ? "Expand Control Panel" : "Collapse Control Panel",
            systemImage: imageName
        ) {
            withAnimation(isReduceMotionEnabled ? nil : .spring()) {
                toggleAction()
            }
        }
        .contentTransition(isReduceMotionEnabled ? .identity : .symbolEffect(.replace))
        .labelStyle(.iconOnly)
    }
}
