//
//  Container.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 24.07.2024.
//

import Foundation
import Swinject

let container: Container = {
    let container = Container()
    
    container.register(FavoritesService.self) { _ in
        FavoritesService()
    }
    .inObjectScope(.container)
    
    container.register(StoryService.self) { _ in
        MockStoryService()
    }
    
    container.register(StoryViewModel.self) { resolver in
        let storyService = resolver.resolve(StoryService.self)!
        let favoritesService = resolver.resolve(FavoritesService.self)!
        return StoryViewModel(storyService: storyService, favoritesService: favoritesService)
    }
    
    container.register(HomeViewModel.self) { resolver in
        let storyService = resolver.resolve(StoryService.self)!
        let favoritesService = resolver.resolve(FavoritesService.self)!
        return HomeViewModel(storyService: storyService, favoritesService: favoritesService)
    }
    
    return container
}()
