//
//  ProfileView.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 10.07.2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Image(viewModel.user.avatar)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                    
                    Text(viewModel.user.name)
                        .font(.title)
                        .padding(.top, 8)
                    
                    Text(viewModel.user.email)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
                
                Form {
                    Section(header: Text("Настройки")) {
                        NavigationLink(destination: Text("Настройки профиля")) {
                            Text("Изменить личные данные")
                        }
                        
                        NavigationLink(destination: Text("Настройки уведомлений")) {
                            Text("Настройки уведомлений")
                        }
                        
                        NavigationLink(destination: Text("Настройки языка и темы")) {
                            Text("Настройки языка и темы")
                        }
                    }
                    
                    Section(header: Text("История прослушиваний")) {
                        ForEach(viewModel.listeningHistory) { history in
                            HStack {
                                Text(history.storyTitle)
                                Spacer()
                                Text(history.dateListened, style: .date)
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            }
                        }
                    }
                    
                    Section {
                        Button(action: {
                            viewModel.logout()
                        }) {
                            Text("Выйти")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Профиль")
        }
    }
}

#Preview {
    ProfileView()
}

import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var listeningHistory: [ListeningHistory]
    
    init() {
        self.user = User(name: "Иван Иванов", email: "ivan@example.com", avatar: "profile")
        self.listeningHistory = [
            ListeningHistory(storyTitle: "Золушка", dateListened: Date()),
            ListeningHistory(storyTitle: "Красная шапочка", dateListened: Date())
        ]
    }
    
    func logout() {
        // Логика выхода из аккаунта
    }
}
