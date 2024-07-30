//
//  APIEndPoint.swift
//  WeatherApp
//
//  Created by Vishal Manhas on 19/06/24.
//

import Foundation

enum APIEndPoint {
    
    static let baseURL = "https://api.openweathermap.org"

    case coordinatesByLocationName(String)
    case locationByLatLon(Double, Double)

    private var pathString: String {
        switch self {
        case .coordinatesByLocationName(let city):
            return "/geo/1.0/direct?q=\(city)&appid=\(Constants.Keys.weatherAPIkey)"
        case .locationByLatLon(let lat, let lon):
            return "/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(Constants.Keys.weatherAPIkey)"
        }
    }

    static func endpointURL(for endpoint: APIEndPoint) -> URL {
        return URL(string: baseURL + endpoint.pathString)!
    }
}
