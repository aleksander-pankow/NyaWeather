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
        let getCurrentWeather = (try? await dataManager.fetchWeather(latitude: latitude, longitude: longitude))!
        await coreDataManager.save(response: getCurrentWeather, type: "current")
    }
    
    func getCurrentTips(condition: String, description: String, humidity: Double) -> Void{
        
        var tipsList: Array<String>
        
        func addTip(tips: Array<String>) {
            for tip in tips {
                tipsList.append(tip)
            }
        }
        
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
            addTip(tips: tipsList)
            
        case 20.0...35.0:
            tipsList = [
                "Outdoor humidity is slightly below normal",
                "If you have dry skin, take care of it and apply a moisturizer",
                "Hygienic lipstick will not be superfluous in your pocket"
            ]
            addTip(tips: tipsList)
            
        case 35.0...60.0:
            tipsList = ["The humidity is at its optimum right now. You will feel great!"]
            addTip(tips: tipsList)
            
        case 60.0...100.0:
            tipsList = ["Humidity is high."]
            addTip(tips: tipsList)
            
        default:
            tipsList = ["unknown humidity"]
            addTip(tips: tipsList)
        }
        
        
        switch condition {
        case ContitionWeather.thunderstorm.rawValue:
            switch description {
            case "thunderstorm with light rain":
                tipsList = ["Now the weather is good! It's time to smile and soak up the warm sunny mood!"]
                addTip(tips: tipsList)
                
            case "thunderstorm with rain":
                tipsList = ["thunderstorm with rain"]
                addTip(tips: tipsList)
                
            case "thunderstorm with heavy rain":
                tipsList = ["thunderstorm with heavy rain"]
                addTip(tips: tipsList)
                
            case "light thunderstorm":
                tipsList = ["light thunderstorm"]
                addTip(tips: tipsList)
                
            case "thunderstorm":
                tipsList = ["thunderstorm"]
                addTip(tips: tipsList)
                
            case "heavy thunderstorm":
                tipsList = ["heavy thunderstorm"]
                addTip(tips: tipsList)
                
            case "ragged thunderstorm":
                tipsList = ["ragged thunderstorm"]
                addTip(tips: tipsList)
                
            case "thunderstorm with light drizzle":
                tipsList = ["thunderstorm with light drizzle"]
                addTip(tips: tipsList)
                
            case "thunderstorm with drizzle":
                tipsList = ["thunderstorm with drizzle"]
                addTip(tips: tipsList)
                
            case "thunderstorm with heavy drizzle":
                tipsList = ["thunderstorm with heavy drizzle"]
                addTip(tips: tipsList)
                
            default:
                tipsList = ["unknown thunderstorm"]
                addTip(tips: tipsList)
            }
        case ContitionWeather.drizzle.rawValue:
            switch description {
            case "light intensity drizzle":
                tipsList = ["light intensity drizzle"]
                addTip(tips: tipsList)
                
            case "drizzle":
                tipsList = ["drizzle"]
                addTip(tips: tipsList)
                
            case "heavy intensity drizzle":
                tipsList = ["heavy intensity drizzle"]
                addTip(tips: tipsList)
                
            case "light intensity drizzle rain":
                tipsList = ["light intensity drizzle rain"]
                addTip(tips: tipsList)
                
            case "drizzle rain":
                tipsList = ["drizzle rain"]
                addTip(tips: tipsList)
            case "heavy intensity drizzle rain":
                tipsList = ["heavy intensity drizzle rain"]
                addTip(tips: tipsList)
            case "shower rain and drizzle":
                tipsList = ["shower rain and drizzle"]
                addTip(tips: tipsList)
            case "heavy shower rain and drizzle":
                tipsList = ["heavy shower rain and drizzle"]
                addTip(tips: tipsList)
            case "shower drizzle":
                tipsList = ["shower drizzle"]
                addTip(tips: tipsList)
            default:
                tipsList = ["unknown drizzle"]
                addTip(tips: tipsList)
            }
        case ContitionWeather.rain.rawValue:
            switch description {
            case "light rain":
                tipsList = ["light rain"]
                addTip(tips: tipsList)
            case "moderate rain":
                tipsList = ["moderate rain"]
                addTip(tips: tipsList)
            case "heavy intensity rain":
                tipsList = ["heavy intensity rain"]
                addTip(tips: tipsList)
            case "very heavy rain":
                tipsList = ["very heavy rain"]
                addTip(tips: tipsList)
            case "extreme rain":
                tipsList = ["extreme rain"]
                addTip(tips: tipsList)
            case "freezing rain":
                tipsList = ["freezing rain"]
                addTip(tips: tipsList)
            case "light intensity shower rain":
                tipsList = ["light intensity shower rain"]
                addTip(tips: tipsList)
            case "shower rain":
                tipsList = ["shower rain"]
                addTip(tips: tipsList)
            case "heavy intensity shower rain":
                tipsList = ["heavy intensity shower rain"]
                addTip(tips: tipsList)
            case "ragged shower rain":
                tipsList = ["ragged shower rain"]
                addTip(tips: tipsList)
            default:
                tipsList = ["unknown rain"]
                addTip(tips: tipsList)
            }
        case ContitionWeather.snow.rawValue:
            switch description {
            case "light snow":
                tipsList = ["light snow"]
                addTip(tips: tipsList)
            case "Snow":
                tipsList = ["Snow"]
                addTip(tips: tipsList)
            case "Heavy snow":
                tipsList = ["Heavy snow"]
                addTip(tips: tipsList)
            case "Sleet":
                tipsList = ["Sleet"]
                addTip(tips: tipsList)
            case "Light shower sleet":
                tipsList = ["Light shower sleet"]
                addTip(tips: tipsList)
            case "Shower sleet":
                tipsList = ["Shower sleet"]
                addTip(tips: tipsList)
            case "Light rain and snow":
                tipsList = ["Light rain and snow"]
                addTip(tips: tipsList)
            case "Rain and snow":
                tipsList = ["Rain and snow"]
                addTip(tips: tipsList)
            case "Light shower snow":
                tipsList = ["Light shower snow"]
                addTip(tips: tipsList)
            case "Shower snow":
                tipsList = ["Shower snow"]
                addTip(tips: tipsList)
            case "Heavy shower snow":
                tipsList = ["Heavy shower snow"]
                addTip(tips: tipsList)
            default:
                tipsList = ["unknown snow"]
                addTip(tips: tipsList)
            }
        case ContitionWeather.atmosphere.rawValue:
            switch description {
            case "mist":
                tipsList = ["Mist"]
                addTip(tips: tipsList)
            case "Smoke":
                tipsList = ["Smoke"]
                addTip(tips: tipsList)
            case "Haze":
                tipsList = ["Haze"]
                addTip(tips: tipsList)
            case "sand/ dust whirls":
                tipsList = ["sand/ dust whirls"]
                addTip(tips: tipsList)
            case "fog":
                tipsList = ["Fog"]
                addTip(tips: tipsList)
            case "sand":
                tipsList = ["Sand"]
                addTip(tips: tipsList)
            case "dust":
                tipsList = ["Dust"]
                addTip(tips: tipsList)
            case "volcanic ash":
                tipsList = ["volcanic ash"]
                addTip(tips: tipsList)
            case "squalls":
                tipsList = ["squalls"]
                addTip(tips: tipsList)
            case "tornado":
                tipsList = ["tornado"]
                addTip(tips: tipsList)
            default:
                tipsList = ["unknown atmosphere"]
                addTip(tips: tipsList)
            }
        case ContitionWeather.clear.rawValue:
            switch description {
            case "clear sky":
                tipsList = ["Now the weather is good! It's time to smile and soak up the warm sunny mood!"]
                addTip(tips: tipsList)
            default:
                tipsList = ["unknown clear sky"]
                addTip(tips: tipsList)
            }
        case ContitionWeather.clouds.rawValue:
            switch description {
            case "few clouds":
                tipsList = ["few clouds: 11-25%"]
                addTip(tips: tipsList)
            case "scattered clouds":
                tipsList = ["scattered clouds: 25-50%"]
                addTip(tips: tipsList)
            case "broken clouds":
                tipsList = ["broken clouds: 51-84%"]
                addTip(tips: tipsList)
            case "overcast clouds":
                tipsList = ["overcast clouds: 85-100%"]
                addTip(tips: tipsList)
            default:
                tipsList = ["unknown clouds"]
                addTip(tips: tipsList)
            }
        default:
            tipsList = ["unknown condition"]
            for item in tipsList {
                tips.append(item)
            }
        }
    }
}
