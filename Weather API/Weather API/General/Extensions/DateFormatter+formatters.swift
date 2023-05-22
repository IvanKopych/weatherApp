//
//  DateFormatter+formatters.swift
//  Weather API
//
//  Created by Ivan Kopych on 19.05.2023.
//

import Foundation

extension DateFormatter {
    static let dayOfWeekFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "EEEE"
        formatter.timeZone = .current
        
        return formatter
    }()
    
    static let hoursFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = .current
        
        return formatter
    }()
}
