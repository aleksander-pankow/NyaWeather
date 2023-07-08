//
//  WeatherListView.swift
//  NyaWeather
//
//  Created by Aleksander Pankow on 25/09/2022.
//

import SwiftUI

struct WeatherListView: View {
    
    @StateObject var locationManager = LocationManager()
    @ObservedObject var vm = WeatherViewModel()
    @FetchRequest(sortDescriptors: []) var items: FetchedResults<WeatherItem>
    @State private var searchText = ""
    @State private var showingSheet = false
    
    var body: some View {
        TextField("Search...", text: $searchText)
            .searchable(text: $searchText) {
                Text("Lol").foregroundColor(Color.white).padding(.all).searchCompletion("Complete")
                Text("Lol").foregroundColor(Color.white).padding(.all).searchCompletion("Complete")
                Text("Lol").foregroundColor(Color.white).padding(.all).searchCompletion("Complete")
            }
            .padding(.all)
            .border(Color.white)
        
        NavigationView {
            VStack {
                
                if locationManager.lastLocation != nil {
                    if items.count > 0 {
                        //List {
                        ForEach(items, id: \.self) { item in
                            //                            NavigationLink(destination: WeatherView(weather: item)){
                            //                                WeatherListViewItem(weather: item)
                            //                            }
                            
                            WeatherListViewItem(weather: item)
                                .onTapGesture{
                                    showingSheet.toggle()
                                }
                                .sheet(isPresented: $showingSheet){
                                    WeatherView(weather: item)
                                }
                        }
                    } else {
                        //get current weather if CoreData empty
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
            //Update every 10m
            .onAppear{
                Task{
                    do{
                        locationManager.requestLocation()
                        await vm.getCurrentWeather(
                            latitude: (locationManager.lastLocation?.coordinate.latitude)!,
                            longitude: (locationManager.lastLocation?.coordinate.longitude)!)
                    }
                }
                Timer.scheduledTimer(withTimeInterval: 600, repeats: true) { timer in
                    vm.isLoading = true
                    Task{
                        locationManager.requestLocation()
                        await vm.getCurrentWeather(
                            latitude: (locationManager.lastLocation?.coordinate.latitude)!,
                            longitude: (locationManager.lastLocation?.coordinate.longitude)!)
                    }
                    print("Iteration")
                }
            }
            
        }
    }
}
