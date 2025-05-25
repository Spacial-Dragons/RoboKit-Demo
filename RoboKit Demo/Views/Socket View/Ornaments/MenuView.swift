//
//  MenuView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 25.05.2025.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        HStack {
            Button("Dimensions", systemImage: "cube.fill") {
                // new action
            }
        
            Button("Pose", systemImage: "mappin.and.ellipse.circle.fill") {
                // save action
            }
            
            Button("Accessories", systemImage: "circle.dotted.circle") {
                // save action
            }
        }
        .labelStyle(.iconOnly)
        .padding(.vertical)
        .glassBackgroundEffect()
    }
}

