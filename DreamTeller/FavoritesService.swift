//
//  FavoritesService.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 10.07.2024.
//

import Foundation

class FavoritesService: ObservableObject {
    @Published private(set) var favoriteStoryIDs: Set<UUID> = Set() {
        didSet {
            saveFavoriteStories()
            print("Favorites:\(favoriteStoryIDs)")
        }
    }
    
    private let favoritesKey = "favoriteStories"
    
    init() {
        loadFavoriteStories()
    }
    
    func addToFavorites(_ story: Story) {
        favoriteStoryIDs.insert(story.id)
    }
    
    func removeFromFavorites(_ story: Story) {
        favoriteStoryIDs.remove(story.id)
    }
    
    func isFavorite(_ story: Story) -> Bool {
        return favoriteStoryIDs.contains(story.id)
    }
    
    func toggleFavorite(_ story: Story) {
        isFavorite(story) ? removeFromFavorites(story) : addToFavorites(story)
    }
    
    private func saveFavoriteStories() {
        let ids = favoriteStoryIDs.map { $0.uuidString }
        UserDefaults.standard.set(ids, forKey: favoritesKey)
    }
    
    private func loadFavoriteStories() {
        if let savedIDs = UserDefaults.standard.stringArray(forKey: favoritesKey) {
            favoriteStoryIDs = Set(savedIDs.compactMap { UUID(uuidString: $0) })
        }
    }
}
