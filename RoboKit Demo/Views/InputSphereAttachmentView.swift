//
//  InputSphereAttachmentView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 03.05.2025.
//

import RoboKit
import SwiftUI
import RealityKit

struct InputSphereAttachmentView: View {
    @Environment(InputSphereManager.self) private var inputSphereManager: InputSphereManager
    
//    var positionText: String {
//        let inputSpherePosition = entityManager.inputSpherePosition
//        return entityManager.convertPositionAndRotationToStrings(position: inputSpherePosition, rotation: .init()).positionText
//    }
    
    var body: some View {
        
        //ScrollView {
        
        VStack(alignment: .leading, spacing: 40) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Position")
                    .font(.title)
                Divider()
//                Text(positionText)
            }
            
            VStack(alignment: .leading, spacing: 10){
                Text("Rotation")
                    .font(.title)
                Divider()
                
                //InputSphereRotationSlider(eulerAngle: .roll)
//                InputSphereRotationSlider(eulerAngle: .yaw)
                //InputSphereRotationSlider(eulerAngle: .pitch)
            }
            
//            SocketView()
        }
        .padding(40)
        
        //}
        
        .fontDesign(.rounded)
    }
}
