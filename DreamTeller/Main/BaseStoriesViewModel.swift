//
//  BaseStoriesViewModel.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 7.08.2024.
//

import Foundation
import Combine
import SwiftUI

protocol StoriesPresentable: StoryFilterable, StorySearchable, StoryFavorable {
    var stories: [Story] { get }
    var selectedStory: Story? { get }
}

protocol StorySearchable {
    var searchText: String { get }
}

protocol StoryFilterable {
    var selectedAgeGroup: AgeGroup { get }
    var selectedCategory: Category { get }
    var showFilters: Bool { get }
    var filteredStories: [Story]  { get }
}

protocol StoryFavorable {
    func toggleFavorite(for story: Story)
}

@Observable
class BaseStoriesViewModel: ObservableObject, StoriesPresentable {
    var stories: [Story] = []
    var selectedAgeGroup: AgeGroup = .all
    var selectedCategory: Category = .all
    var showFilters = false
    var selectedStory: Story? = nil
    var searchText = ""

    private(set) var storyService: StoryService
    private(set) var favoritesService: FavoritesService
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
                guard let self = self else { return }
                self.updateApplyingFavorites()
            }
            .store(in: &cancellables)
    }
    
    @MainActor
    func loadStories() async {}
    func updateApplyingFavorites() {
        stories = applyFavorites(stories: stories)
    }

    func applyFavorites(stories: [Story]) -> [Story] {
        return stories.map { story in
            var story = story
            story.isFavorite = favoritesService.isFavorite(story)
            return story
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
