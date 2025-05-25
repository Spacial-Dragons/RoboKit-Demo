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
                Text("Send Data")
                    .fontWeight(.semibold)
            }
            .padding()
            .frame(width: 160)
        }
        .background(Color.green)
        .cornerRadius(25)
        .buttonStyle(PlainButtonStyle())
    }
}
