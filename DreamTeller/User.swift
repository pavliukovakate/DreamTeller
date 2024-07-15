//
//  User.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 10.07.2024.
//

import Foundation

struct User: Identifiable {
    let id = UUID()
    var name: String
    var email: String
    var avatar: String // Имя изображения аватара пользователя
}

struct ListeningHistory: Identifiable {
    let id = UUID()
    var storyTitle: String
    var dateListened: Date
}

