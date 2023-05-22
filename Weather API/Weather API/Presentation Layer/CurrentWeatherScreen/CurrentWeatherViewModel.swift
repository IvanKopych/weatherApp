//
//  CurrentWeatherViewModel.swift
//  Weather API
//
//  Created by Ivan Kopych on 17.05.2023.
//

import Foundation
import Combine
import CoreLocation

final class CurrentWeatherViewModel: ObservableObject {
    @MainActor @Published var errorMessage = ""
    @MainActor @Published var forecast: ForecastModel?
    @Published var cityName: String?
    @Published var placemark: CLPlacemark?
   
    var cityUpdatedSubscriber: AnyCancellable?
    
    private func fetchForecast(lat: Double, lon: Double) async {
        await MainActor.run {
            self.errorMessage = ""
        }
        if let res = await WeatherRepository.getForecast(lat: lat, lon: lon)
        {
            await MainActor.run {
                self.forecast = res
            }
        } else {
            await MainActor.run {
                self.errorMessage = "Fetch data failed"
            }
        }
    }
    
    func getLocationData() {
        LocationManager.shared.requestLocationPermission()
        LocationManager.shared.getCurrenLocation()
    }
    
    func binOn() {
        binOnLocationManager()
    }
    
    private func binOnLocationManager() {
        cityUpdatedSubscriber = LocationManager.shared.$placemark
            .sink { [weak self] placemark in
                self?.placemark = placemark
                self?.cityName = placemark?.locality
                self?.fetchData()
            }
    }
    
    private func fetchData() {
        guard let lat = placemark?.location?.coordinate.latitude else {
            return
        }
        
        guard let lon = placemark?.location?.coordinate.longitude else {
            return
        }
        
        Task {
            await fetchForecast(lat:lat, lon:lon)
        }
    }
    
}
