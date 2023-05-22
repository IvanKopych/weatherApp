//
//  WeatherIconView.swift
//  Weather API
//
//  Created by Ivan Kopych on 21.05.2023.
//

import SwiftUI

struct WeatherIconView: View {
    var forecast: DayForecastModel
    
    var body: some View {
        Image(systemName: setupImage())
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    private func setupImage() -> String {
        if let rain = forecast.rain {
            return "cloud.rain"
        }
        else if let cloud = forecast.clouds, cloud > 20 {
            return "cloud"
        }
        
        else {
            return "sun.max"
        }
    }
}

struct WeatheIconView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherIconView(
            forecast: DayForecastModel(
                dt: 122345,
                sunrise: 23344,
                sunset: 554444,
                temp: Temperature(
                    day: 23.4,
                    min: 43.4,
                    max: 43.4,
                    night: 43.6,
                    eve: 65.6,
                    morn: 56.6
                ),
                feelsLike: FeelsLike(
                    day: 10.2,
                    night: 12.3,
                    eve: 32.3,
                    morn: 12.5
                ),
                pressure: 40,
                humidity: 50,
                weather: nil,
                speed: 100,
                deg: 30,
                gust: nil,
                clouds: nil,
                pop: nil,
                rain: nil
            )
        )
    }
}
