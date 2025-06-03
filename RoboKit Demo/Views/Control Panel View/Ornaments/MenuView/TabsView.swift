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
    @Binding var selectedTabs: Set<TabItem>
    private let showLabels: Bool

    init(selectedTabs: Binding<Set<TabItem>>, showLabels: Bool = false) {
        self._selectedTabs = selectedTabs
        self.showLabels = showLabels
    }

    var body: some View {
        HStack(spacing: 20) {
            ForEach(TabItem.allCases, id: \.self) { tab in
                VStack {
                    Button {
                        self.toggle(tab)
                    } label: {
                        Image(systemName: tab.icon)
                            .font(.largeTitle)
                    }
                    .buttonStyle(.plain)

                    if showLabels {
                        Text(tab.rawValue)
                    }
                }
                .foregroundColor(selectedTabs.contains(tab) ? .white : .secondary)
                .animation(.spring, value: selectedTabs.contains(tab))
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
