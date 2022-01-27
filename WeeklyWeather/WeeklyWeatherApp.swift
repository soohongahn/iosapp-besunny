//
//  WeeklyWeatherApp.swift
//  WeeklyWeather
//
//  Created by soohong ahn on 2021/08/13.
//

import SwiftUI

@main
struct WeeklyWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            let weatherService = WeatherService()
            let viewModel = ViewModel(weatherService: weatherService)
            ContentView(viewModel: viewModel)
        }
    }
}
