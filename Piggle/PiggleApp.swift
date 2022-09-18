//
//  PiggleApp.swift
//  Piggle
//
//  Created by Kevin Shi on 7/18/21.
//

import SwiftUI

@main
struct PiggleApp: App {
    @StateObject private var favoritesModel = FavoritesModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favoritesModel)
        }
    }
}
