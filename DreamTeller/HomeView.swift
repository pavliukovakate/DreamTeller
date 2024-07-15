//
//  HomeView.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 10.07.2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appConfig: AppConfiguration

    var body: some View {
        let currentColorSet = appConfig.colorStyle.colorSet

        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Обзор новинок
                    Section(header: Text("Новинки")
                                .font(.headline)
                                .padding(.leading)) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0..<10) { _ in
                                    StoryCard(title: "Сказка")
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    // Избранное
                    Section(header: Text("Избранное")
                                .font(.headline)
                                .padding(.leading)) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0..<5) { _ in
                                    StoryCard(title: "Любимая сказка")
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    // Рекомендации
                    Section(header: Text("Рекомендации")
                                .font(.headline)
                                .padding(.leading)) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0..<5) { _ in
                                    StoryCard(title: "Рекомендуемая сказка")
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    // Недавно прослушанные
                    Section(header: Text("Недавно прослушанные")
                                .font(.headline)
                                .padding(.leading)) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0..<5) { _ in
                                    StoryCard(title: "Недавняя сказка")
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationTitle("Аудиосказки")
        }
        
    }
}

struct StoryCard: View {
    var title: String
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color(.gray))
                .frame(width: 120, height: 120)
                .cornerRadius(12)
            Text(title)
                .font(.caption)
        }
        .frame(width: 120, height: 160)
    }
}

struct SearchAndFilterView: View {
    var body: some View {
        TextField("Поиск сказок...", text: .constant(""))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.vertical)
    }
}



#Preview {
    HomeView()
}


