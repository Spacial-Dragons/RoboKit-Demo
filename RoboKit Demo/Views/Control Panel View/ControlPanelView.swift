//
//  ControlPanelView.swift
//  RoboKit Demo
//
//  Created by Sofia Diniz Melo Santos on 14/05/25.
//

import SwiftUI
import RoboKit

struct ControlPanelView: View {

    @Environment(InputSphereManager.self) private var inputSphereManager: InputSphereManager
    @Environment(FormManager.self) private var formManager: FormManager
    @Environment(\.accessibilityReduceMotion) var isReduceMotionEnabled

    // Initialize control panel model that stores the mutable properties of the Data that can be sent
    @State private var controlPanelModel = ControlPanelModel()

    // TCP client and server used to send data and receive data
    @State private var client: TCPClient?
    @State private var server: TCPServer?

    // Hash set containing currently selected (active) tabs
    @State private var selectedTabs: Set<TabItem> = Set(TabItem.allCases)

    // Dynamic variable that stores the Geometry Reader of the control panel window size
    @State private var windowSize: CGSize = .zero

    // Dynamic variable that stores the Geometry Reader of the menu attachment size
    @State private var menuSize: CGSize = .zero

    // Timer for the live mode transmission
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    // Bool to define if the data is being transmitted in the live mode
    @State private var isLiveSendingData: Bool = false

    // Dynamically calculate the frame size of the Top View attachment (ExpandButton and SendDataButton)
    private var topAttachmentFrameSize: CGSize {
        if selectedTabs.isEmpty {
            return CGSize(
                width: menuSize.width,
                height: menuSize.height / 2 + 10
            )
        }
        return CGSize(
            width: windowSize.width,
            height: windowSize.height == .zero ? menuSize.height / 2 + 10 : windowSize.height / 2 + 50
        )
    }

    var body: some View {
        @Bindable var controlPanelModel = controlPanelModel

        // Expanded Control Panel
        ExpandedControlPanelView(selectedTabs: $selectedTabs)
            .glassBackgroundEffect(displayMode: selectedTabs.isEmpty ? .never : .always)
            .onGeometryChange(for: CGSize.self) { proxy in
                proxy.size
            } action: { size in
                withAnimation(isReduceMotionEnabled ? nil : .spring()) {
                    self.windowSize = size
                }
            }
            .frame(
                width: windowSize.width,
                height: selectedTabs.isEmpty ? 0 : windowSize.height
            )
            .padding()

            // Menu Ornament (Bottom)
            .ornament(
                visibility: .visible,
                attachmentAnchor: .scene(.bottom),
                contentAlignment: .bottom
            ) {
                MenuView(selectedTabs: $selectedTabs)
                    .padding()
                    .padding(.horizontal)
                    .glassBackgroundEffect()
                    .onGeometryChange(for: CGSize.self) { proxy in
                        proxy.size
                    } action: { size in
                        self.menuSize = size
                    }
            }

            // Expand Button + Send Data Button Ornament (Top)
            .ornament(
                visibility: .visible,
                attachmentAnchor: .scene(.center),
                contentAlignment: .bottom
            ) {
                ZStack(alignment: .top) {
                    ExpandCollapseButton(
                        isCollapsed: selectedTabs.count < TabItem.allCases.count,
                        toggleAction: {
                            if selectedTabs.count < TabItem.allCases.count {
                                // Expand all
                                selectedTabs.formUnion(TabItem.allCases)
                            } else {
                                // Collapse all
                                selectedTabs.removeAll()
                            }
                        }
                    )
                    .glassBackgroundEffect()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

                    if !selectedTabs.isEmpty {
                        RoboKit.SendDataButton(
                            onSendLiveData: {
                                if isLiveSendingData {
                                    // Cancel connection
                                    timer.upstream.connect().cancel()
                                } else {
                                    // Start timer
                                    timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
                                }
                            },
                            onSendSetData: { Task { await sendData() } },
                            isSendingData: $isLiveSendingData,
                            selectedDataMode: $controlPanelModel.selectedDataMode
                        )
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                }
                .frame(
                    width: topAttachmentFrameSize.width,
                    height: topAttachmentFrameSize.height
                )
            }

            .animation(isReduceMotionEnabled ? nil : .spring(), value: topAttachmentFrameSize)
            .environment(controlPanelModel)

            // Initialize Server
            .task {
                await initializeClient()
                await initializeServer()
            }

            // Send data during live mode transmission
            .onReceive(timer) { _ in
                if isLiveSendingData {
                    Task {
                        await self.sendData()
                    }
                }
            }
    }

    // Function that initializes the local tcp client
    private func initializeClient() async {
        let client = await TCPClient(host: NetworkSettings.host, port: NetworkSettings.port)
        self.client = client
    }

    // Function that initializes the local server that can be used during the development.
    // You can turn off the local server in the NetworkSettings.swift
    private func initializeServer() async {
        guard NetworkSettings.shouldRunServer else { return }

        do {
            let server = try await TCPServer(port: NetworkSettings.port.rawValue)
            try await server.start(logMessage: "Started server")
            self.server = server
        } catch {
            print("Couldn't initialize server: \(error)")
        }
    }

    // Function to send the data to the server
    private func sendData() async {
        guard let client = client else {
            print("Client not found")
            return
        }

        // Transform the selected measurement unit to the meters
        func convertedObjectWidth() -> Float {
            switch controlPanelModel.objectWidthUnit {
            case .millimeters: return controlPanelModel.objectWidth / 1000
            case .centimeters: return controlPanelModel.objectWidth / 100
            case .meters: return controlPanelModel.objectWidth
            }
        }

        let objectWidth = convertedObjectWidth()
        let position: [Float]
        let rotation: [Float]

        // Start sending data based on the selected transmission mode
        switch controlPanelModel.selectedDataMode {
        case .live:
            position = inputSphereManager.getInputSpherePosition()?.array ?? [0.0, 0.0, 0.3]
            rotation = inputSphereManager.getInputSphereRotation()?.array ?? [1, 0, 0, 0, 1, 0, 0, 0, 1]
        case .set:
            position = formManager.getFormPosition().array
            rotation = formManager.getFormRotation().array
        }

        // Combine position and rotation to a 9-value array
        let positionAndRotation = position + rotation

        // Initialize connection from the client
        await client.startConnection(value: CodingManager.encodeToJSON(
            data: CPRMessageModel(clawControl: controlPanelModel.clawShouldOpen,
                                  positionAndRotation: positionAndRotation,
                                  objectWidth: objectWidth)))
    }
}
