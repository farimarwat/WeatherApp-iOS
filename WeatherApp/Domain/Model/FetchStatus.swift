//
//  FetchStatus.swift
//  WeatherApp
//
//  Created by mac on 17/01/2025.
//

import Foundation

enum FetchStatus{
    case notloading
    case loading
    case successful
    case error(error:Error)
}

