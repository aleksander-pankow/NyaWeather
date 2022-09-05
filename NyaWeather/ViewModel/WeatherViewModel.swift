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
    
    func getCurrentTips(reason: String) -> String{
        
        switch reason {
            case "clear sky": return "Now the weather is good! It's time to smile and soak up the warm sunny mood!"
            default: return "unknown"
        }
    }
}
