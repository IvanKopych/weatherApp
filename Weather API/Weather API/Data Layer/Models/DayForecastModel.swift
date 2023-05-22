//
//  DayForecastModel.swift
//  Weather API
//
//  Created by Ivan Kopych on 17.05.2023.
//

import Foundation

struct DayForecastModel: Identifiable, Codable {
    let id = UUID()
    let dt: Double?
    let sunrise: Int?
    let sunset: Int?
    let temp: Temperature?
    let feelsLike:  FeelsLike?
    let pressure: Int?
    let humidity: Int?
    let weather: [Weather]?
    let speed: Double?
    let deg: Int?
    let gust: Double?
    let clouds: Int?
    let pop: Double?
    let rain: Double?
}

struct Temperature: Codable {
    let day: Double?
    let min: Double?
    let max: Double?
    let night: Double?
    let eve: Double?
    let morn: Double?
}

struct FeelsLike: Codable {
    let day: Double?
    let night: Double?
    let eve: Double?
    let morn: Double?
}

struct Weather: Codable {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
}
