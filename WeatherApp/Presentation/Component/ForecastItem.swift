//
//  ForecastItem.swift
//  WeatherApp
//
//  Created by mac on 24/01/2025.
//

import SwiftUI

struct ForecastItem: View {
    let item:ForecastModel
    var body: some View {
        VStack{
            Text(String(item.tempC))
            AsyncImage(url: item.iconUrl) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
            } placeholder: {
                ProgressView()
            }
            Text(item.timeFormatted)
        }
        .padding()
        .background(Color.gray)
        .clipShape(.rect(cornerRadius: 20))
        .foregroundColor(Color.white)
    }
}

#Preview {
    let forecastModel = ForecastModel(
        time: "2024-04-01 03:44",
        tempC: 32.0,
        conditionText: "Cloudy",
        icon: "//cdn.weatherapi.com/weather/64x64/night/122.png"
    )
    ForecastItem(item: forecastModel)
}
