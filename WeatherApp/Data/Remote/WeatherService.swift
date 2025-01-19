//
//  WeatherService.swift
//  WeatherApp
//
//  Created by mac on 19/01/2025.
//

import Foundation
class WeatherService{
    enum WeatherResponseError:Error{
        case badResponse
    }
    let baseUrl = URL(string: "https://api.weatherapi.com/v1")!
    let apiKey = "994a6621fe89429ab3034108241412"
    let decoder = JSONDecoder()
    
    func fetchLocationList(for name: String) async throws -> [LocationResponse] {
        do{
            let fetchingUrl = baseUrl
                .appending(path: "search.json")
                .appending(queryItems: [
                    URLQueryItem(name: "key", value: apiKey),
                    URLQueryItem(name: "q", value: name)
                ])
            
            let (data, response) = try await URLSession.shared.data(from: fetchingUrl)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw WeatherResponseError.badResponse
            }
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let locationResponse = try decoder.decode([LocationResponse].self, from: data)
            return locationResponse
            
        }catch{
            throw error
        }
        
    }
    
    func fetchWeather(for location: String) async throws -> WeatherResponse {
        do{
            let fetchingUrl = baseUrl
                .appending(path: "forecast.json")
                .appending(queryItems: [
                    URLQueryItem(name: "key", value: apiKey),
                    URLQueryItem(name: "q", value: location),
                    URLQueryItem(name: "days", value: "1")
                ])
            print(String(fetchingUrl.absoluteString))
            let (data, response) = try await URLSession.shared.data(from: fetchingUrl)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw WeatherResponseError.badResponse
            }
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
            return weatherResponse
        }catch{
            throw error
        }
    }
    
    
}
