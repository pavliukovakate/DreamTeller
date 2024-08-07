//
//  LearningView.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 10.07.2024.
//

import SwiftUI
import Combine

import SwiftUI

struct LearningView: View {
    @StateObject private var viewModel = LearningViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.learningTasks) { task in
                VStack(alignment: .leading) {
                    Text(task.title)
                        .font(.headline)
                    Text(task.description)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 8)
            }
            .navigationTitle("Обучение")
        }
    }
}

#Preview {
    LearningView()
}

class LearningViewModel: ObservableObject {
    @Published var learningTasks: [LearningTask]
    
    init() {
        self.learningTasks = [
            LearningTask(title: "Игра 'Найди пару'", description: "Помогите ребенку найти пару каждому изображению."),
            LearningTask(title: "Задание 'Выучи новые слова'", description: "Научите ребенка новым словам из сказок."),
            LearningTask(title: "Игра 'Собери пазл'", description: "Соберите пазл с изображением героев сказок.")
        ]
    }
}

struct LearningTask: Identifiable {
    let id = UUID()
    var title: String
    var description: String
}
