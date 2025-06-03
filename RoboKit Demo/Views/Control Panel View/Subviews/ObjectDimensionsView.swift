//
//  ObjectDimensionsView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 20.05.2025.
//

import SwiftUI
import RoboKit

// View that allows us to set object's width in mm, cm or meters
struct ObjectDimensionsView: View {
    @Environment(ControlPanelModel.self) private var controlPanelModel: ControlPanelModel

    var body: some View {
        @Bindable var controlPanelModel = controlPanelModel

        VStack(alignment: .leading) {
            Text("Dimensions")
                .font(.title3)

            Text("Set the dimensions for the object.")
                .foregroundStyle(.secondary)

            // Select mm, cm or meters
            RoboKit.ObjectWidthUnitPicker(objectWidthUnit: $controlPanelModel.objectWidthUnit)
                .frame(width: 350)
                .padding(.vertical)

            // Input the width of the object in the selected measurement unit
            HStack {
                Text("Width")
                RoboKit.ObjectWidthTextField(objectWidth: $controlPanelModel.objectWidth)
            }
        }
    }
}
