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
                        FormPositionTextField(formAxis: axis)
                            .frame(width: 220)
                    }
                }
            }
        }
    }
}

public struct FormPositionTextField: View {
    @Environment(FormManager.self) private var formManager: FormManager
    let formAxis: RoboKit.FormAxis
    
    public init(formAxis: FormAxis) {
        self.formAxis = formAxis
    }
    
    private var positionValue: Binding<Float> {
        Binding(
            get: {
                switch formAxis {
                case .lateral:
                    formManager.formPositionRelativeToRoot.x
                case .longitudinal:
                    formManager.formPositionRelativeToRoot.y
                case .vertical:
                    formManager.formPositionRelativeToRoot.z
                }
            },
            set: {
                switch formAxis {
                case .lateral:
                    formManager.formPositionRelativeToRoot.x = $0
                case .longitudinal:
                    formManager.formPositionRelativeToRoot.y = $0
                case .vertical:
                    formManager.formPositionRelativeToRoot.z = $0
                }
            }
        )
    }
    
    private var formAxisLabel: String {
        switch formAxis {
        case .lateral: return "X"
        case .longitudinal: return "Y"
        case .vertical: return "Z"
        }
    }
    
    public var body: some View {
        HStack {
            Text("\(formAxisLabel)")
            
            TextField("Position \(formAxisLabel)", value: positionValue, format: .number)
                .keyboardType(.numbersAndPunctuation)
                .font(.system(size: 20))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(.regularMaterial)
                        .padding(12)
                )
        }
    }
}
