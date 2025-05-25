//
//  MenuView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 25.05.2025.
//

import SwiftUI
import RoboKit

struct MenuView: View {
    var body: some View {
        HStack {
            
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
            .padding(.horizontal)
            
            Divider()
            
            VStack(alignment: .leading) {
                ForEach(Axis.allCases, id: \.self) { axis in
                    RoboKit.InputSpherePositionText(axis: axis, valueWidth: 40)
                }
            }
            .font(.system(size: 12))
            
            Divider()
            
            HStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: 8)
                Text("Live")
            }
            
            .frame(width: 100)
        }
        .labelStyle(.iconOnly)
        .padding(.vertical)
        .glassBackgroundEffect()
    }
}

