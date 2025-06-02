//
//  DataModeIndicator.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 25.05.2025.
//

import SwiftUI
import RoboKit

struct DataModeIndicator: View {
    var dataMode: RoboKit.DataMode
    @State private var animate = false

    private var color: Color { dataMode == .live ? .green : .yellow }
    private var label: String { dataMode == .live ? "Live" : "Set" }

    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                Circle()
                    .fill(color)
                    .frame(width: 16, height: 16)

                if dataMode == .live {
                    PulseCircle(color: color, animate: $animate)
                }
            }
            .onAppear { animate = (dataMode == .live) }
            .onChange(of: dataMode) {
                animate = (dataMode == .live)
            }

            Text(label)
        }
    }
}

struct PulseCircle: View {
    let color: Color
    @Binding var animate: Bool

    var body: some View {
        Circle()
            .stroke(color.opacity(0.6), lineWidth: 3)
            .frame(width: 32, height: 32)
            .scaleEffect(animate ? 1.2 : 0.4)
            .opacity(animate ? 0 : 1)
            .blur(radius: 4)
            .animation(
                .easeOut(duration: 1.2).repeatForever(autoreverses: false),
                value: animate
            )
            .onAppear { animate = true }
    }
}
