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
        VStack() {
            VStack(alignment: .leading) {
                Text("Dimensions")
                    .font(.title3)
                Text("Set the dimensions for the object.")
            }

            VStack(alignment: .leading, spacing: -10) {
                RoboKit.ObjectWidthUnitPicker(objectWidthUnit: $objectWidthUnit)
                    .padding(.leading, 50)
                    .frame(width: 200)
                
                HStack(spacing: 10) {
                    Text("Width")
                    RoboKit.ObjectWidthTextField(objectWidth: $objectWidth)
                }
            }
            
        }
        .frame(width: 300)
//        .background()
    }
}
