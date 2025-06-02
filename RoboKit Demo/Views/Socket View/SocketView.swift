//
//  SocketView.swift
//  RoboKit Demo
//
//  Created by Sofia Diniz Melo Santos on 14/05/25.
//

import SwiftUI
import RoboKit

#warning("")

struct SocketView: View {

    @State private var selectedTabs: Set<TabItem> = Set(TabItem.allCases)
    @State private var windowSize: CGSize = .zero
    @State private var menuSize: CGSize = .zero
    @Binding private var socketCollapsed: Bool

    init(socketCollapsed: Binding<Bool>) {
        self._socketCollapsed = socketCollapsed
    }
    
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
        Group {
            if !socketCollapsed {
                SocketExpandedView(selectedTabs: $selectedTabs)
                    .glassBackgroundEffect(displayMode: selectedTabs.isEmpty ? .never : .always)
            }
        }
        .onGeometryChange(for: CGSize.self) { proxy in
             proxy.size
         } action: { size in
             withAnimation {
                 self.windowSize = size
             }
         }
        
        .onAppear {
            initializeServer()
        }
        
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
        
        .ornament(
            visibility: .visible,
            attachmentAnchor: .scene(.center),
            contentAlignment: .bottom
        ) {
            ZStack(alignment: .top){
                ExpandCollapseButton(socketCollapsed: $socketCollapsed)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .disabled(selectedTabs.isEmpty)
                    .animation(.spring, value: selectedTabs.isEmpty)
                
                #warning("")
                RoboKit.SendDataButton(
                    onSendLiveData: {
//                        sendData(shouldOpen: clawShouldOpen)
                    },
                    onSendSetData: {
//                        sendData(shouldOpen: clawShouldOpen)
                    }
                )
                .frame(maxHeight: .infinity, alignment: .top)
            }
            .frame(
                width: computedFrameSize.width,
                height: computedFrameSize.height
            )
        }
        
        .frame(width: socketCollapsed ? 100 : windowSize.width, height: socketCollapsed ? 100 : windowSize.height)
        .padding()
        .animation(.spring, value: computedFrameSize)
    }

    private func initializeServer() {
        do {
            let server = try TCPServer(port: 12345)
            try! server.start(logMessage: "Started server")
        } catch {
            print("Couldn't initialize server")
        }
    }
    
//    private func convertedObjectWidth() -> Float {
//        switch objectWidthUnit {
//        case .millimeters: return objectWidth / 1000
//        case .centimeters: return objectWidth / 100
//        case .meters: return objectWidth
//        }
//    }
//    
//    private func sendData(shouldOpen: Bool) {
//        let objectWidth = convertedObjectWidth()
//        let position: [Float]
//        let rotation: [Float]
//        
//        switch client.selectedDataMode {
//        case .live:
//            #warning("Hard coded data")
//            position = inputSphereManager.getInputSpherePosition()?.array ?? [0.0, 0.0, 0.3]
//            rotation = inputSphereManager.getInputSphereRotation()?.array ?? [1, 0, 0, 0, 1, 0, 0, 0, 1]
//        case .set:
//            position = formManager.getFormPosition().array
//            rotation = formManager.getFormRotation().array
//        }
//        
//        let positionAndRotation = position + rotation
//        
//        client.startConnection(value: CodingManager.encodeToJSON(
//            data: CPRMessageModel(clawControl: shouldOpen,
//                                  positionAndRotation: positionAndRotation,
//                                  objectWidth: objectWidth)))
//    }
}
