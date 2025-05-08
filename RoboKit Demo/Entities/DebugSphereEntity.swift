import SwiftUI
import RealityKit

// Function to generate RealityKit sphere Entity with certain parameters
func sphereEntity(color: Color = .red, ofSize size: Float = 0.01) -> Entity {
    let entity = Entity()
    let simpleMaterial = SimpleMaterial(
        color: UIColor(color), isMetallic: true
    )
    let model = ModelComponent(
        mesh: .generateSphere(radius: size),
        materials: [simpleMaterial]
    )
    entity.components.set(model)
    return entity
}
