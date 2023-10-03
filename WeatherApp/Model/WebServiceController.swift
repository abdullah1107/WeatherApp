//
//  WebServiceController.swift
//  WeatherApp
//
//  Created by Muhammad Mamun on 2/10/23.
//

import Foundation

public protocol WebServiceController {
    init(fallbackService: WebServiceController?)
    
    var fallbackService: WebServiceController? { get }
    
    func fetchWeatherData(for city: String,
                          completionHandler: @escaping(String?, WebServiceControllerError?) -> Void)
}

// MARK: - WebServiceControllerError
public enum WebServiceControllerError: Error {
    case invalidURL(String)
    case invalidPayload(URL)
    case forwarded(Error)
}
