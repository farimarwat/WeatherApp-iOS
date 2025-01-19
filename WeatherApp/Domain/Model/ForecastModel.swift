//
//  ForecastModel.swift
//  WeatherApp
//
//  Created by mac on 24/01/2025.
//

import Foundation

struct ForecastModel{
    let time:String
    let tempC:Float
    let conditionText:String
    let icon:String
    
    var iconUrl :URL {
        URL(string:"https:\(icon)")!
    }
    
    var timeFormatted:String{
        let parts = time.split(separator: " ")
        if parts.count == 2 {
            return String(parts[1])
        } else {
            return time
        }
    }
}
