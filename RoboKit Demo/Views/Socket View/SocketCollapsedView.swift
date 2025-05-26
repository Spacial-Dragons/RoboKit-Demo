//
//  SocketCollapsedView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 26.05.2025.
//

import SwiftUI
import RoboKit

extension SocketView {
    struct SocketCollapsedView: View {
        @Environment(InputSphereManager.self) private var inputSphereManager: InputSphereManager
        @Environment(FormManager.self) private var formManager: FormManager
        @Environment(TCPClient.self) private var client: TCPClient
        
        var body: some View {
            HStack {
                TabsView()
                    .labelStyle(.iconOnly)
                
                Divider()
                
                VStack(alignment: .leading) {
                    switch client.selectedDataMode {
                    case .live:
                        ForEach(Axis.allCases, id: \.self) { axis in
                            RoboKit.InputSpherePositionText(axis: axis)
                        }
                    case .set:
                        ForEach(Axis.allCases, id: \.self) { axis in
                            RoboKit.FormPositionText(axis: axis)
                        }
                    }
                }
                
                Divider()
                
                DataModeIndicator(dataMode: client.selectedDataMode)
            }
        }
    }
}
