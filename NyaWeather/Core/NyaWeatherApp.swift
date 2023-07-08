//
//  NyaWeatherApp.swift
//  NyaWeather
//
//  Created by Aleksander Pankow on 15/08/2022.
//

import SwiftUI

@main
struct NyaWeatherApp: App {
    
    let coreDataManager = CoreDataManager.shared
    
    var body: some Scene {
        WindowGroup {
            WeatherListView()
                .environment(\.managedObjectContext, coreDataManager.container.viewContext)
        }
    }
}
