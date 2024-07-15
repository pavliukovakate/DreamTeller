//
//  FavoritesView.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 10.07.2024.
//

import SwiftUI

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var appConfig: AppConfiguration
    @StateObject private var viewModel = StoryViewModel(storyService: MockStoryService())

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.showFilters {
                    HStack {
                        Menu {
                            ForEach(AgeGroup.allCases, id: \.self) { ageGroup in
                                Button(action: {
                                    viewModel.selectAgeGroup(ageGroup)
                                }) {
                                    Text(ageGroup.rawValue)
                                }
                            }
                        } label: {
                            Label("Age Group: \(viewModel.selectedAgeGroup.rawValue)", systemImage: "line.horizontal.3.decrease.circle")
                                .padding()
                                .background(appConfig.colorStyle.colorSet.accentColor.opacity(0.2))
                                .cornerRadius(8)
                        }
                        Menu {
                            ForEach(Category.allCases, id: \.self) { category in
                                Button(action: {
                                    viewModel.selectCategory(category)
                                }) {
                                    Text(category.rawValue)
                                }
                            }
                        } label: {
                            Label("Category: \(viewModel.selectedCategory.rawValue)", systemImage: "line.horizontal.3.decrease.circle")
                                .padding()
                                .background(appConfig.colorStyle.colorSet.accentColor.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                }

                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(viewModel.filteredStories.filter { $0.isFavorite }) { story in
                            VStack {
                                ZStack(alignment: .topTrailing) {
                                    Image(story.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 150)
                                        .cornerRadius(12)
                                    
                                    Button(action: {
                                        viewModel.toggleFavorite(for: story)
                                    }) {
                                        Image(systemName: story.isFavorite ? "heart.fill" : "heart")
                                            .foregroundColor(story.isFavorite ? appConfig.colorStyle.colorSet.iconColor : appConfig.colorStyle.colorSet.textColor)
                                            .padding(8)
                                    }
                                }
                                Text(story.title)
                                    .font(.caption)
                                    .foregroundColor(appConfig.colorStyle.colorSet.textColor)
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Favorite Stories")
                .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            withAnimation {
                                viewModel.showFilters.toggle()
                            }
                        }) {
                            Image(systemName: viewModel.showFilters ? "chevron.up.circle" : "chevron.down.circle")
                                .imageScale(.large)
                                .foregroundColor(appConfig.colorStyle.colorSet.textColor)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    FavoritesView().environmentObject(AppConfiguration())
}
