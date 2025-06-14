//
//  TabItem Enum.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 26.05.2025.
//

import SwiftUI
import RoboKit

// Tab Item used to define icon and title for the buttons used in the Control Panel Menu
enum TabItem: String, CaseIterable, Identifiable {
    case dimensions = "Dimensions"
    case pose = "Pose"
    case accessories = "Accessories"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .dimensions: return "cube.fill"
        case .pose: return "mappin.and.ellipse.circle.fill"
        case .accessories: return "circle.dotted.circle"
        }
    }
}
