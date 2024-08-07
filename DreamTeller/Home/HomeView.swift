import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    init() {
        let viewModel = container.resolve(HomeViewModel.self)!
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 20) {
                   
                    if !viewModel.newStories.isEmpty {
                        SectionView(title: "New Stories", stories: viewModel.newStories, toggleFavorite: { story in
                            viewModel.toggleFavorite(for: story)
                            print("Toggle story: \(story)")
                        })
                    }
                    
                    if !viewModel.recommendedStories.isEmpty {
                        SectionView(title: "Recommended Stories", stories: viewModel.recommendedStories, toggleFavorite: { story in
                            viewModel.toggleFavorite(for: story)
                            print("Toggle story: \(story)")
                        })
                    }
                    
                    if !viewModel.recentStories.isEmpty {
                        SectionView(title: "Recent Stories", stories: viewModel.recentStories, toggleFavorite: { story in
                            viewModel.toggleFavorite(for: story)
                            print("Toggle story: \(story)")
                        })
                    }
                }
                .padding()
            }
            .navigationTitle("Home")
        }
       
    }
}

struct SectionView: View {
    let title: String
    let stories: [Story]
    let toggleFavorite: (Story) -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .padding(.leading, 10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(stories) { story in
                        NavigationLink(destination: StoryPlayerView(story: story)) {
                            StoryCell(story: story, toggleFavorite: {
                                toggleFavorite(story)
                            })
                        }
                    }
                }
                .padding(.leading, 10)
            }
        }
    }
}

#Preview {
    HomeView().environmentObject(AppConfiguration())
}

