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
    
    var body: some View {
        
        //ScrollView {
        
        VStack(alignment: .leading, spacing: 40) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Position")
                    .font(.title)
                Divider()
                RoboKit.InputSpherePositionView()
            }
            
            VStack(alignment: .leading, spacing: 10){
                Text("Rotation")
                    .font(.title)
                Divider()
                RoboKit.InputSphereRotationSlider(eulerAngle: .yaw)
            }
            
//            SocketView()
        }
        .padding(40)
        
        //}
        
        .fontDesign(.rounded)
    }
}
