//
//  WeatherView.swift
//  Piggle
//
//  Created by Kevin Shi on 7/24/21.
//

import SDWebImageSwiftUI
import SwiftUI

struct WeatherView: View {
    @StateObject private var forecastListVM = ForecastListViewModel()

    var body: some View {
        VStack {
            Picker(selection: $forecastListVM.units, label: Text("Units")) {
                Text("ºF").tag(0)
                Text("ºC").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .frame(width: 100)
            .padding(.vertical)

            HStack {
                TextField("Enter Location", text: $forecastListVM.location, onCommit: {
                    forecastListVM.getWeatherForecast()
                })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay (
                    Button(action: {
                        forecastListVM.location = ""
                        forecastListVM.getWeatherForecast()
                    }) {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(.gray)
                            .padding(.horizontal, 5.0)
                    }
                    .padding(.horizontal, 5.0),
                    alignment: .trailing
                )

                Button {
                    forecastListVM.getWeatherForecast()
                } label: {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .font(.title3)
                }
            }
            .padding(.horizontal)

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
        .navigationBarTitle("", displayMode: .inline)
        .alert(item: $forecastListVM.appError) { appAlert in
            Alert(title: Text("Error"),
                  message: Text("\(appAlert.errorString)"))
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
