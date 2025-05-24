//
//  SendDataButton.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 24.05.2025.
//

import SwiftUI
import RoboKit

public struct SendDataButtonView: View {
    @Environment(TCPClient.self) private var client: TCPClient
    @State private var isSendingData: Bool = false
    
    public init() {}
    
    public var body: some View {
        @Bindable var client = client
        
        SendDataButton(isSendingData: $isSendingData)
    }
}

public struct SendDataButton: View {
    @Binding private var isSendingData: Bool
    
    public init(isSendingData: Binding<Bool>) {
        self._isSendingData = isSendingData
    }
    
    public var body: some View {
        Button(action: {
            isSendingData.toggle()
        }) {
            HStack {
                if isSendingData {
                    Text("Stop")
                    .fontWeight(.semibold)
                } else {
                    Image(systemName: "sensor.tag.radiowaves.forward")
                    Text("Send Data")
                        .fontWeight(.semibold)
                }
            }
            .padding()
            .frame(width: 160)
        }
        .background(isSendingData ? Color.gray : Color.green)
        .cornerRadius(25)
        .buttonStyle(PlainButtonStyle())
    }
    
}
