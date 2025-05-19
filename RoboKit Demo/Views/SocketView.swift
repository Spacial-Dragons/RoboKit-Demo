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
    @State private var positionAndRotation: [Float] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    @State private var clawShouldOpen: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            Text("Scan tracking images to test RoboKit")
            Button {
                sendData(shouldOpen: true)
            } label: {
                Text("Send data")
            }

        }.onAppear {
            initializeServer()
        }

    }

    private func sendData(shouldOpen: Bool) {
        let messageData = CPRMessageModel(clawControl: shouldOpen, positionAndRotation: [0, 0, 0, 0, 0, 0, 0])
        let encodedData = CodingManager.encodeToJSON(data: messageData)
        client.startConnection(value: encodedData)
    }

    private func initializeServer() {
        do {
            let server = try TCPServer(port: 12345)
            do {
                try server.start(logMessage: "Started server")
            } catch {
                print("Failed to start server: \(error)")
            }
        } catch {
            print("Couldn't initialize server: \(error)")
        }
    }
}
