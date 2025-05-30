//
//  ObjectDimensionsView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 20.05.2025.
//

import SwiftUI
import RoboKit

struct ObjectDimensionsView: View {
    @Binding private var objectWidth: Float
    @Binding private var objectWidthUnit: RoboKit.ObjectWidthUnit
    
    init(objectWidth: Binding<Float>,
         objectWidthUnit: Binding<RoboKit.ObjectWidthUnit>) {
        self._objectWidth = objectWidth
        self._objectWidthUnit = objectWidthUnit
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Dimensions")
                .font(.title3)
            
            Text("Set the dimensions for the object.")

            RoboKit.ObjectWidthUnitPicker(objectWidthUnit: $objectWidthUnit)
            
            HStack {
                Text("Width")
                RoboKit.ObjectWidthTextField(objectWidth: $objectWidth)
            }
        }
    }
}
