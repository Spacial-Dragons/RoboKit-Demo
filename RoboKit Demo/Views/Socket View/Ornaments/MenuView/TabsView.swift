//
//  TabView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 26.05.2025.
//

import SwiftUI
import RoboKit

struct TabsView: View {
    private var showLabels: Bool
    
    init(showLabels: Bool = false) {
        self.showLabels = showLabels
    }
    
    var body: some View {
        HStack {
            VStack {
                Button("Dimensions", systemImage: "cube.fill") {
                    // new action
                }
                if showLabels {
                    Text("Dimensions")
                        .font(.system(size: 12))
                }
            }
            
            VStack {
                Button("Pose", systemImage: "mappin.and.ellipse.circle.fill") {
                    // save action
                }
                if showLabels {
                    Text("Pose")
                        .font(.system(size: 12))
                }
            }
        
            VStack {
                Button("Accessories", systemImage: "circle.dotted.circle") {
                    // save action
                }
                if showLabels {
                    Text("Accessories")
                        .font(.system(size: 12))
                }
            }
        }
    }
}
