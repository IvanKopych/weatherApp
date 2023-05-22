//
//  CoordinatesModel.swift
//  Weather API
//
//  Created by Ivan Kopych on 22.05.2023.
//

import Foundation

struct CoordinatesModel {
    let latitude: Double
    let longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
