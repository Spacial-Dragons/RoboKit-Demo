//
//  SendDataButton.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 25.05.2025.
//

import SwiftUI
import RoboKit

#warning("")

public struct SendDataButton: View {
    @Environment(TCPClient.self) private var client: TCPClient
    @State private var isSendingData: Bool = false

    private let onSendLiveData: () -> Void
    private let onSendSetData: () -> Void

    public init(
        onSendLiveData: @escaping () -> Void,
        onSendSetData: @escaping () -> Void
    ) {
        self.onSendLiveData = onSendLiveData
        self.onSendSetData = onSendSetData
    }

    public var body: some View {
        @Bindable var client = client

        switch client.selectedDataMode {
        case .live:
            SendLiveDataButton(onSendLiveData: onSendLiveData)
        case .set:
            SendSetDataButton(onSendSetData: onSendSetData)
        }
    }
}
