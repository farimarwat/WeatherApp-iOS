//
//  Injector.swift
//  WeatherApp
//
//  Created by mac on 19/01/2025.
//

import Foundation

class Injector{
    static let shared = Injector()
    
    func providesWeatherViewModel()->WeatherViewModel{
        let viewContext = PersistenceController.shared.container.viewContext
        let store = DataStore(viewContext: viewContext)
        let service = WeatherService()
        let repository = WeatherRepositoryImpl(weatherService: service, weatherDataStore: store)
        return WeatherViewModel(repo: repository)
    }
}
