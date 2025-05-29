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
    @Environment(InputSphereManager.self) private var inputSphereManager: InputSphereManager
    @Environment(TCPClient.self) private var client: TCPClient
    
    @State private var selectedTabs: Set<TabItem> = Set(TabItem.allCases)
    @State private var expandedHeight: CGFloat = 800
    
    @Binding private var socketCollapsed: Bool

    init(socketCollapsed: Binding<Bool>) {
        self._socketCollapsed = socketCollapsed
    }
    
    var body: some View {
        Group {
            if socketCollapsed {
                SocketCollapsedView(selectedTabs: $selectedTabs)
            } else {
                SocketExpandedView(selectedTabs: $selectedTabs, onHeightChange: { height in
                    expandedHeight = height
                })
            }
        }
        .onAppear {
            initializeServer()
        }
        .ornament(
            visibility: socketCollapsed ? .hidden : .visible,
            attachmentAnchor: .scene(.bottom),
            contentAlignment: .bottom
        ) {
            MenuView(selectedTabs: $selectedTabs)
                .environment(client)
        }
        .ornament(
            visibility: .visible,
            attachmentAnchor: .scene(.topLeading),
            contentAlignment: .topLeading
        ) {
            ExpandCollapseButton(socketCollapsed: $socketCollapsed)
        }
        .frame(width: 390,
               height: socketCollapsed ? 50 : expandedHeight)
    }

    private func initializeServer() {
        do {
            let server = try TCPServer(port: 12345)
            try! server.start(logMessage: "Started server")
        } catch {
            print("Couldn't initialize server")
        }
    }
}
