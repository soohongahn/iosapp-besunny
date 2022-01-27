//
//  WeatherService.swift
//  WeeklyWeather
//
//  Created by soohong ahn on 2021/08/13.
//

import Foundation
import CoreLocation

public final class WeatherService: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private let API_KEY = "fec62558fb29751d2d07ba7dd518f0a8"
    private var completionHandler: ((Weather) -> Void)?
    
    public override init(){
        super.init()
        locationManager.delegate = self
    }
    
    // Func for loading weather data
    public func loadWeatherData(_ completionHandler: @escaping((Weather) -> Void)){
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    // Get current location
    public func locationManager (_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.first else { return }
        requestWeatherData(forCoordinates: location.coordinate)
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error){
        print("Failed to get current location: \(error.localizedDescription)")
    }
    
    // Get Weather Data
    private func requestWeatherData(forCoordinates coordinates: CLLocationCoordinate2D) {
        // Create url Object
        guard let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return}
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for error
            guard error == nil, let data = data else {return}
            // Parse data
            if let response = try? JSONDecoder().decode(APIResponse.self, from: data) {
                self.completionHandler?(Weather(response: response))
            }
        }.resume()
    }
}

struct APIResponse: Decodable {
    let name: String    // City Name
    let main: tempInfo  // Temperature Information
    let weather: [weatherInfo]
}

struct tempInfo: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
}

struct weatherInfo: Decodable {
    let description: String
    let id: Int
}

