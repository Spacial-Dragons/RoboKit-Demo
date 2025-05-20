//
//  PrintInputSphereDataButton.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 08.05.2025.
//

import SwiftUI
import RealityKit
import RoboKit

// The button prints positional and rotational data of Input Sphere
// relative to the root point to the console
public struct PrintInputSphereDataButton: View {
    @Environment(InputSphereManager.self) private var inputSphereManager: InputSphereManager
    let rootPoint: Entity

    public init(relativeToRootPoint rootPoint: Entity) {
        self.rootPoint = rootPoint
    }

    public var body: some View {
        Button("Print Data") {
            printInputSphereData()
        }
    }
    
    private func printInputSphereData() {
        guard let position = inputSphereManager.getInputSpherePosition(relativeToRootPoint: rootPoint)
        else { print("Failed to get Input Sphere position"); return }
        print("Input Sphere position: \(position)")
        
        guard let rotation = inputSphereManager.getInputSphereRotation(relativeToRootPoint: rootPoint)
        else { print("Failed to get Input Sphere rotation"); return }
        print("Input Sphere rotation: \(rotation)")
    }
}
