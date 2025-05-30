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
        @State private var objectWidth: Float = 400
        @State private var objectWidthUnit: RoboKit.ObjectWidthUnit = .meters

        @Binding var selectedTabs: Set<TabItem>
        var onHeightChange: (CGFloat) -> Void

        init(selectedTabs: Binding<Set<TabItem>>, onHeightChange: @escaping (CGFloat) -> Void) {
            self._selectedTabs = selectedTabs
            self.onHeightChange = onHeightChange
        }

        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    if selectedTabs.contains(.dimensions) {
                        ObjectDimensionsView(objectWidth: $objectWidth, objectWidthUnit: $objectWidthUnit)
                            .padding(.leading, 30)
                        Divider()
                    }

                    if selectedTabs.contains(.pose) {
                        PoseView()
                            .padding(.leading, 30)
                        Divider()
                    }

                    if selectedTabs.contains(.accessories) {
                        AccessoriesView(clawShouldOpen: $clawShouldOpen)
                            .padding(.leading, 30)
                        Divider()
                    }
                }
                .padding(.top, 50)
                .background(
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                onHeightChange(geometry.size.height + 150)
                            }
                            .onChange(of: geometry.size.height) {
                                onHeightChange(geometry.size.height + 150)
                            }
                    }
                )

                SendDataButton(
                    onSendLiveData: {
                        sendData(shouldOpen: clawShouldOpen)
                    },
                    onSendSetData: {
                        sendData(shouldOpen: clawShouldOpen)
                    }
                )
                .padding(.top, 10)
                .padding(.bottom, client.selectedDataMode == .live ? 0 : 93)
            }
        }

        private func convertedObjectWidth() -> Float {
            switch objectWidthUnit {
            case .millimeters: return objectWidth / 1000
            case .centimeters: return objectWidth / 100
            case .meters: return objectWidth
            }
        }

        private func sendData(shouldOpen: Bool) {
            let objectWidth = convertedObjectWidth()
            let position: [Float]
            let rotation: [Float]

            switch client.selectedDataMode {
            case .live:
                position = inputSphereManager.getInputSpherePosition()?.array ?? [0.0, 0.0, 0.3]
                rotation = inputSphereManager.getInputSphereRotation()?.array ?? [1, 0, 0, 0, 1, 0, 0, 0, 1]
            case .set:
                position = formManager.getFormPosition().array
                rotation = formManager.getFormRotation().array
            }

            let positionAndRotation = position + rotation

            client.startConnection(value: CodingManager.encodeToJSON(
                data: CPRMessageModel(clawControl: shouldOpen,
                                      positionAndRotation: positionAndRotation,
                                      objectWidth: objectWidth)))
        }
    }
}
