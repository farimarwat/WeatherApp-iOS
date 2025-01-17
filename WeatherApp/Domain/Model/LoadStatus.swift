//
//  LoadStatus.swift
//  WeatherApp
//
//  Created by mac on 19/01/2025.
//

import Foundation

enum LoadStatus{
    case notLoading
    case loading
    case successfull
    case error(error:Error)
}
