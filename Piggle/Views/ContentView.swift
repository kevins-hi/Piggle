//
//  ContentView.swift
//  Piggle
//
//  Created by Kevin Shi on 7/18/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        SearchPage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(FavoritesModel())
            .preferredColorScheme(.dark)
    }
}

