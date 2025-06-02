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

    private var color: Color {
        switch dataMode {
        case .live: return .green
        case .set:  return .yellow
        }
    }

    private var label: String {
        switch dataMode {
        case .live: return "Live"
        case .set:  return "Set"
        }
    }

    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(color)
                    .frame(width: 16, height: 16)
                if dataMode == .live {
                    Circle()
                        .stroke(color.opacity(0.6), lineWidth: 3)
                        .frame(width: 32, height: 32)
                        .scaleEffect(animate ? 1.2 : 0.4)
                        .blur(radius: 4)
                        .opacity(animate ? 0 : 1)
                        .animation(
                            Animation.easeOut(duration: 1.2)
                                .repeatForever(autoreverses: false),
                            value: animate
                        )
                }
            }
            .onAppear {
                guard dataMode == .live else { animate = false; return }
                animate = true
            }
            
            .onChange(of: dataMode) {
                guard dataMode == .live else { animate = false; return }
                animate = true
            }
            
            .onDisappear {
                animate = false
            }

            Text(label)
        }
    }
}
