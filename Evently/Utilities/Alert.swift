//
//  Alert.swift
//  Evently
//
//  Created by Cleo Howard on 1/17/22.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let invalidURL = AlertItem(title: Text("Server Error"),
                                     message: Text("There was an issue connecting to the server. /nPlease check the URL or your internet connection."),
                                     dismissButton: .default(Text("Ok")))
    
    static let invalidResponse = AlertItem(title: Text("Server Error"),
                                     message: Text("The response from the server returned an invalid response. /nIf this issue persists, contact support."),
                                     dismissButton: .default(Text("Ok")))
    
    static let invalidData = AlertItem(title: Text("Server Error"),
                                     message: Text("The data received from the server was invalid. /nIf this issue persists, contact support."),
                                     dismissButton: .default(Text("Ok")))
}
