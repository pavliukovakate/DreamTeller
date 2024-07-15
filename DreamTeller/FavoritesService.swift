//
//  FavoritesService.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 10.07.2024.
//

import Foundation
import Combine

class FavoritesService {
    private let favoritesKey = "favorites"

    func saveFavoriteStories(_ stories: [UUID]) {
        let data = try? JSONEncoder().encode(stories)
        UserDefaults.standard.set(data, forKey: favoritesKey)
    }

    func loadFavoriteStories() -> [UUID] {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey),
              let favorites = try? JSONDecoder().decode([UUID].self, from: data) else {
            return []
        }
        return favorites
    }
}
