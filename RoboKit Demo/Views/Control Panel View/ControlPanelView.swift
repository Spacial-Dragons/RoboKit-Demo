//
//  ControlPanelView.swift
//  RoboKit Demo
//
//  Created by Sofia Diniz Melo Santos on 14/05/25.
//

import SwiftUI
import RoboKit

struct ControlPanelView: View {

    @Environment(TCPClient.self) private var client: TCPClient
    @Environment(InputSphereManager.self) private var inputSphereManager: InputSphereManager
    @Environment(FormManager.self) private var formManager: FormManager

    // Initialize control panel model that stores the mutable properties of the Data that can be sent
    @State private var controlPanelModel = ControlPanelModel()

    // Hash set containing currently selected (active) tabs
    @State private var selectedTabs: Set<TabItem> = Set(TabItem.allCases)

    // Dynamic variable that stores the Geometry Reader of the control panel window size
    @State private var windowSize: CGSize = .zero

    // Dynamic variable that stores the Geometry Reader of the menu attachment size
    @State private var menuSize: CGSize = .zero

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

        // Expanded Control Panel
        ExpandedControlPanelView(selectedTabs: $selectedTabs)
            .glassBackgroundEffect(displayMode: selectedTabs.isEmpty ? .never : .always)
            .onGeometryChange(for: CGSize.self) { proxy in
                proxy.size
            } action: { size in
                withAnimation {
                    self.windowSize = size
                }
            }
            .frame(
                width: selectedTabs.isEmpty ? 100 : menuSize.width,
                height: selectedTabs.isEmpty ? 100 : windowSize.height
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
                            onSendLiveData: { sendData() },
                            onSendSetData: { sendData() }
                        )
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                }
                .frame(
                    width: topAttachmentFrameSize.width,
                    height: topAttachmentFrameSize.height
                )
            }

            .animation(.spring, value: topAttachmentFrameSize)
            .environment(controlPanelModel)

            // Initialize Server
            .onAppear {
                initializeServer()
            }
    }

    // Function that initializes the local server that can be used during the development.
    // You can turn off the local server in the NetworkSettings.swift
    private func initializeServer() {
        guard NetworkSettings.shouldRunServer else { return }

        do {
            let server = try TCPServer(port: NetworkSettings.port.rawValue)
            try server.start(logMessage: "Started server")
        } catch {
            print("Couldn't initialize server: \(error)")
        }
    }

    // Function to send the data to the server
    private func sendData() {
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
        switch client.selectedDataMode {
        case .live:
            #warning("Hard coded data, implement Live Mode")
            position = inputSphereManager.getInputSpherePosition()?.array ?? [0.0, 0.0, 0.3]
            rotation = inputSphereManager.getInputSphereRotation()?.array ?? [1, 0, 0, 0, 1, 0, 0, 0, 1]
        case .set:
            position = formManager.getFormPosition().array
            rotation = formManager.getFormRotation().array
        }

        // Combine position and rotation to a 9-value array
        let positionAndRotation = position + rotation

        // Initialize connection from the client
        client.startConnection(value: CodingManager.encodeToJSON(
            data: CPRMessageModel(clawControl: controlPanelModel.clawShouldOpen,
                                  positionAndRotation: positionAndRotation,
                                  objectWidth: objectWidth)))
    }
}
