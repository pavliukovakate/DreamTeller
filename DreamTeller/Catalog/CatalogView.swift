//
//  CatalogView.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 10.07.2024.
//

import SwiftUI

struct CatalogView: View {
    @EnvironmentObject var appConfig: AppConfiguration
    @StateObject private var viewModel: CatalogStoriesViewModel
    
    init() {
        let viewModel = container.resolve(CatalogStoriesViewModel.self)!
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        let currentColorSet = appConfig.colorStyle.colorSet
        let columns = [
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
        
        NavigationStack {
            VStack(spacing: 12) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(AgeGroup.allCases) { ageGroup in
                            Button(action: {
                                viewModel.selectAgeGroup(ageGroup)
                            }) {
                                FilterItemView(item: ageGroup)
                                    .environmentObject(appConfig)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(Category.allCases) { category in
                            Button(action: {
                                viewModel.selectCategory(category)
                            }) {
                                FilterItemView(item: category)
                                    .environmentObject(appConfig)
                                
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                ScrollView {
                    LazyVGrid(columns: columns, content: {
                        ForEach(viewModel.filteredStories) { story in
                            NavigationLink(destination: StoryPlayerView(story: story)) {
                                StoryCell(story: story, toggleFavorite: {
                                    viewModel.toggleFavorite(for: story)
                                })
                            }
                        }
                    })
                }
            }
            .background(currentColorSet.background)
            .background(ignoresSafeAreaEdges: .all)
            .navigationTitle("Story Catalog")
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
        
    }
}

#Preview {
    CatalogView().environmentObject(AppConfiguration())
}


struct FilterItemView: View {
    let item: TitlePresentable
    @EnvironmentObject var appConfig: AppConfiguration
    
    var body: some View {
        let currentColorSet = appConfig.colorStyle.colorSet
        
        Text(item.title)
            .font(.subheadline)
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .frame(maxWidth: .infinity)
            .background(currentColorSet.accent)
            .cornerRadius(8)
            .foregroundColor(currentColorSet.primaryText)
    }
}

protocol TitlePresentable {
    var title: String { get }
}

