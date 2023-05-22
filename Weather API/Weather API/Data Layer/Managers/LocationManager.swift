//
//  LocationManager.swift
//  Weather API
//
//  Created by Ivan Kopych on 21.05.2023.
//

import Foundation
import CoreLocation
import Combine

final class LocationManager: NSObject {
    
    // MARK: - Publishers -

    @Published var placemark: CLPlacemark?
    @Published var placemarks: [CLPlacemark] = []
    
    // MARK: - Properties(private) -
    
    private(set) lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        
        locationManager.delegate = self
        
        return locationManager
    }()
    
    // MARK: - Properties(public) -

    static let shared = LocationManager()
    
    // MARK: - Methods(public) -
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getCurrenLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func getLocationCoordinates(forCity cityName: String) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(cityName) { (placemarks, error) in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            self.placemarks = placemarks ?? []
        }
    }

    func getCityName(for location: CLLocation) {
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                return
            }
            
            self?.placemark = placemarks?.first
        }
    }
}

// MARK: - CLLocationManagerDelegate -

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            getCityName(for: location)
        }
    }
}
