//
//  WeatherRepository.swift
//  Weather API
//
//  Created by Ivan Kopych on 18.05.2023.
//

import Foundation

class WeatherRepository {
    private enum Constants {
        static let apiKey = "347106fbe1027eb471891257362560e6"
    }
    
    static func getForecast(lat: Double, lon: Double ) async -> ForecastModel? {
        do {
            let data = try await NetworkManager.shared.get(
                path: "?lat=\(lat)&lon=\(lon)&units=metric&appid=\(Constants.apiKey)", parameters: nil
            )
            let result: ForecastModel = try self.parseData(data: data)
            return result
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }

    private static func parseData<T: Decodable>(data: Data) throws -> T{
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data)
        else {
            throw NSError(
                domain: "NetworkAPIError",
                code: 3,
                userInfo: [NSLocalizedDescriptionKey: "JSON decode error"]
            )
        }
        return decodedData
    }
}
