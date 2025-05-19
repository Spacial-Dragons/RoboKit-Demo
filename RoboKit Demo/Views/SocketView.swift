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
    
    var client: TCPClient = TCPClient(host: "localhost", port: 12345)
    @State private var positionAndRotation: [Float] = [0,0,0,0,0,0,0,0,0]
    @State private var clawShouldOpen: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40){
            Text("Scan tracking images to test RoboKit")
            Button {
                sendData(shouldOpen: true)
            } label: {
                Text("Send data")
            }
            
            RoboKit.DataModeToggle()
                .environment(client)
                .frame(width: 300)
            
        }.onAppear{
            initializeServer()
        }
        
        
    }
    
    private func sendData(shouldOpen: Bool) {
        client.startConnection(value: CodingManager.encodeToJSON(data: CPRMessageModel(clawControl: shouldOpen, positionAndRotation: [0,0,0,0,0,0,0])))
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



