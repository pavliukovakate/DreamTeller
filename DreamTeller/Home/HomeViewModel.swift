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
class HomeViewModel: BaseStoriesViewModel {
    var recommendedStories: [Story] = []
    var newStories: [Story] = []
    var recentStories: [Story] = []
   
    @MainActor
    override func loadStories() async {
        
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
    
    override func updateApplyingFavorites() {
        newStories = applyFavorites(stories: newStories)
        recommendedStories = applyFavorites(stories: recommendedStories)
        recentStories = applyFavorites(stories: recentStories)
    }
}
