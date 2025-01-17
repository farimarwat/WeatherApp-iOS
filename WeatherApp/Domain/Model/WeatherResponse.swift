//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by mac on 17/01/2025.
//

import Foundation

struct WeatherResponse: Codable, Identifiable{
    let location:Location
    let details:Details
    
    var id:String{
        "\(location.lat)-\(location.lon)"
    }
    
    struct Location: Codable{
        let name:String
        let region:String
        let country:String
        let lat:Double
        let lon:Double
    }
    
    struct Details:Codable{
        let tempC:Float
        let tempF:Float
        let isDay:Int
        let condition:Condition
        let windMph:Float
        let windKph:Float
        let windDegree:Float
        let windDir:String
        let pressureMb:Float
        let pressureIn:Float
        let precipMm:Float
        let precipIn:Float
        let humidity:Int
        let cloud:Int
        let feelslikeC:Float
        let feelslikeF:Float
        let windchillC:Float
        let windchillF:Float
        let heatindexC:Float
        let heatindexF:Float
        let uv:Float
        
        struct Condition:Codable{
            let text:String
            let icon:String
            let code:Int
            
            var iconUrl :URL {
                URL(string:"https:\(icon)")!
            }
        }
    }
    
    enum CodingKeys:String,CodingKey{
        case location
        case details = "current"
    }
}
