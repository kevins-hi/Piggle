//
//  MosquitoGameModel.swift
//  Piggle
//
//  Created by Kevin Shi on 8/7/21.
//

import Foundation
import SwiftUI

class MosquitoGameModel: ObservableObject {
    @Published var lives = 3
    @Published var score = 0
    @AppStorage("highscore") var highscore: Int = 0
}
