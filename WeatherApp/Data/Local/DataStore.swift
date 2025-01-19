//
//  DataStore.swift
//  WeatherApp
//
//  Created by mac on 19/01/2025.
//

import Foundation
import CoreData

class DataStore{
    let viewContext:NSManagedObjectContext
    
    init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
    }
    
    func get() async throws -> WeatherEntity?{
        do {
            let request = WeatherEntity.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(keyPath: \WeatherEntity.name, ascending: false)]
            request.fetchLimit = 1
            
            let items = try viewContext.performAndWait {
                try request.execute()
            }
            
            if let weather = items.first {
                return weather
            } else {
                return nil
            }
        } catch {
            throw error
        }
    }
    
    func add(response:WeatherResponse) async throws{
        var forecasts:[ForecastEntity] = []
        let weather = WeatherEntity(context: viewContext)
        weather.condition = response.details.condition.text
        weather.feelsLikeC = response.details.feelslikeC
        weather.iconUrl = response.details.condition.iconUrl
        weather.name = response.location.name
        weather.tempC = response.details.tempC
        weather.uv = response.details.uv
        
        if let hours = response.forecast.forecastday.first?.hour {
            for hour in hours{
                let fc = ForecastEntity(context: viewContext)
                fc.time = hour.time
                fc.tempC = hour.tempC
                fc.icon = hour.condition.icon
                fc.conditionText = hour.condition.text
                forecasts.append(fc)
            }
            weather.forecasts = NSSet(array: forecasts)
        }
        
        try await saveData()
    }
    
    func deleteEntity() async throws{
        do{
            let request = WeatherEntity.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(keyPath:\WeatherEntity.name,ascending: false)]
            request.fetchLimit = 1
            
            let items = try viewContext.performAndWait {
                try request.execute()
            }
            
            if let weather = items.first {
                viewContext.delete(weather)
                try await saveData()
            }
        }catch{
            throw error
        }
    }
    
    func saveData() async throws{
        do{
            try viewContext.save()
        }catch{
            throw error
        }
    }
}
