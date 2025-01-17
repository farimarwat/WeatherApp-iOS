//
//  ViewModel.swift
//  WeatherApp
//
//  Created by mac on 18/01/2025.
//

import Foundation
import CoreData

class WeatherViewModel:ObservableObject{
    private var repository:WeatherRepository
    
    
    @Published var weather:WeatherEntity?
    @Published var fetchStatus:FetchStatus = .notloading
    @Published var loadStatus:LoadStatus = .notLoading
    @Published var locations:[WeatherResponse] = []
    
    init(repo:WeatherRepository){
        self.repository = repo
    }
    
    @MainActor
    func add(response: WeatherResponse) async{
        loadStatus = .loading
        do{
            try await repository.deleteWeather()
            try await repository.addWeather(response: response)
            weather = try await repository.getWeather()
            loadStatus = .successfull
        }catch{
            loadStatus = .error(error: error)
        }
    }
    
    @MainActor
    func get() async {
        loadStatus = .loading
        do{
            weather = try await repository.getWeather()
            loadStatus = .successfull
        }catch{
            loadStatus = .error(error: error)
        }
    }
     
    @MainActor
    func fetchLocations(for name:String) async{
        fetchStatus = .loading
        locations = []
        do{
            let list = try await repository.fetchLocationList(for: name)
            for location in list{
                let w = try await repository.fetchWeather(for: location.name)
                locations.append(w)
            }
            fetchStatus = .successful
        }catch{
            fetchStatus = .error(error: error)
        }
    }
    
}
