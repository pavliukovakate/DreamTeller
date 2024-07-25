//
//  HomeViewModel.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 17.07.2024.
//

import Foundation
import SwiftUI
import Combine

@Observable
class HomeViewModel: ObservableObject {
    var recommendedStories: [Story] = []
    var newStories: [Story] = []
    var recentStories: [Story] = []
    var selectedStory: Story? = nil

    private var storyService: StoryService
    private var favoritesService: FavoritesService
    private var cancellables = Set<AnyCancellable>()

    init(storyService: StoryService, favoritesService: FavoritesService) {
        self.storyService = storyService
        self.favoritesService = favoritesService
        setupBindings()
        Task {
            await loadStories()
        }
    }
    
    private func setupBindings() {
        favoritesService.$favoriteStoryIDs
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateFavoriteStories()
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func loadStories() async {
        
        do {
            async let newStories = storyService.fetchNewStories()
            async let recommendedStories = storyService.fetchRecommendedStories()
            async let recentStories = storyService.fetchRecentStories()
            
            let (new, recommended, recent) = try await (newStories, recommendedStories, recentStories)
            
            self.newStories = applyFavorites(stories: new)
            self.recommendedStories = applyFavorites(stories: recommended)
            self.recentStories = applyFavorites(stories: recent)
        } catch {
            print("Error fetching stories: \(error)")
        }
    }

    private func applyFavorites(stories: [Story]) -> [Story] {
        return stories.map { story in
            var story = story
            story.isFavorite = favoritesService.isFavorite(story)
            return story
        }
    }

    func toggleFavorite(for story: Story) {
        favoritesService.toggleFavorite(story)
    }
    
    private func updateFavoriteStories() {
       newStories = applyFavorites(stories: newStories)
       recommendedStories = applyFavorites(stories: recommendedStories)
       recentStories = applyFavorites(stories: recentStories)
    }

    func selectStory(_ story: Story?) {
        selectedStory = story
    }
}
