//
//  DreamTellerApp.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 9.07.2024.
//

import SwiftUI
import Combine

@main
struct DreamTellerApp: App {
    @StateObject private var appConfig = AppConfiguration()

    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environmentObject(appConfig)
        }
    }
}


