//
//  StoryListView.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 15.07.2024.
//

import SwiftUI
//
//struct StoryListView: View {
//    var ageGroup: AgeGroup?
//    var category: Category?
//    @EnvironmentObject var appConfig: AppConfiguration
//    @StateObject private var viewModel = StoryViewModel(storyService: MockStoryService())
//
//    var body: some View {
//        let currentColorSet = appConfig.colorStyle.colorSet
//        let columns = [GridItem(.flexible()), GridItem(.flexible())]
//
//        ScrollView {
//            LazyVGrid(columns: columns, spacing: 20) {
//                ForEach(viewModel.filteredStories) { story in
//                    StoryCell(story: story, viewModel: viewModel)
//                        .environmentObject(appConfig)
//                    .onTapGesture {
//                        viewModel.selectStory(story)
//                    }
//                }
//            }
//            .padding()
//        }
//        .navigationTitle(category?.rawValue ?? ageGroup?.rawValue ?? "Stories")
//        .onAppear {
//            if let ageGroup = ageGroup {
//                viewModel.selectAgeGroup(ageGroup)
//            } else if let category = category {
//                viewModel.selectCategory(category)
//            }
//        }
//        //.background(currentColorSet.backgroundColor.ignoresSafeArea())
//        .navigationBarTitleDisplayMode(.inline)
//    }
//}
//
//
//#Preview {
//    StoryListView()
//}
