//
//  WeatherPage.swift
//  Piggle
//
//  Created by Kevin Shi on 8/3/21.
//

import SwiftUI

struct WeatherPage: View {
    @StateObject var forecastListVM = ForecastListViewModel()
    @EnvironmentObject var favoritesModel: FavoritesModel
    @State var searchLocation = ""
    @State var isPlaying = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                WeatherLogo()
                
                Spacer()
                
                WeatherBGMButton(isPlaying: $isPlaying)
            }
            
            HStack {
                HStack {
                    TextField("Enter Location", text: $searchLocation)
                        .padding(.leading, 5)
                        .padding(.vertical, 5)
                    
                    Button(action: {
                        searchLocation = ""
                    }) {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color("Gray"))
                    }
                    .padding(.horizontal, 5)
                }
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("LightGray"), lineWidth: 1.3))

                NavigationLink(
                    destination: WeatherDetail(forecastListVM: forecastListVM, favorites: favoritesModel, isPlaying: $isPlaying),
                    label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.title3)
                    })
                    .simultaneousGesture(TapGesture().onEnded {
                        forecastListVM.location = searchLocation
                        forecastListVM.getWeatherForecast()
                    })
                    .foregroundColor(Color("Gray"))
            }
            .padding(.horizontal)
            .padding(.vertical, 1)
            
            List {
                ForEach(favoritesModel.favorites, id: \.hash) { favorite in
                    ZStack {
                        Button("") {
                            forecastListVM.location = favorite
                            forecastListVM.getWeatherForecast()
                        }
                        
                        NavigationLink(
                            destination: WeatherDetail(forecastListVM: forecastListVM, favorites: favoritesModel, isPlaying: $isPlaying),
                            label: {
                                Text(favorite.capitalized)
                        })
                    }
                }
            }
            .listStyle(PlainListStyle())
            
            HStack {
                Button(action: {
                    isPlaying = false
                    SoundManager.instance.stopBackgroundMusic()
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrowshape.turn.up.backward.circle.fill")
                        .foregroundColor(Color("Weather1"))
                        .font(.system(size: 50))
                        .padding(8)
                })
                
                Spacer()
            }
        }
        .gesture(DragGesture())
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct WeatherPage_Previews: PreviewProvider {
    static var previews: some View {
        WeatherPage()
            .environmentObject(FavoritesModel())
    }
}
