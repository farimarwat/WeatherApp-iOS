//
//  LocationView.swift
//  WeatherApp
//
//  Created by mac on 19/01/2025.
//

import SwiftUI

struct LocationView: View {
    let weather:WeatherResponse
    let onTap:(WeatherResponse) -> Void
    var body: some View {
        ZStack{
            Image("itembackground")
                .resizable()
                .scaledToFit()
            HStack(spacing: 50){
                VStack{
                    Text(weather.location.name)
                        .font(.title2)
                    Text(String(weather.details.tempC))
                        .font(.title3)
                    Text(weather.details.condition.text)
                }
                VStack{
                    AsyncImage(url: weather.details.condition.iconUrl) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width:150)
                    } placeholder: {
                        ProgressView()
                    }

                }
            }
            .frame(maxWidth:.infinity)
        }
        .foregroundColor(Color.white)
        .background(Color("ColorPurple"))
        .clipShape(.rect(cornerRadius: 20))
        .shadow(radius: 20)
        .frame(maxWidth:.infinity)
        .padding()
        .onTapGesture {
            onTap(weather)
        }
    }
}

#Preview {
    let data = """
    {
        "location": {
            "name": "London",
            "region": "City of London, Greater London",
            "country": "United Kingdom",
            "lat": 51.5171,
            "lon": -0.1062,
            "tz_id": "Europe/London",
            "localtime_epoch": 1737268001,
            "localtime": "2025-01-19 06:26"
        },
        "current": {
            "last_updated_epoch": 1737267300,
            "last_updated": "2025-01-19 06:15",
            "temp_c": 3.3,
            "temp_f": 37.9,
            "is_day": 0,
            "condition": {
                "text": "Overcast",
                "icon": "//cdn.weatherapi.com/weather/64x64/night/122.png",
                "code": 1009
            },
            "wind_mph": 5.8,
            "wind_kph": 9.4,
            "wind_degree": 171,
            "wind_dir": "S",
            "pressure_mb": 1021.0,
            "pressure_in": 30.15,
            "precip_mm": 0.0,
            "precip_in": 0.0,
            "humidity": 81,
            "cloud": 100,
            "feelslike_c": 0.8,
            "feelslike_f": 33.4,
            "windchill_c": 0.6,
            "windchill_f": 33.1,
            "heatindex_c": 3.1,
            "heatindex_f": 37.7,
            "dewpoint_c": -1.7,
            "dewpoint_f": 29.0,
            "vis_km": 10.0,
            "vis_miles": 6.0,
            "uv": 0.0,
            "gust_mph": 8.3,
            "gust_kph": 13.4
        }
    }
    """.data(using: .utf8)!
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    if let weather = try? decoder.decode(WeatherResponse.self, from: data){
        return LocationView(weather: weather) {item in }
    } else {
        return Text("No data found")
    }
}
