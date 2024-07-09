//
//  Item.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 9.07.2024.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
