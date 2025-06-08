//
//  CubeModelEntity.swift
//  RoboKit Demo
//
//  Created by Matt Novoselov on 04/06/25.
//

import RealityKit
import RealityKitContent

// Returns a loaded RealityKit branded cube entity
@MainActor
public func brandedCubeModelEntity() async -> Entity {
    let cubeScale: Float = 0.02

    if let brandedCube = try? await Entity(named: "BrandedCube", in: realityKitContentBundle) {
        brandedCube.transform.scale = .init(x: cubeScale, y: cubeScale, z: cubeScale)
        brandedCube.transform.rotation = .init(angle: .pi, axis: .init(x: 1, y: 0, z: 0))
        brandedCube.name = "Branded Cube"
        return brandedCube
    }
    return Entity()
}
