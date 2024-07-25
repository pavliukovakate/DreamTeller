//
//  FavoritesView.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 10.07.2024.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var appConfig: AppConfiguration
    @StateObject private var viewModel: StoryViewModel
    
    init() {
        let viewModel = container.resolve(StoryViewModel.self)!
        _viewModel = StateObject(wrappedValue: viewModel)
    }
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
                                .background(appConfig.colorStyle.colorSet.accent.opacity(0.2))
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
                                .background(appConfig.colorStyle.colorSet.accent.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                }
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(viewModel.filteredStories.filter { $0.isFavorite }) { story in
                            StoryCell(story: story, toggleFavorite: { viewModel.toggleFavorite(for: story) })
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
                                .foregroundColor(appConfig.colorStyle.colorSet.primaryText)
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
