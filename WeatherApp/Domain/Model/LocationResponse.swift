//
//  LocationResponse.swift
//  WeatherApp
//
//  Created by mac on 17/01/2025.
//

import Foundation

struct LocationResponse:Codable{
    let id:Int
    let name:String
    let region:String
    let country:String
    let lat:Double
    let lon:Double
    let url:String
}
