//
//  StoryService.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 10.07.2024.
//

import Foundation
import Combine

protocol StoryService {
    func fetchStories() -> AnyPublisher<[Story], Error>
}

class MockStoryService: StoryService {
    func fetchStories() -> AnyPublisher<[Story], Error> {
        let stories = [
            Story(title: "Cinderella",
                  audio: "The Adventures of Little Bruno in the Forest",
                  imageName: "Image 1",
                  isFavorite: true,
                  ageGroup: .threeToFive,
                  category: .fantasy),
            
            Story(title: "Little Red Riding Hood",
                  audio: "The Adventures of Little Bruno in the Forest",
                  imageName: "Image 2",
                  isFavorite: false, ageGroup:
                    .zeroToTwo,
                  category: .fantasy),
            
            Story(title: "Little Bruno",
                  audio: "The Adventures of Little Bruno in the Forest",
                  imageName: "Image 3",
                  isFavorite: true,
                  ageGroup: .zeroToTwo,
                  category: .mystery),
            
            Story(title: "Small Prience",
                  audio: "The Adventures of Little Bruno in the Forest",
                  imageName: "Image 4",
                  isFavorite: true,
                  ageGroup: .threeToFive,
                  category: .adventure),
            
            Story(title: "Cosmos",
                  audio: "The Adventures of Little Bruno in the Forest",
                  imageName: "Image 5",
                  isFavorite: false,
                  ageGroup: .sixToEight,
                  category: .science)
        ]
        return Just(stories)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
