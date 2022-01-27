//
//  ViewModel.swift
//  WeatherToday
//
//  Created by soohong ahn on 2021/08/12.
//

import Foundation

public class ViewModel: ObservableObject {
    @Published var city: String = "CITY NAME"
    @Published var temp: String = "--"
    @Published var temp_min: String = "--"
    @Published var temp_max: String = "--"
    @Published var feels_like: String = "--"
    @Published var iconName: String = "800"
    @Published var id: Int = 0
    @Published var description: String = "--"

    public let weatherService: WeatherService
 
    public init(weatherService: WeatherService){
        self.weatherService = weatherService
    }
    
    public func refresh(){
        weatherService.loadWeatherData{weather in
            DispatchQueue.main.async {
                self.city = weather.city
                self.temp = weather.temp
                self.temp_min = weather.temp_min
                self.temp_max = weather.temp_max
                self.feels_like = weather.feels_like
                self.id = weather.id
                self.iconName = self.editIconName(originalID: String(weather.id))
                self.description = weather.description
            }
        }
    }
    
    public func convertCtoF(tempC: String) -> String{
        String(Int((Double(tempC) ?? 0 * 1.8) + 32))
    }
    
    public func changeIconToDark(originalID: String, darkMode: Bool) -> String{
        if (darkMode && (originalID == "500" || originalID == "800" || originalID == "801")){
            return originalID + "_n"
        } else {
            return originalID
        }
    }
    
    public func editIconName(originalID : String) -> String{
        let firstNum = Int(originalID.prefix(1))
        
        switch firstNum {
        case 2:
            return "200"
        case 3:
            return "300"
        case 5:
            if (Int(originalID) ?? 500 < 505) {
                return "500"
            } else if (Int(originalID) ?? 500 > 511) {
                return "520"
            } else {
                return "600"
            }
        case 6:
            return "600"
        case 7:
            return "700"
        case 8:
            if (originalID == "804" || originalID == "803") {
                return "803"
            } else {
                return originalID
            }
        default:
            return "800"
        }
    }
}

