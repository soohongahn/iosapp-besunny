//
//  Weather.swift
//  WeeklyWeather
//
//  Created by soohong ahn on 2021/08/13.
//

import Foundation

public struct Weather{
    let city: String

    let temp: String
    let temp_min: String
    let temp_max: String
    let feels_like: String

    let id: Int
    let description: String
    
    init(response: APIResponse){
        city = response.name
        temp = "\(Int(response.main.temp))"
        temp_min = "\(Int(response.main.temp_min))"
        temp_max = "\(Int(response.main.temp_max))"
        feels_like = "\(Int(response.main.feels_like))"

        description = response.weather.first?.description ?? ""
        id = response.weather.first?.id ?? 0
    }
}
