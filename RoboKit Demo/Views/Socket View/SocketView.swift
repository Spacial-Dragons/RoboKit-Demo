//
//  SocketView.swift
//  RoboKit Demo
//
//  Created by Sofia Diniz Melo Santos on 14/05/25.
//

import SwiftUI
import RealityKit
import RoboKit

struct SocketView: View {
    
    @Environment(FormManager.self) private var formManager: FormManager
    @Environment(InputSphereManager.self) private var inputSphereManager: InputSphereManager
    var client: TCPClient = TCPClient(host: "localhost", port: 12345)
    
    @State private var clawShouldOpen: Bool = false
    @State private var objectWidth: Float = 400
    @State private var objectWidthUnit: RoboKit.ObjectWidthUnit = .meters
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20){
                
                ObjectDimensionsView(objectWidth: $objectWidth, objectWidthUnit: $objectWidthUnit)
                    .padding(.leading, 30)
                
                Divider()
                
                PoseView()
                    .environment(client)
                    .environment(inputSphereManager)
                    .environment(formManager)
                    .padding(.leading, 30)
                
                Divider()
                
                AccessoriesView(clawShouldOpen: $clawShouldOpen)
                    .padding(.leading, 30)
                
            }
            .padding(.top, 50)
        }
        .onAppear {
            initializeServer()
        }
    }
    
    private func convertedObjectWidth() -> Float {
        switch objectWidthUnit {
        case .millimeters:
            return objectWidth / 1000
        case .centimeters:
            return objectWidth / 100
        case .meters:
            return objectWidth
        }
    }
    
    private func sendData(shouldOpen: Bool) {
        let objectWidth: Float = convertedObjectWidth()
        let position: [Float]
        let rotation: [Float]
        let positionAndRotation: [Float]
        
        switch client.selectedDataMode {
        case .live:
            position = inputSphereManager.getInputSpherePosition()?.array ?? [0.0, 0.0, 0.3]
            rotation = inputSphereManager.getInputSphereRotation()?.array ?? [1, 0, 0, 0, 1, 0, 0, 0, 1]
        case .set:
            position = formManager.getFormPosition().array
            rotation = formManager.getFormRotation().array
        }
        
        positionAndRotation = position + rotation
        
        client.startConnection(value: CodingManager.encodeToJSON(
            data: CPRMessageModel(clawControl: shouldOpen,
                                  positionAndRotation: positionAndRotation,
                                  objectWidth: objectWidth)))
    }
    
    private func initializeServer() {
        do {
            let server = try TCPServer(port: 12345)
            try! server.start(logMessage: "Started server")
        } catch {
            print("Couldn't initialize server")
        }
    }
}



