//
//  SendLiveDataToggle.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 25.05.2025.
//

import SwiftUI

public struct SendLiveDataToggle: View {
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
                        .font(.subheadline)
                    Text("Send Data")
                        .fontWeight(.semibold)
                }
            }
            .padding(10)
            .frame(width: isSendingData ? 120 : 160)
        }
        .background(isSendingData ? Color.gray : Color.green.opacity(0.8))
        .cornerRadius(25)
        .buttonStyle(PlainButtonStyle())
    }
}
