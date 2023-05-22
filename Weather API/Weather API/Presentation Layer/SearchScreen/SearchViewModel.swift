//
//  SearchViewModel.swift
//  Weather API
//
//  Created by Ivan Kopych on 22.05.2023.
//

import Foundation
import Combine
import CoreLocation

final class SearchViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var selectedCity: String = ""
    var cities: [String] = []
    
    private var placemarks: [CLPlacemark] = []
    
    var cityUpdatedSubscriber: AnyCancellable?
    var locationsResultSubscriber: AnyCancellable?
    var selectedCitySubscriber: AnyCancellable?
    
    init() {
        binOnSubscriber()
    }
    
    private func binOnSubscriber() {
        cityUpdatedSubscriber = $text
            .sink(receiveValue: { [weak self] text in
                LocationManager.shared.getLocationCoordinates(forCity: text)
            })
        
        locationsResultSubscriber = LocationManager.shared.$placemarks
            .sink(receiveValue: { [weak self] placemarks in
                self?.cities = placemarks.compactMap({ $0.locality })
                self?.placemarks = placemarks
            })
        
        selectedCitySubscriber = $selectedCity
            .sink(receiveValue: { [weak self] city in
                let placemark = self?.placemarks.filter({ $0.locality == city }).first
            
                if let location = placemark?.location {
                    LocationManager.shared.getCityName(for: location)
                }
                
            })
    }
}
