//
//  ObjectDimensionsView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 20.05.2025.
//

import SwiftUI
import RoboKit

struct ObjectDimensionsView: View {
    @Environment(ControlPanelModel.self) private var controlPanelModel: ControlPanelModel

    var body: some View {
        @Bindable var controlPanelModel = controlPanelModel
        
        VStack(alignment: .leading) {
            Text("Dimensions")
                .font(.title3)

            Text("Set the dimensions for the object.")
                .foregroundStyle(.secondary)

            RoboKit.ObjectWidthUnitPicker(objectWidthUnit: $controlPanelModel.objectWidthUnit)
                .frame(width: 350)
                .padding(.vertical)

            HStack {
                Text("Width")
                RoboKit.ObjectWidthTextField(objectWidth: $controlPanelModel.objectWidth)
            }
        }
    }
}
