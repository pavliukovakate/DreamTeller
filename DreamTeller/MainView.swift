//
//  MainView.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 10.07.2024.
//
import SwiftUI

struct MainView: View {
    @EnvironmentObject var appConfig: AppConfiguration
    
    var body: some View {
        let currentColorSet = appConfig.colorStyle.colorSet

        TabView {
            HomeView()
                .tabItem {
                    Label("Главная", systemImage: "house.fill")
                }
                .environmentObject(appConfig)


            CatalogView()
                .tabItem {
                    Label("Каталог", systemImage: "list.bullet")
                }
                .environmentObject(appConfig)

            FavoritesView()
                .tabItem {
                    Label("Избранное", systemImage: "heart.fill")
                }
                .environmentObject(appConfig)
           
            LearningView()
                .tabItem {
                    Label("Обучение", systemImage: "brain.head.profile")
                }
                .environmentObject(appConfig)
            
            ProfileView()
                .tabItem {
                    Label("Профиль", systemImage: "person.fill")
                }
                .environmentObject(appConfig)

        }
        .accentColor(appConfig.colorStyle.colorSet.iconColor)
    }

}

//#Preview {
//    MainView().environmentObject(AppConfiguration())
//       
//}
//
//    






