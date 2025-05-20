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
    var client: TCPClient = TCPClient(host: "localhost", port: 12345)
    @State private var positionAndRotation: [Float] = [0,0,0,0,0,0,0,0,0]
    @State private var clawShouldOpen: Bool = false
    @State private var objectWidth: Float = 400
    @State private var objectWidthUnit: RoboKit.ObjectWidthUnit = .meters
    
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 20){
                
                ObjectDimensionsView(objectWidth: $objectWidth, objectWidthUnit: $objectWidthUnit)
                
                Divider()
                
                AccessoriesView(clawShouldOpen: $clawShouldOpen)
                
                RoboKit.DataModePicker()
                    .environment(client)
                    .frame(width: 250)
                
                Button {
                    sendData(shouldOpen: clawShouldOpen)
                } label: {
                    Text("Send data")
                }
            }
            .frame(width: 300)
            
            FormPositionView()
                .environment(formManager)
                .frame(width: 300)
        }
        .onAppear {
            initializeServer()
        }
    }
    
    private func convertObjectWidth() -> Float {
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
        let convertedObjectWidth: Float = convertObjectWidth()
        
        client.startConnection(value: CodingManager.encodeToJSON(
            data: CPRMessageModel(clawControl: shouldOpen,
                                  positionAndRotation: [0,0,0,0,0,0,0],
                                  objectWidth: convertedObjectWidth)))
    }
    
    private func initializeServer(){
        do {
            let server = try TCPServer(port: 12345)
            try! server.start(logMessage: "Started server")
        } catch {
            print("Couldn't initialize server")
        }
    }
}



