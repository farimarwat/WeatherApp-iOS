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
        let item = WeatherEntity(context: viewContext)
        item.condition = response.details.condition.text
        item.feelsLikeC = response.details.feelslikeC
        item.iconUrl = response.details.condition.iconUrl
        item.name = response.location.name
        item.tempC = response.details.tempC
        item.uv = response.details.uv
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
