//
//  PositionView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 20.05.2025.
//

import SwiftUI
import RoboKit

public struct FormPositionView: View {
    @Environment(TCPClient.self) private var client: TCPClient
    @Environment(FormManager.self) private var formManager: FormManager
    
    public var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                Text("Position")
                    .font(.title3)
                Text("Set the position for the robot.")
            }
            
            VStack(alignment: .leading, spacing: -10) {
                RoboKit.DataModePicker()
                    .environment(client)
                    .padding(.leading, -15)
                    .frame(width: 200)
                
                VStack(spacing: -10) {
                    ForEach(FormAxis.allCases, id: \.self) { axis in
                        RoboKit.FormPositionTextField(formAxis: axis)
                            .frame(width: 220)
                    }
                }
            }
        }
    }
}
