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

    // Access the input sphere manager from the environment
    @Environment(InputSphereManager.self) private var inputSphereManager: InputSphereManager

    // Root point entity used for relative transformations
    let rootPoint: Entity

    public init(relativeToRootPoint rootPoint: Entity) {
        self.rootPoint = rootPoint
    }

    // TCP client used to send data
    var client: TCPClient = TCPClient(host: "localhost", port: 12345)

    // Stores position and rotation values
    @State private var positionAndRotation: [Float] = [0, 0, 0, 0, 0, 0, 0, 0, 0]

    // Indicates whether the robot claw should open
    @State private var clawShouldOpen: Bool = false

    var body: some View {
        // UI button that triggers sending data when tapped
        Button {
            sendData(shouldOpen: true)
        } label: {
            Text("Send data")
        }.fontDesign(.rounded)

        // Initialize the TCP server
        .onAppear {
            initializeServer()
        }
    }

    // Sends encoded position, rotation, and claw state data to the TCP client
    private func sendData(shouldOpen: Bool) {
        let messageData = CPRMessageModel(clawControl: shouldOpen, positionAndRotation: positionAndRotation)
        let encodedData = CodingManager.encodeToJSON(data: messageData)
        client.startConnection(value: encodedData)

        printInputSphereData()
    }

    /// A function that prints a position and orientation of the input sphere, if it was defined.
    private func printInputSphereData() {
        guard let position = inputSphereManager.getInputSpherePosition(relativeToRootPoint: rootPoint)
        else {
            print("Failed to get Input Sphere position"); return
        }
        print("Input Sphere position: \(position)")

        guard let rotation = inputSphereManager.getInputSphereRotation(relativeToRootPoint: rootPoint)
        else {
            print("Failed to get Input Sphere rotation"); return
        }
        print("Input Sphere rotation: \(rotation)")
    }

    // Initializes a TCP server and attempts to start it
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
