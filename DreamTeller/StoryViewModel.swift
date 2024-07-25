//
//  StoryViewModel.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 10.07.2024.
//

import SwiftUI
import Foundation
import Combine

@Observable
class StoryViewModel: ObservableObject {
    var stories: [Story] = []
    var selectedAgeGroup: AgeGroup = .all
    var selectedCategory: Category = .all
    var showFilters = false
    var selectedStory: Story? = nil
    var searchText = ""

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
                self?.applyFavorites()
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func loadStories() async {
        do {
            let fetchedStories = try await storyService.fetchStories()
            stories = fetchedStories
            applyFavorites()
        } catch {
            print("Error fetching stories: \(error)")
        }
    }

    private func applyFavorites() {
        for i in 0..<stories.count {
            stories[i].isFavorite = favoritesService.isFavorite(stories[i])
        }
    }

    var filteredStories: [Story] {
        stories.filter { story in
            (selectedAgeGroup == .all || story.ageGroup == selectedAgeGroup) &&
            (selectedCategory == .all || story.category == selectedCategory) &&
            (searchText.isEmpty || story.title.localizedCaseInsensitiveContains(searchText))
        }
    }

    func selectAgeGroup(_ ageGroup: AgeGroup) {
        selectedAgeGroup = ageGroup
    }

    func selectCategory(_ category: Category) {
        selectedCategory = category
    }

    func toggleFavorite(for story: Story) {
        favoritesService.toggleFavorite(story)
    }

    func selectStory(_ story: Story) {
        selectedStory = story
    }
}
