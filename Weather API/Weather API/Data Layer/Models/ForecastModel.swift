//
//  ListForecastModel.swift
//  Weather API
//
//  Created by Ivan Kopych on 18.05.2023.
//

import Foundation

struct ForecastModel: Codable {
    let lat: Double?
    let lon: Double?
    let timezone: String?
    let timezoneOffset: Int?
    let daily: [DayForecastModel]
    let current: CurrentWeather
}

struct CurrentWeather: Codable {
    let dt: Int?
    let sunrise: Int?
    let sunset: Int?
    let temp: Double?
    let feelsLike: Double?
    let pressure: Int?
    let humidity: Int?
    let dewPoint: Double?
    let uvi: Double?
    let clouds: Int?
    let visibility: Int?
    let windSpeed: Double?
    let windDeg: Double?
    let windGust: Double?
    let weather: [Weather]?
}
