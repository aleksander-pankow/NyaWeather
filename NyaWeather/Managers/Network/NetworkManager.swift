//
//  ApiRequest.swift
//  NyaWeather
//
//  Created by Aleksander Pankow on 15/08/2022.
//

import Foundation
import CoreLocation
import Combine

protocol NetworkManagerProtocol {
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WeatherModel
}


class NetworkManager {
    static let shared: NetworkManagerProtocol = NetworkManager()
    private init() { }
}

extension NetworkManager: NetworkManagerProtocol {

    // MARK: - Request weather to Open Weather
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WeatherModel {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=f79080bd8972e92d510407063c4d444e&units=metric") else {
            fatalError("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching weather data")
        }
        
        let decodedData = try JSONDecoder().decode(WeatherModel.self, from: data)
        print(decodedData)
        return decodedData
    }
}
