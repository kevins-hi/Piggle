//
//  ForecastListViewModel.swift
//  Piggle
//
//  Created by Kevin Shi on 7/30/21.
//

import CoreLocation
import Foundation
import SwiftUI

class ForecastListViewModel: ObservableObject {
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }
    
    @Published var forecasts: [ForecastViewModel] = []
    var appError: AppError? = nil
    @Published var isLoading: Bool = false
    @Published var location = ""
    @AppStorage("units") var units: Int = 0 {
        didSet {
            for i in 0..<forecasts.count {
                forecasts[i].units = units
            }
        }
    }
    
    init() {
        getWeatherForecast()
    }
    
    func getWeatherForecast() {
        UIApplication.shared.endEditing()
        if location == "" {
            forecasts = []
        } else {
            isLoading = true
            let apiService = APIServiceCombine.shared
            CLGeocoder().geocodeAddressString(location) { (placemarks, error) in
                if let error = error as? CLError {
                    switch error.code {
                    case .locationUnknown, .geocodeFoundNoResult, .geocodeFoundPartialResult:
                        self.appError = AppError(errorString: "Location not found")
                    case .network:
                        self.appError = AppError(errorString: "Network error")
                    default:
                        self.appError = AppError(errorString: error.localizedDescription)
                    }
                    self.isLoading = false
                    print(error.localizedDescription)
                }
                if let lat = placemarks?.first?.location?.coordinate.latitude,
                   let lon = placemarks?.first?.location?.coordinate.longitude {
                    apiService.getJSON(urlString: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=current,minutely,hourly,alerts&appid=\(APIKeys.openWeatherMap)",
                                       dateDecodingStrategy: .secondsSince1970) { (result: Result<Forecast,APIServiceCombine.APIError>) in
                        switch result {
                        case .success(let forecast):
                            DispatchQueue.main.async {
                                self.isLoading = false
                                self.forecasts = forecast.daily.map {ForecastViewModel(forecast: $0, units: self.units)}
                            }
                        case .failure(let apiError):
                            switch apiError {
                            case .error(let errorString):
                                self.isLoading = false
                                self.appError = AppError(errorString: errorString)
                                print(errorString)
                            }
                        }
                    }
                }
            }
        }
    }
}
