//
//  DayView.swift
//  Weather API
//
//  Created by Ivan Kopych on 17.05.2023.
//

import SwiftUI

struct DayView: View {
    var forecast: DayForecastModel
    
    var body: some View {
        HStack {
            Text(setupDateText(with: forecast.dt))
                .font(.title3)
            
            Spacer()
            
            WeatherIconView(forecast: forecast)
            Text(setupTemperatureText(with: forecast.temp?.min, max: forecast.temp?.max))
                .font(.title3)
        }
        .padding()
        .frame(height: 60)
        
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
    
    private func setupDateText(with interval: Double?) -> String {
        guard let interval else {
            return ""
        }
        
        let date = Date(timeIntervalSince1970: interval)
        
        return DateFormatter.dayOfWeekFormat.string(from: date)
    }
    
    private func setupTemperatureText(with min: Double?, max: Double?) -> String {
        let minTemperature = String(format: "%.0f", min ?? 0)
        let maxTemperature = String(format: "%.0f", max ?? 0)
        
        return "\(minTemperature)° - \(maxTemperature)°"
    }
}

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView(
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
