//
//  ControlPanelModel.swift
//  RoboKit Demo
//
//  Created by Matt Novoselov on 02/06/25.
//

import SwiftUI
import RoboKit

@Observable
class ControlPanelModel {
    var clawShouldOpen: Bool = false
    var objectWidth: Float = 120
    var objectWidthUnit: RoboKit.ObjectWidthUnit = .centimeters
}
