//
//  WeatherViewModel.swift
//  NyaWeather
//
//  Created by Aleksander Pankow on 16/08/2022.
//

import Foundation
import Combine

final class WeatherViewModel: ObservableObject {
    
    @Published var weather =  [WeatherModel]()
    @Published var weatherLoadingError: String = ""
    @Published var isLoading = true
    @Published var showAlert: Bool = false
    @Published var locationManager = LocationManager()
    @Published var coreDataManager = CoreDataManager.shared
    @Published var tips: Array<String> = []
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: NetworkManagerProtocol
    
    init(dataManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.dataManager = dataManager
    }
    
    func getCurrentWeather(latitude: Double, longitude: Double) async{
        let getCurrentWeather = try! await dataManager.fetchWeather(latitude: latitude, longitude: longitude)
        coreDataManager.save(response: getCurrentWeather, type: "current")
    }
    
    func getCurrentTips(condition: String, description: String) -> String{
        enum ContitionWeather : String {
            case thunderstorm = "Thunderstorm"
            case drizzle = "Drizzle"
            case rain = "Rain"
            case snow = "Snow"
            case atmosphere = "Atmosphere"
            case clear = "Clear"
            case clouds = "Clouds"
        }
        
        switch condition {
            case ContitionWeather.clear.rawValue:
            switch description {
                case "clear sky": return "Now the weather is good! It's time to smile and soak up the warm sunny mood!"
                default: return "unknown clear sky"
            }
            case ContitionWeather.thunderstorm.rawValue:
            switch description {
                case "thunderstorm with light rain": return "thunderstorm with light rain"
                case "thunderstorm with rain": return "thunderstorm with rain"
                case "thunderstorm with heavy rain": return "thunderstorm with heavy rain"
                case "light thunderstorm": return "light thunderstorm"
                case "thunderstorm": return "thunderstorm"
                case "heavy thunderstorm": return "heavy thunderstorm"
                case "ragged thunderstorm": return "ragged thunderstorm"
                case "thunderstorm with light drizzle": return "thunderstorm with light drizzle"
                case "thunderstorm with drizzle": return "thunderstorm with drizzle"
                case "thunderstorm with heavy drizzle": return "thunderstorm with heavy drizzle"
                default: return "unknown thunderstorm"
            }
            case ContitionWeather.drizzle.rawValue:
            switch description {
                case "light intensity drizzle": return "light intensity drizzle"
                case "drizzle": return "drizzle"
                case "heavy intensity drizzle": return "heavy intensity drizzle"
                case "light intensity drizzle rain": return "light intensity drizzle rain"
                case "drizzle rain": return "drizzle rain"
                case "heavy intensity drizzle rain": return "heavy intensity drizzle rain"
                case "shower rain and drizzle": return "shower rain and drizzle"
                case "heavy shower rain and drizzle": return "heavy shower rain and drizzle"
                case "shower drizzle": return "shower drizzle"
                default: return "unknown drizzle"
            }
            case ContitionWeather.rain.rawValue:
            switch description {
                case "light rain": return "light rain"
                case "moderate rain": return "moderate rain"
                case "heavy intensity rain": return "heavy intensity rain"
                case "very heavy rain": return "very heavy rain"
                case "extreme rain": return "extreme rain"
                case "freezing rain": return "freezing rain"
                case "light intensity shower rain": return "light intensity shower rain"
                case "shower rain": return "shower rain"
                case "heavy intensity shower rain": return "heavy intensity shower rain"
                case "ragged shower rain": return "ragged shower rain"
                default: return "unknown rain"
            }
            case ContitionWeather.snow.rawValue:
            switch description {
                case "light snow": return "light snow"
                case "Snow": return "Snow"
                case "Heavy snow": return "Heavy snow"
                case "Sleet": return "Sleet"
                case "Light shower sleet": return "Light shower sleet"
                case "Shower sleet": return "Shower sleet"
                case "Light rain and snow": return "Light rain and snow"
                case "Rain and snow": return "Rain and snow"
                case "Light shower snow": return "Light shower snow"
                case "Shower snow": return "Shower snow"
                case "Heavy shower snow": return "Heavy shower snow"
                default: return "unknown snow"
            }
            case ContitionWeather.atmosphere.rawValue:
            switch description {
                case "mist": return "mist"
                case "Smoke": return "Smoke"
                case "Haze": return "Haze"
                case "sand/ dust whirls": return "sand/ dust whirls"
                case "fog": return "fog"
                case "sand": return "sand"
                case "dust": return "dust"
                case "volcanic ash": return "volcanic ash"
                case "squalls": return "squalls"
                case "tornado": return "tornado"
                default: return "unknown atmosphere"
            }
            case ContitionWeather.clear.rawValue:
            switch description {
                case "clear sky": return "Now the weather is good! It's time to smile and soak up the warm sunny mood!"
                default: return "unknown clear sky"
            }
            case ContitionWeather.clouds.rawValue:
            switch description {
                case "few clouds: 11-25%": return "few clouds: 11-25%"
                case "scattered clouds: 25-50%": return "scattered clouds: 25-50%"
                case "broken clouds: 51-84%": return "broken clouds: 51-84%"
                case "overcast clouds: 85-100%": return "overcast clouds: 85-100%"
                default: return "unknown clouds"
            }
            default: return "unknown condition"
        }
    }
}
