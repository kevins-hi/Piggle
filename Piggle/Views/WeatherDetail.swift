//
//  WeatherDetail.swift
//  Piggle
//
//  Created by Kevin Shi on 8/3/21.
//

import SDWebImageSwiftUI
import SwiftUI

struct WeatherDetail: View {
    @StateObject var forecastListVM: ForecastListViewModel
    @StateObject var favorites: FavoritesModel
    @Binding var isPlaying: Bool

    var body: some View {
        VStack {
            HStack {
                WeatherLogo()
                
                Spacer()
                
                WeatherBGMButton(isPlaying: $isPlaying)
            }
            
            HStack {
                Picker(selection: $forecastListVM.units, label: Text("Units")) {
                    Text("ºF").tag(0)
                    Text("ºC").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 100)
                .padding(.horizontal)
                .padding(.vertical, 1)
                
                Spacer()
                
                Text(forecastListVM.location.capitalized)
                    .font(.title2)
                
                if favorites.contains(location: forecastListVM.location) {
                    Button {
                        favorites.remove(location: forecastListVM.location)
                    } label: {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                    }
                    .padding(.trailing)
                    .padding(.vertical, 1)
                } else {
                    Button {
                        favorites.add(location: forecastListVM.location)
                    } label: {
                        Image(systemName: "star")
                            .foregroundColor(Color("Gray"))
                    }
                    .padding(.trailing)
                    .padding(.vertical, 1)
                }
            }

            ZStack {
                List(forecastListVM.forecasts, id: \.day) { day in
                    VStack(alignment: .leading) {
                        Text(day.day)
                            .fontWeight(.bold)

                        HStack(alignment: .center) {
                            WebImage(url: day.weatherIconURL)
                                .resizable()
                                .placeholder {
                                    Image(systemName: "hourglass")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20)
                                        .padding(.horizontal, 25)
                                }
                                .scaledToFit()
                                .frame(width: 75)

                            VStack(alignment: .leading) {
                                Text(day.overview)
                                    .font(.title2)
                                HStack {
                                    Text(day.high)
                                    Text(day.low)
                                }
                                HStack {
                                    Text(day.clouds)
                                    Text(day.pop)
                                }
                                Text(day.humidity)
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())

                if forecastListVM.isLoading {
                    ZStack {
                        Color(.systemBackground)
                            .opacity(0.3)
                            .ignoresSafeArea()

                        ProgressView("Fetching Weather")
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
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .alert(item: $forecastListVM.appError) { appAlert in
            Alert(title: Text("Error"),
                  message: Text("\(appAlert.errorString)"))
        }
    }
}


struct WeatherDetail_Previews: PreviewProvider {
    static var previews: some View {
        let forecastListVM = ForecastListViewModel()
        forecastListVM.location = "Chicago"
        forecastListVM.getWeatherForecast()
        let favorites = FavoritesModel()
        favorites.add(location: forecastListVM.location)
        return WeatherDetail(forecastListVM: forecastListVM, favorites: favorites, isPlaying: .constant(false))
    }
}
