//
//  SendLiveDataButton.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 24.05.2025.
//

import SwiftUI
import RoboKit

public struct SendLiveDataButton: View {
    @State private var isSendingData: Bool = false
    
    public init() {}
    
    public var body: some View {
        if isSendingData {
            HStack {
                HStack {
                    Image(systemName: "sensor.tag.radiowaves.forward")
                        .font(.subheadline)
                    Text("Sending Data")
                        .fontWeight(.semibold)
                }
                .frame(width: 150)
                .padding(.leading, 50)
                
                SendLiveDataToggle(isSendingData: $isSendingData)
                    .frame(width: 150)
                    .padding(.trailing, 28)
            }
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(.green)
                    .frame(width: 300)
            )
        } else {
            SendLiveDataToggle(isSendingData: $isSendingData)
        }
    }
}
