//
//  TabView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 26.05.2025.
//

import RoboKit
import SwiftUI

// TabsView contains Buttons that allow us to dynamically toggle sections in the Control Panel
struct TabsView: View {
    @Environment(\.accessibilityReduceMotion) var isReduceMotionEnabled
    @Binding var selectedTabs: Set<TabItem>
    private let showLabels: Bool

    init(selectedTabs: Binding<Set<TabItem>>, showLabels: Bool = false) {
        self._selectedTabs = selectedTabs
        self.showLabels = showLabels
    }

    var body: some View {
        HStack(spacing: 20) {
            ForEach(TabItem.allCases, id: \.self) { tab in
                TabButton(
                    tab: tab,
                    isSelected: selectedTabs.contains(tab),
                    showLabel: showLabels,
                    toggleAction: { toggle(tab) }
                )
            }
        }
    }

    // Function that removes the selected Tab from the Hash Set
    private func toggle(_ tab: TabItem) {
        if selectedTabs.contains(tab) {
            selectedTabs.remove(tab)
        } else {
            selectedTabs.insert(tab)
        }
    }
}

struct TabButton: View {
    @Environment(\.accessibilityReduceMotion) var isReduceMotionEnabled
    let tab: TabItem
    let isSelected: Bool
    let showLabel: Bool
    let toggleAction: () -> Void

    var body: some View {
        VStack {
            Button(action: toggleAction) {
                Label(tab.rawValue, systemImage: tab.icon)
                    .font(.largeTitle)
            }
            .buttonStyle(.plain)

            if showLabel {
                Text(tab.rawValue)
                    .accessibilityHidden(true)
            }
        }
        .foregroundColor(isSelected ? .white : .secondary)
        .animation(isReduceMotionEnabled ? nil : .spring(), value: isSelected)
    }
}
