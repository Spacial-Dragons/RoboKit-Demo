//
//  SendLiveDataButton.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 24.05.2025.
//

import SwiftUI
import RoboKit

#warning("")

public struct SendLiveDataButton: View {
    @State private var isSendingData: Bool = false
    private let onSendLiveData: () -> Void

    public init(
        onSendLiveData: @escaping () -> Void
    ) {
        self.onSendLiveData = onSendLiveData
    }

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

                SendLiveDataToggle(isSendingData: $isSendingData, onSendLiveData: onSendLiveData)
                    .frame(width: 150)
                    .padding(.trailing, 28)
            }
            .background(
                RoundedRectangle(cornerRadius: 25)
                    .foregroundStyle(.green.opacity(0.8))
                    .frame(width: 300)
            )
        } else {
            SendLiveDataToggle(isSendingData: $isSendingData, onSendLiveData: onSendLiveData)
        }
    }
}
