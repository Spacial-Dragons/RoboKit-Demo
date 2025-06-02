//
//  SocketExpandedView.swift
//  RoboKit Demo
//
//  Created by Mariia Chemerys on 26.05.2025.
//

import SwiftUI
import RoboKit

#warning("")

extension SocketView {
    struct SocketExpandedView: View {
        @Environment(FormManager.self) private var formManager: FormManager
        @Environment(InputSphereManager.self) private var inputSphereManager: InputSphereManager
        @Environment(TCPClient.self) private var client: TCPClient

        @State private var clawShouldOpen: Bool = false
        @State private var objectWidth: Float = 120
        @State private var objectWidthUnit: RoboKit.ObjectWidthUnit = .centimeters

        @Binding var selectedTabs: Set<TabItem>

        init(selectedTabs: Binding<Set<TabItem>>) {
            self._selectedTabs = selectedTabs
        }

        var body: some View {
            VStack(alignment: .leading, spacing: 30) {
                if selectedTabs.contains(.dimensions) {
                    ObjectDimensionsView(objectWidth: $objectWidth, objectWidthUnit: $objectWidthUnit)
                    Divider()
                }

                if selectedTabs.contains(.pose) {
                    PoseView()
                    Divider()
                }

                if selectedTabs.contains(.accessories) {
                    AccessoriesView(clawShouldOpen: $clawShouldOpen)
                }
            }
            .padding(.bottom, 50)
            .padding(.all, 30)
        }
    }
}
