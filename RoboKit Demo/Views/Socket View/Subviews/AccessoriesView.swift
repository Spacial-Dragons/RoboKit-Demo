//
//  AccessoriesView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 20.05.2025.
//

import SwiftUI
import RoboKit

struct AccessoriesView: View {
    @Binding private var clawShouldOpen: Bool

    init(clawShouldOpen: Binding<Bool>) {
        self._clawShouldOpen = clawShouldOpen
    }

    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Accessories")
                    .font(.title3)

                Text("Set for the action.")
                    .foregroundStyle(.secondary)
            }

            HStack {
                Text("Gripper")
                RoboKit.ClawControlToggle(clawShouldOpen: $clawShouldOpen)
                    .frame(width: 200)
            }
            .padding(.vertical)
        }
    }
}
