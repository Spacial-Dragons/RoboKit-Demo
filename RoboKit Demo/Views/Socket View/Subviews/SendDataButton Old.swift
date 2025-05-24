//
//  SendDataButton.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 24.05.2025.
//

import SwiftUI
import RoboKit

public struct SendDataButtonOld: View {
    @Environment(TCPClient.self) private var client: TCPClient

    public init() {}

    public var body: some View {
        @Bindable var client = client

        let options = DataMode.allCases.map { $0.rawValue }
        let selectedIndex = Binding<Int>(
            get: { DataMode.allCases.firstIndex(of: client.selectedDataMode) ?? 0 },
            set: { client.selectedDataMode = DataMode.allCases[$0] }
        )
        

//        SegmentedControlPicker(items: options, selectedIndex: selectedIndex)
//            .padding()
    }
    
    enum SendState: String, CaseIterable {
        case sendData = "Send Data"
        case sendingData = "Sending Data"
        case stop = "Stop"

        var symbol: String? {
            switch self {
            case .sendData:
                return "sensor.tag.radiowaves.forward"
            case .sendingData:
                return nil
            case .stop:
                return "sensor.tag.radiowaves.forward"
            }
        }
    }

}
