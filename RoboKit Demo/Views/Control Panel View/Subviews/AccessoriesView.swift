//
//  AccessoriesView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 20.05.2025.
//

import SwiftUI
import RoboKit

struct AccessoriesView: View {
    @Environment(ControlPanelModel.self) private var controlPanelModel: ControlPanelModel

    var body: some View {
        @Bindable var controlPanelModel = controlPanelModel
        
        VStack(alignment: .leading) {
            Text("Accessories")
                .font(.title3)

            Text("Set for the action.")
                .foregroundStyle(.secondary)

            HStack {
                Text("Gripper")
                RoboKit.ClawControlToggle(clawShouldOpen: $controlPanelModel.clawShouldOpen)
                    .frame(width: 200)
            }
            .padding(.vertical)
        }
    }
}
