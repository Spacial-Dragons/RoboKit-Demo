//
//  SocketView.swift
//  RoboKit Demo
//
//  Created by Sofia Diniz Melo Santos on 14/05/25.
//

import SwiftUI
import RealityKit
import RoboKit

#warning("")

struct SocketView: View {

    @State private var selectedTabs: Set<TabItem> = Set(TabItem.allCases)
    @State private var windowSize: CGSize = .zero
    @Binding private var socketCollapsed: Bool

    init(socketCollapsed: Binding<Bool>) {
        self._socketCollapsed = socketCollapsed
    }

    var body: some View {
        Group {
            if socketCollapsed {
                MenuView(selectedTabs: $selectedTabs)
            } else {
                SocketExpandedView(selectedTabs: $selectedTabs)
                    .onGeometryChange(for: CGSize.self) { proxy in
                         proxy.size
                     } action: { size in
                         withAnimation {
                             self.windowSize = size
                         }
                     }
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
                .padding()
                .padding(.horizontal)
                .glassBackgroundEffect()
        }
        .ornament(
            visibility: .visible,
            attachmentAnchor: .scene(.topLeading),
            contentAlignment: .topLeading
        ) {
            ExpandCollapseButton(socketCollapsed: $socketCollapsed)
        }
        .frame(width: socketCollapsed ? 600 : windowSize.width, height: socketCollapsed ? 100 : windowSize.height)
        .padding()
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
