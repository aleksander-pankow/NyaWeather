//
//  ContentView.swift
//  NyaWeather
//
//  Created by Aleksander Pankow on 15/08/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    @ObservedObject var vm = WeatherViewModel()
    @FetchRequest(sortDescriptors: []) var items: FetchedResults<WeatherItem>
    
    var body: some View {
        ZStack{
            AppBgManager.appBackground()
            VStack {
                if locationManager.lastLocation != nil {
                    if items.count > 0 {
                        TabView{
                            ForEach(items, id: \.self) { item in
                                WeatherView(weather: item)
                            }
                        }.tabViewStyle(PageTabViewStyle())
                        
                    } else {
                        LoadingView()
                            .task {
                                do {
                                    locationManager.requestLocation()
                                    await vm.getCurrentWeather(
                                        latitude: (locationManager.lastLocation?.coordinate.latitude)!,
                                        longitude: (locationManager.lastLocation?.coordinate.longitude)!)
                                }
                            }
                    }
                } else {
                    if locationManager.isLoading {
                        LoadingView()
                    } else {
                        WelcomeView()
                            .environmentObject(locationManager)
                    }
                }
            }
            .task {
                do {
                    locationManager.requestLocation()
                    await vm.getCurrentWeather(
                        latitude: (locationManager.lastLocation?.coordinate.latitude)!,
                        longitude: (locationManager.lastLocation?.coordinate.longitude)!)
                }
            }
        }
    }
}
