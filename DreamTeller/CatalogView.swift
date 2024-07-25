//
//  CatalogView.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 10.07.2024.
//

import SwiftUI

struct CatalogView: View {
    @EnvironmentObject var appConfig: AppConfiguration
    @EnvironmentObject var favoritesService: FavoritesService
    @StateObject private var viewModel: StoryViewModel
    
    init() {
        let viewModel = container.resolve(StoryViewModel.self)!
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        let currentColorSet = appConfig.colorStyle.colorSet
        let columns = [GridItem(.flexible())]
        
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
                Spacer()
            }
            .background(currentColorSet.background)
            .background(ignoresSafeAreaEdges: .all)
            .navigationTitle("Story Catalog")
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
                            .foregroundColor(currentColorSet.primaryText)
                    }
                }
            }
        }
        
    }
}


struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView().environmentObject(AppConfiguration())
    }
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


import Swinject

struct StoryListView: View {
    @EnvironmentObject var favoritesService: FavoritesService
    @StateObject private var viewModel: StoryViewModel
    
    init() {
        let viewModel = container.resolve(StoryViewModel.self)!
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                FilterView(selectedAgeGroup: $viewModel.selectedAgeGroup, selectedCategory: $viewModel.selectedCategory)
                
                List(viewModel.filteredStories) { story in
                    StoryRowView(story: story)
                        .environmentObject(favoritesService)
                        .onTapGesture {
                            viewModel.selectStory(story)
                        }
                        .contextMenu {
                            Button(action: {
                                viewModel.toggleFavorite(for: story)
                            }) {
                                Label(
                                    story.isFavorite ? "Remove from Favorites" : "Add to Favorites",
                                    systemImage: story.isFavorite ? "heart.fill" : "heart"
                                )
                            }
                        }
                }
            }
            .navigationTitle("Stories")
            .sheet(item: $viewModel.selectedStory) { story in
                StoryDetailView(story: story)
            }
        }
        .environmentObject(favoritesService)
    }
}

struct StoryRowView: View {
    let story: Story
    @EnvironmentObject var favoritesService: FavoritesService
    
    var body: some View {
        HStack {
            Image(story.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(story.title)
                    .font(.headline)
                Text(story.category.rawValue)
                    .font(.subheadline)
            }
            
            Spacer()
            
            if story.isFavorite {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            } else {
                Image(systemName: "heart")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct StoryDetailView: View {
    let story: Story
    
    var body: some View {
        VStack {
            Image(story.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxHeight: 300)
                .cornerRadius(10)
                .padding()
            
            Text(story.title)
                .font(.largeTitle)
                .padding()
            
            Text("Category: \(story.category.rawValue)")
                .font(.headline)
                .padding()
            
            Spacer()
        }
        .navigationTitle("Story Detail")
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)
        }
    }
}

struct FilterView: View {
    @Binding var selectedAgeGroup: AgeGroup
    @Binding var selectedCategory: Category
    
    var body: some View {
        HStack {
            Picker("Age Group", selection: $selectedAgeGroup) {
                ForEach(AgeGroup.allCases, id: \.self) { ageGroup in
                    Text(ageGroup.rawValue).tag(ageGroup)
                }
            }
            .pickerStyle(MenuPickerStyle())
            
            Picker("Category", selection: $selectedCategory) {
                ForEach(Category.allCases, id: \.self) { category in
                    Text(category.rawValue).tag(category)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
        .padding()
    }
}
