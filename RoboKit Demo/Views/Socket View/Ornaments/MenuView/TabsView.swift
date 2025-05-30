//
//  TabView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 26.05.2025.
//

import SwiftUI
import RoboKit

#warning("")

struct TabsView: View {
    @Binding var selectedTabs: Set<TabItem>
    private var showLabels: Bool

    init(selectedTabs: Binding<Set<TabItem>>, showLabels: Bool = false) {
        self._selectedTabs = selectedTabs
        self.showLabels = showLabels
    }

    var body: some View {
        HStack(spacing: 20) {
            ForEach(TabItem.allCases) { tab in
                VStack {
                    Group{
                        Button(tab.rawValue, systemImage: tab.icon) {
                            toggle(tab)
                        }
                        .font(.largeTitle)
                        .buttonStyle(.plain)

                        if showLabels {
                            Text(tab.rawValue)
                                .font(.system(size: 12))
                        }
                    }
                    .foregroundColor(selectedTabs.contains(tab) ? .white : .secondary)
                    .animation(.spring, value: selectedTabs.contains(tab))
                }
            }
        }
    }

    private func toggle(_ tab: TabItem) {
        if selectedTabs.contains(tab) {
            selectedTabs.remove(tab)
        } else {
            selectedTabs.insert(tab)
        }
        tab.action()
    }
}
