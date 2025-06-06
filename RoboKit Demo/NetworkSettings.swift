//
//  NetworkSettings.swift
//  RoboKit Demo
//
//  Created by Matt Novoselov on 03/06/25.
//

import Network

// Structure used to store common network settings
struct NetworkSettings {
    /// This IP address has to be altered each time the application is run,
    /// since it should be the IP address of the current server
    static let host: NWEndpoint.Host = "192.168.2.21"
    static let port: NWEndpoint.Port = 12348
    /// Change this variable to 'false' whenever testing with an external server
    static let shouldRunServer: Bool = false
}
