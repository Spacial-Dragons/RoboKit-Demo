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
            systemImage: socketCollapsed ? "arrow.down.backward.and.arrow.up.forward.circle.fill" : "arrow.down.forward.and.arrow.up.backward.circle.fill"
        ) {
            withAnimation(.linear(duration: 0.1)) {
                socketCollapsed.toggle()
            }
            
        }
        .labelStyle(.iconOnly)
        .glassBackgroundEffect()
    }
}
