//
//  StoryViewModel.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 10.07.2024.
//

import SwiftUI
import Foundation

class CatalogStoriesViewModel: BaseStoriesViewModel {
    
    @MainActor
    override func loadStories() async {
        do {
            let fetchedStories = try await storyService.fetchStories()
            stories = applyFavorites(stories: fetchedStories)
            
        } catch {
            print("Error fetching stories: \(error)")
        }
    }
}
