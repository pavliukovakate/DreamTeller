//
//  StoryCell.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 15.07.2024.
//

import SwiftUI

struct StoryCell: View {
    let story: Story
    let toggleFavorite: () -> Void

    @EnvironmentObject var appConfig: AppConfiguration

    var body: some View {
        let currentColorSet = appConfig.colorStyle.colorSet

        VStack {
            ZStack(alignment: .topTrailing) {
                Image(story.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .cornerRadius(12)
                
                Button(action: toggleFavorite) {
                    Image(systemName: story.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(story.isFavorite ? .red : .gray)
                        .padding(8)
                }
            }
            Text(story.title)
                .font(.caption)
                .foregroundColor(currentColorSet.primaryText)
        }
    }
}

#Preview {
    StoryCell(story: MockStoryService().getRandomStory(), toggleFavorite: {} )
}
