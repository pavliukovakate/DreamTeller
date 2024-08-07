//
//  AgeGroup.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 7.08.2024.
//

import Foundation

enum AgeGroup: String, CaseIterable, Codable {
    case all = "All"
    case zeroToTwo = "0-2"
    case threeToFive = "3-5"
    case sixToEight = "6-8"

}
extension AgeGroup: TitlePresentable {
    var title: String {
        return rawValue
    }
}
extension AgeGroup: Identifiable {
    var id: String { self.rawValue }
}
