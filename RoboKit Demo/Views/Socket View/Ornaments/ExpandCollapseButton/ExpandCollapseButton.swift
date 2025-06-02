//
//  ExpandCollapseButton.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 25.05.2025.
//

import SwiftUI

struct ExpandCollapseButton: View {
    @Binding var socketCollapsed: Bool

    var body: some View {
        Button(
            socketCollapsed ? "Expand" : "Collapse",
            systemImage: socketCollapsed ? "arrow.down.backward.and.arrow.up.forward" : "arrow.down.forward.and.arrow.up.backward"
        ) {
            withAnimation {
                socketCollapsed.toggle()
            }
        }
        .contentTransition(.symbolEffect(.replace))
        .labelStyle(.iconOnly)
        .glassBackgroundEffect()
    }
}
