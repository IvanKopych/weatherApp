//
//  NumberFormatter+formatters.swift
//  Weather API
//
//  Created by Ivan Kopych on 19.05.2023.
//

import Foundation

extension NumberFormatter {
    static let temperatureFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 0
        return formatter
    }()
}
