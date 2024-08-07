//
//  StoryService.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 10.07.2024.
//

import Foundation
import Combine

protocol StoryService {
    func fetchStories() async throws -> [Story]
    func fetchNewStories() async throws -> [Story]
    func fetchRecommendedStories() async throws -> [Story]
    func fetchRecentStories() async throws -> [Story]
}

class MockStoryService: StoryService {
    let stories = [
        Story(id: UUID(uuidString: "620CA944-3DF4-4D76-9AAE-0377AF3E80D2")!,
              title: "Cinderella",
              audio: "The Adventures of Little Bruno in the Forest",
              imageName: "Image 1",
              isFavorite: false,
              ageGroup: .threeToFive,
              category: .fantasy),
        
        Story(id: UUID(uuidString: "BBCA36AE-3390-492B-ADFA-1F8A2EFCE652")!,
              title: "Little Red Riding Hood",
              audio: "The Adventures of Little Bruno in the Forest",
              imageName: "Image 2",
              isFavorite: false, ageGroup:
                .zeroToTwo,
              category: .fantasy),
        
        Story(id: UUID(uuidString: "FB07891E-2354-4F15-964F-906814F8411F")!,
              title: "Little Bruno",
              audio: "The Adventures of Little Bruno in the Forest",
              imageName: "Image 3",
              isFavorite: false,
              ageGroup: .zeroToTwo,
              category: .mystery),
        
        Story(id: UUID(uuidString: "C4C66FCE-BBAC-4A32-9089-CA97AA587578")!,
              title: "Small Prience",
              audio: "The Adventures of Little Bruno in the Forest",
              imageName: "Image 4",
              isFavorite: false,
              ageGroup: .threeToFive,
              category: .adventure),
        
        Story(id: UUID(uuidString: "6E255108-8351-4AAA-A7A3-DD5BE81337EA")!,
              title: "Cosmos",
              audio: "The Adventures of Little Bruno in the Forest",
              imageName: "Image 5",
              isFavorite: false,
              ageGroup: .sixToEight,
              category: .science)
    ]
    
    func fetchStories() async throws -> [Story] {
        return stories
    }
    
    func fetchNewStories() async throws -> [Story] {
        return stories
    }
    
    func fetchRecommendedStories() async throws -> [Story] {
        return stories
    }
    
    func fetchRecentStories() async throws -> [Story] {
        return stories
    }
    
    func getRandomStory() -> Story {
        stories.randomElement() ?? Story(title: "Little Bruno",
                                         audio: "The Adventures of Little Bruno in the Forest",
                                         imageName: "Image 3",
                                         isFavorite: true,
                                         ageGroup: .zeroToTwo,
                                         category: .mystery)
    }
}
