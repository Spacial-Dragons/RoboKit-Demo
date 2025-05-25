//
//  SendSetDataButton.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 25.05.2025.
//

import SwiftUI

public struct SendSetDataButton: View {
    
    public var body: some View {
        Button(action: {
            
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
