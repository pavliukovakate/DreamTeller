//
//  Story.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 9.07.2024.
//

import Foundation

struct Story: Identifiable, Codable {
    let id: UUID
    let title: String
    let audio: String
    let imageName: String
    var isFavorite: Bool
    var ageGroup: AgeGroup
    var category: Category

    init(id: UUID = UUID(), title: String, audio: String, imageName: String, isFavorite: Bool, ageGroup: AgeGroup, category: Category) {
        self.id = id
        self.title = title
        self.audio = audio
        self.imageName = imageName
        self.isFavorite = isFavorite
        self.ageGroup = ageGroup
        self.category = category
    }
}

enum AgeGroup: String, CaseIterable, Identifiable, Codable {
    case all = "All"
    case zeroToTwo = "0-2"
    case threeToFive = "3-5"
    case sixToEight = "6-8"

    var id: String { self.rawValue }
}

enum Category: String, CaseIterable, Identifiable, Codable {
    case all = "All"
    case fantasy = "Fantasy"
    case adventure = "Adventure"
    case mystery = "Mystery"
    case science = "Science"
    case historical = "Historical"

    var id: String { self.rawValue }
}
