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

    var body: some View {
        Group {
            if !socketCollapsed {
                SocketExpandedView(selectedTabs: $selectedTabs)
                    .glassBackgroundEffect()
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
            attachmentAnchor: .scene(.top),
            contentAlignment: socketCollapsed ? .top : .bottom
        ) {
            ZStack{
                ExpandCollapseButton(socketCollapsed: $socketCollapsed)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                SendDataButton(onSendLiveData: {}, onSendSetData: {})
            }
            .frame(width: windowSize.width == .zero ? menuSize.width : windowSize.width)
        }
        
        .frame(width: socketCollapsed ? 100 : windowSize.width, height: socketCollapsed ? 100 : windowSize.height)
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
