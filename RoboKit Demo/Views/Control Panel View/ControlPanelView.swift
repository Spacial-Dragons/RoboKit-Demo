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
    
    @State private var controlPanelModel = ControlPanelModel()
    @State private var selectedTabs: Set<TabItem> = Set(TabItem.allCases)
    @State private var windowSize: CGSize = .zero
    @State private var menuSize: CGSize = .zero
    @State private var panelCollapsed: Bool = true
    
    private var computedFrameSize: CGSize {
        if selectedTabs.isEmpty {
            return CGSize(
                width: menuSize.width,
                height: menuSize.height / 2 + 10
            )
        }
        return CGSize(
            width: windowSize.width == .zero ? menuSize.width : windowSize.width,
            height: windowSize.height == .zero ? menuSize.height / 2 + 10 : windowSize.height / 2 + 50
        )
    }
    
    var body: some View {
        
        // Expanded Control Panel
        Group {
            if !panelCollapsed {
                ExpandedControlPanelView(selectedTabs: $selectedTabs)
                    .glassBackgroundEffect(displayMode: selectedTabs.isEmpty ? .never : .always)
            }
        }
        .onGeometryChange(for: CGSize.self) { proxy in
            proxy.size
        } action: { size in
            withAnimation{
                self.windowSize = size
            }
        }
        .frame(width: panelCollapsed ? 100 : windowSize.width, height: panelCollapsed ? 100 : windowSize.height)
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
                ExpandCollapseButton(panelCollapsed: $panelCollapsed)
                    .disabled(selectedTabs.isEmpty)
                    .glassBackgroundEffect()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                
                RoboKit.SendDataButton(
                    onSendLiveData: { sendData() },
                    onSendSetData: { sendData() }
                )
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .frame(
                width: computedFrameSize.width,
                height: computedFrameSize.height
            )
        }
        
        .animation(.spring, value: computedFrameSize)
        .environment(controlPanelModel)
        
        // Initialize Server
        .onAppear {
            initializeServer()
        }
    }
    
    private func initializeServer() {
        do {
            let server = try TCPServer(port: 12345)
            try! server.start(logMessage: "Started server")
        } catch {
            print("Couldn't initialize server")
        }
    }
    
    private func sendData() {
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
        
        switch client.selectedDataMode {
        case .live:
            #warning("Hard coded data, implement Live Mode")
            position = inputSphereManager.getInputSpherePosition()?.array ?? [0.0, 0.0, 0.3]
            rotation = inputSphereManager.getInputSphereRotation()?.array ?? [1, 0, 0, 0, 1, 0, 0, 0, 1]
        case .set:
            position = formManager.getFormPosition().array
            rotation = formManager.getFormRotation().array
        }
        
        let positionAndRotation = position + rotation
        
        client.startConnection(value: CodingManager.encodeToJSON(
            data: CPRMessageModel(clawControl: controlPanelModel.clawShouldOpen,
                                  positionAndRotation: positionAndRotation,
                                  objectWidth: objectWidth)))
    }
}
