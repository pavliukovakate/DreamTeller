//
//  CatalogView.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 10.07.2024.
//

import SwiftUI

struct CatalogView: View {
    @EnvironmentObject var appConfig: AppConfiguration
    @StateObject private var viewModel = StoryViewModel(storyService: MockStoryService())
    @Environment(\.colorScheme) var colorScheme
    @State private var searchText = ""

    var body: some View {
        let currentColorSet = appConfig.colorStyle.colorSet//getColorSet(for: colorScheme)

        NavigationView {
            VStack {
                if viewModel.showFilters {
                    HStack {
                        Menu {
                            ForEach(AgeGroup.allCases) { ageGroup in
                                Button(action: {
                                    viewModel.selectAgeGroup(ageGroup)
                                }) {
                                    Text(ageGroup.rawValue)
                                }
                            }
                        } label: {
                            Label("Age Group: \(viewModel.selectedAgeGroup.rawValue)", systemImage: "line.horizontal.3.decrease.circle")
                                .padding()
                                .background(currentColorSet.accentColor.opacity(0.2))
                                .cornerRadius(8)
                        }
                        Menu {
                            ForEach(Category.allCases) { category in
                                Button(action: {
                                    viewModel.selectCategory(category)
                                }) {
                                    Text(category.rawValue)
                                }
                            }
                        } label: {
                            Label("Category: \(viewModel.selectedCategory.rawValue)", systemImage: "line.horizontal.3.decrease.circle")
                                .padding()
                                .background(currentColorSet.accentColor.opacity(0.2))
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                }

                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(viewModel.filteredStories) { story in
                            NavigationLink(destination: StoryPlayerView(story: story)) {
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
                                                .foregroundColor(story.isFavorite ? currentColorSet.iconColor : currentColorSet.textColor)
                                                .padding(8)
                                        }
                                    }
                                    Text(story.title)
                                        .font(.caption)
                                        .foregroundColor(currentColorSet.textColor)
                                }
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Story Catalog")
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            withAnimation {
                                viewModel.showFilters.toggle()
                            }
                        }) {
                            Image(systemName: viewModel.showFilters ? "chevron.up.circle" : "chevron.down.circle")
                                .imageScale(.large)
                                .foregroundColor(currentColorSet.textColor)
                        }
                    }
                }
            }
            .background(currentColorSet.backgroundColor.ignoresSafeArea())
            .environment(\.colorScheme, colorScheme)
        }
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView().environmentObject(AppConfiguration())
    }
}

//import SwiftUI
//
//struct CatalogView: View {
//    @EnvironmentObject var appConfig: AppConfiguration
//    @StateObject private var viewModel = StoryViewModel(storyService: MockStoryService())
//    @State private var searchText = ""
//
//    var body: some View {
//        let currentColorSet = appConfig.colorStyle.colorSet
//
//        NavigationView {
//            VStack {
//                if viewModel.showFilters {
//                    HStack {
//                        Menu {
//                            ForEach(AgeGroup.allCases) { ageGroup in
//                                Button(action: {
//                                    viewModel.selectAgeGroup(ageGroup)
//                                }) {
//                                    Text(ageGroup.rawValue)
//                                }
//                            }
//                        } label: {
//                            Label("Age Group: \(viewModel.selectedAgeGroup.rawValue)", systemImage: "line.horizontal.3.decrease.circle")
//                                .padding()
//                                .background(currentColorSet.accentColor.opacity(0.2))
//                                .cornerRadius(8)
//                        }
//                        Menu {
//                            ForEach(Category.allCases) { category in
//                                Button(action: {
//                                    viewModel.selectCategory(category)
//                                }) {
//                                    Text(category.rawValue)
//                                }
//                            }
//                        } label: {
//                            Label("Category: \(viewModel.selectedCategory.rawValue)", systemImage: "line.horizontal.3.decrease.circle")
//                                .padding()
//                                .background(currentColorSet.accentColor.opacity(0.2))
//                                .cornerRadius(8)
//                        }
//                    }
//                    .padding(.horizontal)
//                }
//
//                ScrollView {
//                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
//                        ForEach(viewModel.filteredStories) { story in
//                            VStack {
//                                ZStack(alignment: .topTrailing) {
//                                    Image(story.imageName)
//                                        .resizable()
//                                        .scaledToFit()
//                                        .frame(height: 150)
//                                        .cornerRadius(12)
//                                    
//                                    Button(action: {
//                                        viewModel.toggleFavorite(for: story)
//                                    }) {
//                                        Image(systemName: story.isFavorite ? "heart.fill" : "heart")
//                                            .foregroundColor(story.isFavorite ? currentColorSet.iconColor : currentColorSet.textColor)
//                                            .padding(8)
//                                    }
//                                }
//                                Text(story.title)
//                                    .font(.caption)
//                                    .foregroundColor(currentColorSet.textColor)
//                            }
//                        }
//                    }
//                    .padding()
//                }
//                .navigationTitle("Story Catalog")
//                .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button(action: {
//                            withAnimation {
//                                viewModel.showFilters.toggle()
//                            }
//                        }) {
//                            Image(systemName: viewModel.showFilters ? "chevron.up.circle" : "chevron.down.circle")
//                                .imageScale(.large)
//                                .foregroundColor(currentColorSet.textColor)
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct CatalogView_Previews: PreviewProvider {
//    static var previews: some View {
//        CatalogView().environmentObject(AppConfiguration())
//    }
//}
