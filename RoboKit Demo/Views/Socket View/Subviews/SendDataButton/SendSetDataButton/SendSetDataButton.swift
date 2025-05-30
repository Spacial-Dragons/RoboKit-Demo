//
//  SendSetDataButton.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 25.05.2025.
//

import SwiftUI

public struct SendSetDataButton: View {
    private let onSendSetData: () -> Void

    public init(
        onSendSetData: @escaping () -> Void
    ) {
        self.onSendSetData = onSendSetData
    }
    
    public var body: some View {
        Button(action: {
            onSendSetData()
        }) {
            HStack {
                Image(systemName: "sensor.tag.radiowaves.forward")
                    .font(.subheadline)
                Text("Send Data")
                    .fontWeight(.semibold)
            }
            .padding(10)
            .frame(width: 160)
        }
        .background(Color.green.opacity(0.8))
        .cornerRadius(25)
        .buttonStyle(PlainButtonStyle())
    }
}
