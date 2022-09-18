//
//  ForecastViewModel.swift
//  Piggle
//
//  Created by Kevin Shi on 7/30/21.
//

import Foundation

struct ForecastViewModel {
    let forecast: Forecast.Daily
    var units: Int
    
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM d"
        return dateFormatter
    }
    
    private static var numberFormatterInt: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
    
    private static var numberFormatterPercent: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        return numberFormatter
    }
    
    func convert(_ temp: Double) -> Double {
        let celsius = temp - 273.5
        if units == 1 {
            return celsius
        } else {
            return celsius * 9 / 5 + 32
        }
    }
    
    var day: String {
        return Self.dateFormatter.string(from: forecast.dt)
    }
    
    var overview: String {
        forecast.weather[0].description.capitalized
    }
    
    var high: String {
        return "H: \(Self.numberFormatterInt.string(for: convert(forecast.temp.max)) ?? "0")º"
    }
    
    var low: String {
        return "L: \(Self.numberFormatterInt.string(for: convert(forecast.temp.min)) ?? "0")º"
    }
    
    var pop: String {
        return "💧 \(Self.numberFormatterPercent.string(for: forecast.pop) ?? "0%")"
    }
    
    var clouds: String {
        return "☁️ \(forecast.clouds)%"
    }
    
    var humidity: String {
        return "Humidity: \(forecast.humidity)%"
    }
    
    var weatherIconURL: URL {
        let urlString = "https://openweathermap.org/img/wn/\(forecast.weather[0].icon)@2x.png"
        return URL(string: urlString)!
    }
}
