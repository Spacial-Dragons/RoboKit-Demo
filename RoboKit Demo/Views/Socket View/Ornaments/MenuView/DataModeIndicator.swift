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
    var body: some View {
        switch dataMode {
        case .live:
            HStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: 8)
                Text("Live")
            }
        case .set:
            HStack {
                Circle()
                    .fill(Color.yellow)
                    .frame(width: 8)
                Text("Set")
            }
        }
    }
}
