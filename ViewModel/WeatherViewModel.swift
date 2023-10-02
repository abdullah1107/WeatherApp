//
//  WeatherDataModel.swift
//  WeatherApp2019
//
//  Created by Muhammad Mamun on 2/10/23.
//

import Foundation


class WeatherViewModel: ObservableObject {
    
    @Published var weatherInfo = ""
    
    private let weatherService = OpenWeatherMapController(fallbackService: OpenWeatherMapController())
        
    func fetch(city: String) {
        weatherService.fetchWeatherData(for: city, completionHandler: { (info, error) in
            guard error == nil,
                let weatherInfo = info else {
                    DispatchQueue.main.async {
                        self.weatherInfo = "Could not retrieve weather information for \(city)"
                    }
                return
            }
            DispatchQueue.main.async {
                self.weatherInfo = weatherInfo
            }
        })
    }
}
