//
//  WeatherViewModel.swift
//  NyaWeather
//
//  Created by Aleksander Pankow on 16/08/2022.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    
    @Published var weather =  [WeatherModel]()
    @Published var weatherLoadingError: String = ""
    @Published var isLoading = true
    @Published var showAlert: Bool = false
    @Published var locationManager = LocationManager()
    @Published var coreDataManager = CoreDataManager.shared
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: NetworkManagerProtocol
    
    init(dataManager: NetworkManagerProtocol = NetworkManager.shared) {
        self.dataManager = dataManager
    }
    
    func getWeather(latitude: Double, longitude: Double) async{
        let getWeather = try! await dataManager.fetchWeather(latitude: latitude, longitude: longitude)
        coreDataManager.save(response: getWeather)
    }
}
