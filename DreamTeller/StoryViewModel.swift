//
//  StoryViewModel.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 10.07.2024.
//

import SwiftUI
import Combine

class StoryViewModel: ObservableObject {
    @Published var stories: [Story] = []
    @Published var selectedAgeGroup: AgeGroup = .all
    @Published var selectedCategory: Category = .all
    @Published var showFilters = false
    @State var searchText = ""

    private var cancellables = Set<AnyCancellable>()
    private var storyService: StoryService
    private let favoritesService = FavoritesService()
    private var favoriteStoryIDs: [UUID] = []

    init(storyService: StoryService) {
        self.storyService = storyService
        loadStories()
        loadFavoriteStories()
    }

    func loadStories() {
        storyService.fetchStories()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching stories: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] stories in
                self?.stories = stories
                self?.applyFavorites()
            })
            .store(in: &cancellables)
    }

    func loadFavoriteStories() {
        favoriteStoryIDs = favoritesService.loadFavoriteStories()
    }

    func applyFavorites() {
        for i in 0..<stories.count {
            stories[i].isFavorite = favoriteStoryIDs.contains(stories[i].id)
        }
    }

    var filteredStories: [Story] {
        stories.filter { story in
            (selectedAgeGroup == .all || story.ageGroup == selectedAgeGroup) &&
            (selectedCategory == .all || story.category == selectedCategory)
        }
    }

    func selectAgeGroup(_ ageGroup: AgeGroup) {
        selectedAgeGroup = ageGroup
    }

    func selectCategory(_ category: Category) {
        selectedCategory = category
    }

    func toggleFavorite(for story: Story) {
        if let index = stories.firstIndex(where: { $0.id == story.id }) {
            stories[index].isFavorite.toggle()
            if stories[index].isFavorite {
                favoriteStoryIDs.append(stories[index].id)
            } else {
                favoriteStoryIDs.removeAll { $0 == stories[index].id }
            }
            favoritesService.saveFavoriteStories(favoriteStoryIDs)
        }
    }
}
