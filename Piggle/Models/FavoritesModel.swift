//
//  FavoritesModel.swift
//  Piggle
//
//  Created by Kevin Shi on 8/7/21.
//

import Foundation
import SwiftUI
import CryptoKit

class FavoritesModel: ObservableObject {
    @AppStorage("favorites") var favorites: [String] = []
    
    func add(location: String) {
        favorites.append(location)
    }
    
    func remove(location: String) {
        guard let idx = favorites.firstIndex(of: location) else { return }
        favorites.remove(at: idx)
    }
    
    func contains(location: String) -> Bool {
        return favorites.contains(location)
    }
}
