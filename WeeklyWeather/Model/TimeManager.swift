//
//  TimeManager.swift
//  WeeklyWeather
//
//  Created by soohong ahn on 2021/08/15.
//

import Foundation

public class TimeManager {
    let date: Date
    let calendar: Calendar
    let hour: Int
    
    init(){
        date = Date()
        calendar = Calendar.current
        hour = calendar.component(.hour, from: date)
    }
}
