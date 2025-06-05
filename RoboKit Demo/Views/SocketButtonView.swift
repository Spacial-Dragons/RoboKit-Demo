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

    // TCP client and server used to send data and receive data
    @State private var client: TCPClient?
    @State private var server: TCPServer?

    // Stores position and rotation values
    @State private var positionAndRotation: [Float] = [0, 0, 0, 0, 0, 0, 0, 0, 0]

    // Indicates whether the robot claw should open
    @State private var clawShouldOpen: Bool = false

    var body: some View {
        // UI button that triggers sending data when tapped
        Button {
            Task {
                await sendData(shouldOpen: true)
            }
        } label: {
            Text("Send data")
        }.fontDesign(.rounded)

        // Initialize the TCP server
        .task {
            await initializeClientAndServer()
        }
    }

    // Sends encoded position, rotation, and claw state data to the TCP client
    private func sendData(shouldOpen: Bool) async {
        guard let client = client else {
            print("Client not found")
            return
        }
        let messageData = CPRMessageModel(clawControl: shouldOpen, positionAndRotation: positionAndRotation)
        let encodedData = CodingManager.encodeToJSON(data: messageData)
        await client.startConnection(value: encodedData)

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
    private func initializeClientAndServer() async {
        do {
            let server = try await TCPServer(port: 12345)
            try await server.start(logMessage: "Server started")
            self.server = server
        } catch {
            print("Couldn't initialize server: \(error)")
        }
        let client = await TCPClient(host: "localhost", port: 12345)
        self.client = client
    }
}
