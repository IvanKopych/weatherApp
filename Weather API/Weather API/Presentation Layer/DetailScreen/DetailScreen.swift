//
//  DetailScreen.swift
//  Weather API
//
//  Created by Ivan Kopych on 25.05.2023.
//

import SwiftUI

struct DetailScreen: View {
   
    var dayForecast: DayForecastModel
    
    private var temperature: String {
        String(format: "%.0f", dayForecast.temp?.eve ?? 0) + " C°"
    }
    
    private var dayTemperature: String {
        String(format: "%.0f", dayForecast.temp?.day ?? 0) + " C°"
    }
    
    private var nightTemperature: String {
        String(format: "%.0f", dayForecast.temp?.night ?? 0) + " C°"
    }
    
    private var dayFilsLike: String {
        String(format: "%.0f", dayForecast.feelsLike?.day ?? 0) + " C°"
    }
    
    private var nightFilsLike: String {
        String(format: "%.0f", dayForecast.feelsLike?.night ?? 0) + " C°"
    }
    
    private var vinSpeed: String {
        "\(dayForecast.speed ?? 0) m/s"
    }
    
    private var humidity: String {
        "\(dayForecast.humidity ?? 0) %"
    }
    
    private var sunRise: String {
        guard let interval = dayForecast.sunrise else {
            return ""
        }
        
        let date = Date(timeIntervalSince1970: TimeInterval(interval))
        return DateFormatter.hoursFormat.string(from: date)
    }
    
    private var sunSet: String {
        guard let interval = dayForecast.sunset else {
            return ""
        }
        
        let date = Date(timeIntervalSince1970: TimeInterval(interval))
        return DateFormatter.hoursFormat.string(from: date)
    }
    
    private var dayOfWeak: String {
        guard let interval = dayForecast.dt else {
            return ""
        }
        
        let date = Date(timeIntervalSince1970: interval)
        return DateFormatter.dayOfWeekFormat.string(from: date)
    }
    
    private var day: String {
        guard let interval = dayForecast.dt else {
            return ""
        }
        
        let date = Date(timeIntervalSince1970: interval)
        return DateFormatter.dayFormat.string(from: date)
    }
    
    private var weather: (String, String) {
        if let rain = dayForecast.rain {
            return ("cloud.rain", "дощ")
        }
        else if let cloud = dayForecast.clouds, cloud > 20 {
            return ("cloud", "хмарно")
        }
        
        else {
            return ("sun.max", "сонячно")
        }
    }
    
    
    
    var body: some View {
        VStack {
            
            Image(systemName: weather.0)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 100)
            
            HStack {
                Image(systemName: "thermometer.medium")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
                Text(temperature)
                    .font(.title3)
                Spacer()
            }
    
            HStack {
                Image(systemName: "wind")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
                Text(vinSpeed)
                    .font(.title3)
                Spacer()
            }
            
            HStack {
                Image(systemName: "humidity")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
                Text(humidity)
                    .font(.title3)
                Spacer()
            }
            
            HStack {
                Image(systemName: "sun.haze")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
                Text(sunRise)
                    .font(.title3)
                Spacer()
            }
            
            HStack {
                Image(systemName: "moon.haze")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 30)
                Text(sunSet)
                    .font(.title3)
                Spacer()
            }
            
            Text("У \(dayOfWeak) буде \(weather.1). В день температура підніметься до \(dayTemperature), відчуватиметься як \(dayFilsLike). Вночі температура \(nightTemperature), відчуватиметься як \(nightFilsLike)")
                .padding(EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0))
                .font(.title3)
            Spacer()
        }
        .padding()
        .navigationTitle(day)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailViewScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailScreen(
            dayForecast: DayForecastModel(
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
