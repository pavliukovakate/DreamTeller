//
//  Category.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 7.08.2024.
//

import Foundation

enum Category: String, CaseIterable, Codable {
    case all = "All"
    case fantasy = "Fantasy"
    case adventure = "Adventure"
    case mystery = "Mystery"
    case science = "Science"
    case historical = "Historical"
}
    
extension Category: Identifiable {
    var id: String { rawValue }
}

extension Category: TitlePresentable {
    var title: String {
        return rawValue
    }
}
