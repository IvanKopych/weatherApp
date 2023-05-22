//
//  CurrentWeatherScreen.swift
//  Weather API
//
//  Created by Ivan Kopych on 17.05.2023.
//

import SwiftUI
import Combine

struct CurrentWeatherScreen: View {
    
    // MARK: - State -

    @StateObject var viewModel = CurrentWeatherViewModel()
    @State var presentingModal = false
    
    // MARK: - Properties(private) -

    private var temperature: String {
        String(format: "%.0f", viewModel.forecast?.current.temp ?? 0) + " C°"
    }
    
    private var vinSpeed: String {
        "\(viewModel.forecast?.current.windSpeed ?? 0) m/s"
    }
    
    private var humidity: String {
        "\(viewModel.forecast?.current.humidity ?? 0) %"
    }
    
    private var sunRise: String {
        guard let interval = viewModel.forecast?.current.sunrise else {
            return ""
        }
        
        let date = Date(timeIntervalSince1970: TimeInterval(interval))
        return DateFormatter.hoursFormat.string(from: date)
    }
    
    private var sunSet: String {
        guard let interval = viewModel.forecast?.current.sunset else {
            return ""
        }
        
        let date = Date(timeIntervalSince1970: TimeInterval(interval))
        return DateFormatter.hoursFormat.string(from: date)
    }
    
    // MARK: - Body -

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(viewModel.cityName ?? "")
                    .font(.title)
                Spacer()
                
                Button(action: {
                    self.presentingModal = true
                }
                ) {
                    Image(systemName: "magnifyingglass")
                }
                .sheet(isPresented: $presentingModal) { SearchScreen() }
            }
            .padding()
            
            HStack {
                Text(temperature)
                    .font(.system(size: 40).bold())
                    .foregroundColor(.cyan)
                if let currentDayForecast = viewModel.forecast?.daily.first {
                    WeatherIconView(forecast: currentDayForecast).body
                        .frame(height: 40)
                        .foregroundColor(.cyan)
                }
            }
           
            VStack {
                HStack {
                    Image(systemName: "wind")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                    Text(vinSpeed)
                        .font(.title3)
                    Spacer()
                }
                .padding(.leading)
            
                HStack {
                    Image(systemName: "humidity")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                    Text(humidity)
                        .font(.title3)
                    Spacer()
                }
                .padding(.leading)
                
                HStack {
                    Image(systemName: "sun.haze")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                    Text(sunRise)
                        .font(.title3)
                    Spacer()
                }
                .padding(.leading)
                
                HStack {
                    Image(systemName: "moon.haze")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 30)
                    Text(sunSet)
                        .font(.title3)
                    Spacer()
                }
                .padding(.leading)
            }
        
            Spacer()
            
            DaysListView(dailyForecast: viewModel.forecast?.daily ?? [])
            
        }
        .onAppear {
            viewModel.getLocationData()
            viewModel.binOn()
        }
    }
}

struct CurrentWeatherScreen_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherScreen()
    }
}
