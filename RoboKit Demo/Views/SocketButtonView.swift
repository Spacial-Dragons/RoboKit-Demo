//
//  SocketView.swift
//  RoboKit Demo
//
//  Created by Sofia Diniz Melo Santos on 14/05/25.
//

import SwiftUI
import RealityKit
import RoboKit

struct SocketButtonView: View {

    @Environment(InputSphereManager.self) private var inputSphereManager: InputSphereManager
    let rootPoint: Entity

    public init(relativeToRootPoint rootPoint: Entity) {
        self.rootPoint = rootPoint
    }

    var client: TCPClient = TCPClient(host: "localhost", port: 12345)
    @State private var positionAndRotation: [Float] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    @State private var clawShouldOpen: Bool = false

    var body: some View {
        Button {
            sendData(shouldOpen: true)
        } label: {
            Text("Send data")
        }.onAppear {
            initializeServer()
            printInputSphereData()
        }.fontDesign(.rounded)
    }

    private func sendData(shouldOpen: Bool) {
        let messageData = CPRMessageModel(clawControl: shouldOpen, positionAndRotation: positionAndRotation)
        let encodedData = CodingManager.encodeToJSON(data: messageData)
        client.startConnection(value: encodedData)
    }

    /// A function that prints a position and orientation of the input sphere, if it was defined.
    private func printInputSphereData() {
        guard let position = inputSphereManager.getInputSpherePosition(relativeToRootPoint: rootPoint)
        else { print("Failed to get Input Sphere position"); return }
        print("Input Sphere position: \(position)")

        guard let rotation = inputSphereManager.getInputSphereRotation(relativeToRootPoint: rootPoint)
        else { print("Failed to get Input Sphere rotation"); return }
        print("Input Sphere rotation: \(rotation)")
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
