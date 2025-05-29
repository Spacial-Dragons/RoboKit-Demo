//
//  MenuView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 25.05.2025.
//

import SwiftUI
import RoboKit

struct MenuView: View {
    @Environment(TCPClient.self) private var client: TCPClient
    
    @Binding var selectedTabs: Set<TabItem>
    
    init(selectedTabs: Binding<Set<TabItem>>) {
        self._selectedTabs = selectedTabs
    }
    
    var body: some View {
        HStack {
            TabsView(selectedTabs: $selectedTabs)
            .padding(.horizontal)
            
            Divider()
            
            VStack(alignment: .leading) {
                switch client.selectedDataMode {
                case .live:
                    ForEach(Axis.allCases, id: \.self) { axis in
                        RoboKit.InputSpherePositionText(axis: axis, valueWidth: 40)
                    }
                case .set:
                    ForEach(Axis.allCases, id: \.self) { axis in
                        RoboKit.FormPositionText(axis: axis, valueWidth: 40)
                    }
                }
            }
            .font(.system(size: 12))
            
            Divider()
            
            DataModeIndicator(dataMode: client.selectedDataMode)
            
            .frame(width: 100)
        }
        .labelStyle(.iconOnly)
        .padding(.vertical)
        .glassBackgroundEffect()
    }
}

