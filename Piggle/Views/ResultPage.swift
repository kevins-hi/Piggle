//
//  ResultPage.swift
//  Piggle
//
//  Created by Kevin Shi on 7/18/21.
//

import SwiftUI

struct ResultPage: View {
    @Binding var search: String
    @Binding var isPlaying: Bool
    
    var body: some View {
        ZStack {
            if search == "" {
                VStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(Color("DarkGray"))
                        .font(.system(size: 60))
                    
                    Text("Please enter a query.")
                        .foregroundColor(Color("DarkGray"))
                        .font(.system(size: 30))
                        .padding(.vertical)
                }
                .padding(.vertical)
            } else if search.capitalized.contains("mosquito".capitalized) {
                VStack {
                    Text("Oh no!")
                        .foregroundColor(Color("DarkGray"))
                        .font(.system(size: 20))
                        .padding()
                    
                    NavigationLink(destination: MosquitoGame()) {
                        Image("mosquito")
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        isPlaying = false
                        SoundManager.instance.stopBackgroundMusic()
                    })
                    
                    Text("Swat the mosquito!")
                        .foregroundColor(Color("DarkGray"))
                        .font(.system(size: 20))
                        .padding()
                }
            } else {
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
    
                        Image(systemName: "exclamationmark.triangle.fill")
                            .foregroundColor(Color("DarkGray"))
                            .font(.system(size: 60))
    
                        Spacer()
                    }
                    .padding(.vertical)
    
                    Text("Sorry, we could not find any results for:")
                        .foregroundColor(Color("DarkGray"))
                        .font(.system(size: 20))
                        .padding()
    
                    Text(search)
                        .foregroundColor(Color("DarkGray"))
                        .font(.system(size: 30))
                        .fontWeight(.bold)
                        .padding(.horizontal)
                }
            }
            
            VStack {
                HStack {
                    Logo()
                    
                    Spacer()
                    
                    BGMButton(isPlaying: $isPlaying)
                }
                
                Spacer()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct ResultPage_Previews: PreviewProvider {
    static var previews: some View {
        ResultPage(search: .constant("mosquito"), isPlaying: .constant(false))
    }
}
