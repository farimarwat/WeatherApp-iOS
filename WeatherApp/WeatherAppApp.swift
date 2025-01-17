//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by mac on 17/01/2025.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var vm = Injector.shared.providesWeatherViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(vm)
        }
    }
}
