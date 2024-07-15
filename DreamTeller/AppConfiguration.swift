//
//  AppConfiguration.swift
//  DreamTeller
//
//  Created by Kateryna Pavliukova on 10.07.2024.
//

import Foundation
import Combine
import SwiftUI

class AppConfiguration: ObservableObject {
    @Published var colorStyle: ColorStyle = .pastel
}
