//
//  ProfileViewModel.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 7.08.2024.
//

import Foundation
import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var listeningHistory: [ListeningHistory]
    
    init() {
        self.user = User(name: "Иван Иванов", email: "ivan@example.com", avatar: "profile")
        self.listeningHistory = [
            ListeningHistory(storyTitle: "Золушка", dateListened: Date()),
            ListeningHistory(storyTitle: "Красная шапочка", dateListened: Date())
        ]
    }
    
    func logout() {
        // Логика выхода из аккаунта
    }
}
