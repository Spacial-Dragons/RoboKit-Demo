//
//  SendDataButton.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 25.05.2025.
//

import SwiftUI
import RoboKit

public struct SendDataButton: View {
    @Environment(TCPClient.self) private var client: TCPClient
    @State private var isSendingData: Bool = false
    
    public init() {}
    
    public var body: some View {
        @Bindable var client = client
        
        switch client.selectedDataMode {
        case .live:
            SendLiveDataButton()
        case .set:
            SendSetDataButton()
        }
    }
}

