//
//  ContentView.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 9.07.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appConfig: AppConfiguration


    var body: some View {
        MainView()
            .environmentObject(appConfig)
    }

   
}

#Preview {
    ContentView()
       
}
