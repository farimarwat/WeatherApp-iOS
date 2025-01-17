//
//  WeatherRepository.swift
//  WeatherApp
//
//  Created by mac on 17/01/2025.
//

import Foundation

protocol WeatherRepository{
    func fetchLocationList(for name:String) async throws -> [LocationResponse]
    func fetchWeather(for location:String)async throws -> WeatherResponse
    
    func getWeather() async throws ->WeatherEntity?
    func addWeather(response:WeatherResponse) async throws
    func deleteWeather() async throws
}
