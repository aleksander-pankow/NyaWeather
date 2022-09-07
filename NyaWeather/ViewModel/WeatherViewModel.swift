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
    
    func getCurrentTips(condition: String, description: String, humidity: Double) -> Void{
        
        var tipsList: Array<String>
        
        enum ContitionWeather : String {
            case thunderstorm = "Thunderstorm"
            case drizzle = "Drizzle"
            case rain = "Rain"
            case snow = "Snow"
            case atmosphere = "Atmosphere"
            case clear = "Clear"
            case clouds = "Clouds"
        }
        
        switch humidity {
        case 0.0...20.0:
            tipsList =
            [
                "It's dry outside",
                "We recommend using a moisturizer, hygienic lipstick and of course",
                "DON'T FORGET TO DRINK WATER!"
            ]
            for item in tipsList {
                tips.append(item)
            }
            
        case 20.0...35.0:
            tipsList = [
                "Outdoor humidity is slightly below normal",
                "If you have dry skin, take care of it and apply a moisturizer",
                "Hygienic lipstick will not be superfluous in your pocket"
            ]
            for item in tipsList {
                tips.append(item)
            }
        case 35.0...60.0:
            tipsList = ["The humidity is at its optimum right now. You will feel great!"]
            for item in tipsList {
                tips.append(item)
            }
        case 60.0...100.0:
            tipsList = ["Humidity is high."]
            for item in tipsList {
                tips.append(item)
            }
        default:
            tipsList = ["unknown humidity"]
            tips.append(tipsList[0])
        }
        
        
        switch condition {
        case ContitionWeather.thunderstorm.rawValue:
            switch description {
            case "thunderstorm with light rain":
                tipsList = ["Now the weather is good! It's time to smile and soak up the warm sunny mood!"]
                for item in tipsList {
                    tips.append(item)
                }
            case "thunderstorm with rain":
                tipsList = ["thunderstorm with rain"]
                for item in tipsList {
                    tips.append(item)
                }
            case "thunderstorm with heavy rain":
                tipsList = ["thunderstorm with heavy rain"]
                for item in tipsList {
                    tips.append(item)
                }
            case "light thunderstorm":
                tipsList = ["light thunderstorm"]
                for item in tipsList {
                    tips.append(item)
                }
            case "thunderstorm":
                tipsList = ["thunderstorm"]
                for item in tipsList {
                    tips.append(item)
                }
            case "heavy thunderstorm":
                tipsList = ["heavy thunderstorm"]
                for item in tipsList {
                    tips.append(item)
                }
            case "ragged thunderstorm":
                tipsList = ["ragged thunderstorm"]
                for item in tipsList {
                    tips.append(item)
                }
            case "thunderstorm with light drizzle":
                tipsList = ["thunderstorm with light drizzle"]
                for item in tipsList {
                    tips.append(item)
                }
            case "thunderstorm with drizzle":
                tipsList = ["thunderstorm with drizzle"]
                for item in tipsList {
                    tips.append(item)
                }
            case "thunderstorm with heavy drizzle":
                tipsList = ["thunderstorm with heavy drizzle"]
                for item in tipsList {
                    tips.append(item)
                }
                
            default:
                tipsList = ["unknown thunderstorm"]
                for item in tipsList {
                    tips.append(item)
                }
            }
        case ContitionWeather.drizzle.rawValue:
            switch description {
            case "light intensity drizzle":
                tipsList = ["light intensity drizzle"]
                for item in tipsList {
                    tips.append(item)
                }
            case "drizzle":
                tipsList = ["drizzle"]
                for item in tipsList {
                    tips.append(item)
                }
            case "heavy intensity drizzle":
                tipsList = ["heavy intensity drizzle"]
                for item in tipsList {
                    tips.append(item)
                }
            case "light intensity drizzle rain":
                tipsList = ["light intensity drizzle rain"]
                for item in tipsList {
                    tips.append(item)
                }
            case "drizzle rain":
                tipsList = ["drizzle rain"]
                for item in tipsList {
                    tips.append(item)
                }
            case "heavy intensity drizzle rain":
                tipsList = ["heavy intensity drizzle rain"]
                for item in tipsList {
                    tips.append(item)
                }
            case "shower rain and drizzle":
                tipsList = ["shower rain and drizzle"]
                for item in tipsList {
                    tips.append(item)
                }
            case "heavy shower rain and drizzle":
                tipsList = ["heavy shower rain and drizzle"]
                for item in tipsList {
                    tips.append(item)
                }
            case "shower drizzle":
                tipsList = ["shower drizzle"]
                for item in tipsList {
                    tips.append(item)
                }
            default:
                tipsList = ["unknown drizzle"]
                for item in tipsList {
                    tips.append(item)
                }
            }
        case ContitionWeather.rain.rawValue:
            switch description {
            case "light rain":
                tipsList = ["light rain"]
                for item in tipsList {
                    tips.append(item)
                }
            case "moderate rain":
                tipsList = ["moderate rain"]
                for item in tipsList {
                    tips.append(item)
                }
            case "heavy intensity rain":
                tipsList = ["heavy intensity rain"]
                for item in tipsList {
                    tips.append(item)
                }
            case "very heavy rain":
                tipsList = ["very heavy rain"]
                for item in tipsList {
                    tips.append(item)
                }
            case "extreme rain":
                tipsList = ["extreme rain"]
                for item in tipsList {
                    tips.append(item)
                }
            case "freezing rain":
                tipsList = ["freezing rain"]
                for item in tipsList {
                    tips.append(item)
                }
            case "light intensity shower rain":
                tipsList = ["light intensity shower rain"]
                for item in tipsList {
                    tips.append(item)
                }
            case "shower rain":
                tipsList = ["shower rain"]
                for item in tipsList {
                    tips.append(item)
                }
            case "heavy intensity shower rain":
                tipsList = ["heavy intensity shower rain"]
                for item in tipsList {
                    tips.append(item)
                }
            case "ragged shower rain":
                tipsList = ["ragged shower rain"]
                for item in tipsList {
                    tips.append(item)
                }
            default:
                tipsList = ["unknown rain"]
                for item in tipsList {
                    tips.append(item)
                }
            }
        case ContitionWeather.snow.rawValue:
            switch description {
            case "light snow":
                tipsList = ["light snow"]
                for item in tipsList {
                    tips.append(item)
                }
            case "Snow":
                tipsList = ["Snow"]
                for item in tipsList {
                    tips.append(item)
                }
            case "Heavy snow":
                tipsList = ["Heavy snow"]
                for item in tipsList {
                    tips.append(item)
                }
            case "Sleet":
                tipsList = ["Sleet"]
                for item in tipsList {
                    tips.append(item)
                }
            case "Light shower sleet":
                tipsList = ["Light shower sleet"]
                for item in tipsList {
                    tips.append(item)
                }
            case "Shower sleet":
                tipsList = ["Shower sleet"]
                for item in tipsList {
                    tips.append(item)
                }
            case "Light rain and snow":
                tipsList = ["Light rain and snow"]
                for item in tipsList {
                    tips.append(item)
                }
            case "Rain and snow":
                tipsList = ["Rain and snow"]
                for item in tipsList {
                    tips.append(item)
                }
            case "Light shower snow":
                tipsList = ["Light shower snow"]
                for item in tipsList {
                    tips.append(item)
                }
            case "Shower snow":
                tipsList = ["Shower snow"]
                for item in tipsList {
                    tips.append(item)
                }
            case "Heavy shower snow":
                tipsList = ["Heavy shower snow"]
                for item in tipsList {
                    tips.append(item)
                }
            default:
                tipsList = ["unknown snow"]
                for item in tipsList {
                    tips.append(item)
                }
            }
        case ContitionWeather.atmosphere.rawValue:
            switch description {
            case "mist":
                tipsList = ["Mist"]
                for item in tipsList {
                    tips.append(item)
                }
            case "Smoke":
                tipsList = ["Smoke"]
                for item in tipsList {
                    tips.append(item)
                }
            case "Haze":
                tipsList = ["Haze"]
                for item in tipsList {
                    tips.append(item)
                }
            case "sand/ dust whirls":
                tipsList = ["sand/ dust whirls"]
                for item in tipsList {
                    tips.append(item)
                }
            case "fog":
                tipsList = ["Fog"]
                for item in tipsList {
                    tips.append(item)
                }
            case "sand":
                tipsList = ["Sand"]
                for item in tipsList {
                    tips.append(item)
                }
            case "dust":
                tipsList = ["Dust"]
                for item in tipsList {
                    tips.append(item)
                }
            case "volcanic ash":
                tipsList = ["volcanic ash"]
                for item in tipsList {
                    tips.append(item)
                }
            case "squalls":
                tipsList = ["squalls"]
                for item in tipsList {
                    tips.append(item)
                }
            case "tornado":
                tipsList = ["tornado"]
                for item in tipsList {
                    tips.append(item)
                }
            default:
                tipsList = ["unknown atmosphere"]
                for item in tipsList {
                    tips.append(item)
                }
            }
        case ContitionWeather.clear.rawValue:
            switch description {
            case "clear sky":
                tipsList = ["Now the weather is good! It's time to smile and soak up the warm sunny mood!"]
                for item in tipsList {
                    tips.append(item)
                }
            default:
                tipsList = ["unknown clear sky"]
                for item in tipsList {
                    tips.append(item)
                }
            }
        case ContitionWeather.clouds.rawValue:
            switch description {
            case "few clouds":
                tipsList = ["few clouds: 11-25%"]
                for item in tipsList {
                    tips.append(item)
                }
            case "scattered clouds":
                tipsList = ["scattered clouds: 25-50%"]
                for item in tipsList {
                    tips.append(item)
                }
            case "broken clouds":
                tipsList = ["broken clouds: 51-84%"]
                for item in tipsList {
                    tips.append(item)
                }
            case "overcast clouds":
                tipsList = ["overcast clouds: 85-100%"]
                for item in tipsList {
                    tips.append(item)
                }
            default:
                tipsList = ["unknown clouds"]
                for item in tipsList {
                    tips.append(item)
                }
            }
        default:
            tipsList = ["unknown condition"]
            for item in tipsList {
                tips.append(item)
            }
        }
    }
}
