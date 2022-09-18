//
//  SearchPage.swift
//  Piggle
//
//  Created by Kevin Shi on 7/18/21.
//

import SwiftUI

struct SearchPage: View {
    @State var search = ""
    @State var isPlaying = false
    @StateObject var searchResultsListVM = SearchResultsListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    
                    Logo()
                    
                    HStack {
                        Spacer()
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color("Gray"))
                        
                        TextField("", text: $search)
                            .padding(.vertical, 10)
                        
                        Button(action: {
                            search = ""
                        }, label: {
                            Image(systemName: "xmark.circle")
                                .foregroundColor(Color("Gray"))
                        })
                        
                        Spacer()
                    }
                    .foregroundColor(Color("DarkGray"))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("LightGray"), lineWidth: 1.3))
                    .padding(10)
                    
                    HStack {
                        NavigationLink(destination: ResultPage(searchResultsListVM: searchResultsListVM, search: $search, isPlaying: $isPlaying)) {
                            Text("Piggle Search")
                                .padding(8.0)
                                .overlay(RoundedRectangle(cornerRadius: 4).fill(Color("LightGray")))
                                .overlay(Text("Piggle Search"))
                        }
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                        .simultaneousGesture(TapGesture().onEnded {
                            UIApplication.shared.endEditing()
                            if search != "" || !search.capitalized.contains("mosquito".capitalized) {
                                searchResultsListVM.query = search.replacingOccurrences(of: " ", with: "%20")
                                searchResultsListVM.getSearchResults()
                            }
                        })
                        
                        NavigationLink(destination: PiggyPage()) {
                            Text("I'm Feeling Piggy")
                                .padding(8.0)
                                .overlay(RoundedRectangle(cornerRadius: 4).fill(Color("LightGray")))
                                .overlay(Text("I'm Feeling Piggy"))
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            isPlaying = false
                            SoundManager.instance.playRandOink()
                        })
                    }
                    .font(.caption)
                    .foregroundColor(Color("DarkGray"))
                    .padding()
                    
                    Spacer()
                }
                
                VStack {
                    HStack {
                        Spacer()
                        
                        VStack {
                            BGMButton(isPlaying: $isPlaying)
                            
                            NavigationLink(destination: WeatherPage()) {
                                Image(systemName: "cloud.sun.fill")
                                    .foregroundColor(Color("PigColor1"))
                                    .font(.system(size: 25))
                                    .frame(width: 60, height: 60)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                isPlaying = false
                                SoundManager.instance.stopBackgroundMusic()
                            })
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
}

struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchPage()
            .preferredColorScheme(.light)
    }
}
