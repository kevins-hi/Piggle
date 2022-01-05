//
//  MosquitoGame.swift
//  Piggle
//
//  Created by Kevin Shi on 8/7/21.
//

import SwiftUI

struct MosquitoGame: View {
    @StateObject private var mosquitoGameModel = MosquitoGameModel()
    
    var body: some View {
        ZStack {
            Image("MosquitoGameBackground")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                
                Text("Lives: \(mosquitoGameModel.lives)")
                    .padding()
                
                Spacer()
                
                Image("Piggy")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
                
                HStack {
                    Text("Score: \(mosquitoGameModel.score)")
                        .padding()
                    
                    Spacer()
                    
                    Text("High Score: \(mosquitoGameModel.highscore)")
                        .padding()
                }
            }
            .onAppear(perform: {
                SoundManager.instance.startBackgroundMusic("entertainer")
            })
            .onDisappear(perform: {
                SoundManager.instance.stopBackgroundMusic()
            })
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
            ZStack {
                Color(.systemBackground)
                    .opacity(0.3)
                    .ignoresSafeArea()

                ProgressView("This game is a WIP")
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemBackground))
                    )
                    .shadow(color: Color("Shadow"), radius: 5)
            }
        }
    }
}

struct MosquitoGame_Previews: PreviewProvider {
    static var previews: some View {
        MosquitoGame()
    }
}
