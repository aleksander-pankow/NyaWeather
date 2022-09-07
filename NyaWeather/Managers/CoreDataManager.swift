//
//  CoreDataService.swift
//  NyaWeather
//
//  Created by Aleksander Pankow on 15/08/2022.
//

import Foundation
import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "NyaWeatherNew")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    func save(response: WeatherModel, type: String){
        let context = container.viewContext
        let weatherItem = WeatherItem(context: context)
        weatherItem.name = response.name
        weatherItem.temp = response.main.temp
        weatherItem.humidity = response.main.humidity
        weatherItem.desc = response.weather.first?.description
        weatherItem.condition = response.weather.first?.main
        weatherItem.wind = response.wind.speed
        weatherItem.type = type

        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    func delete(item:WeatherItem){
        let context = container.viewContext
        context.delete(item)
        try! context.save()
    }
}
