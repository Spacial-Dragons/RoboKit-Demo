//
//  ControlPanelModel.swift
//  RoboKit Demo
//
//  Created by Matt Novoselov on 02/06/25.
//

import SwiftUI
import RoboKit

// A Model that holds the properties of the transmission data that can be mutated using the Control Panel
@Observable
class ControlPanelModel {
    var selectedDataMode: DataMode = .live
    var clawShouldOpen: Bool = false
    var objectWidth: Float = 120
    var objectWidthUnit: RoboKit.ObjectWidthUnit = .centimeters
}
