//
//  WeatherRepositoryImpl.swift
//  WeatherApp
//
//  Created by mac on 17/01/2025.
//

import Foundation

class WeatherRepositoryImpl:WeatherRepository{
    let weatherService:WeatherService
    let weatherDataStore:DataStore
    
    init(weatherService: WeatherService, weatherDataStore: DataStore) {
        self.weatherService = weatherService
        self.weatherDataStore = weatherDataStore
    }
    
    func getWeather() async throws -> WeatherEntity? {
        return try await weatherDataStore.get()
    }
    func addWeather(response: WeatherResponse) async throws {
        try await weatherDataStore.add(response: response)
    }
    func deleteWeather() async throws {
        try await weatherDataStore.deleteEntity()
    }
    func fetchLocationList(for name: String) async throws -> [LocationResponse] {
        return try await weatherService.fetchLocationList(for: name)
    }
    
    func fetchWeather(for location: String) async throws -> WeatherResponse {
        return try await weatherService.fetchWeather(for: location)
    }
    
    
   
}
