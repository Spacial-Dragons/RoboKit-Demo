//
//  PoseView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 20.05.2025.
//

import SwiftUI
import RoboKit

public struct PoseView: View {
    @Environment(TCPClient.self) private var client: TCPClient
    @Environment(InputSphereManager.self) private var inputSphereManager: InputSphereManager
    @Environment(FormManager.self) private var formManager: FormManager
    
    public var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Pose")
                    .font(.title3)
                Text("Set the position and rotation for the robot.")
            }
            
            RoboKit.DataModePicker()
                .environment(client)
                .padding(.leading, -15)
                .frame(width: 200)
            
            VStack(alignment: .leading, spacing: 20){
                PositionView()
                RotationView()
            }
        }
    }
}
