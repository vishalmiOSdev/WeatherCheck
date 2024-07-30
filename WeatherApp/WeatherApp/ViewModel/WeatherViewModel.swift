//
//  WeatherClient.swift
//  WeatherApp
//
//  Created by Vishal Manhas on 19/06/24.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var coordinates: [GeoCoderModel] = []
    @Published var weatherResponse: WeatherResponse?
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false
    
    func fetchWeather(location: [GeoCoderModel]) async {
        guard let lat = location.first?.lat, let lon = location.first?.lon else {
            errorMessage = "Invalid coordinates"
            return
        }
        
        let url = APIEndPoint.endpointURL(for: .locationByLatLon(lat, lon))
        
        isLoading = true
        do {
            let result: WeatherResponse = try await Webservice().doRequest(url: url)
            weatherResponse = result
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }

    func getCoordinatesByCity(_ city: String) async {
        let url = APIEndPoint.endpointURL(for: .coordinatesByLocationName(city))
        
        isLoading = true
        do {
            let result: [GeoCoderModel] = try await Webservice().doRequest(url: url)
            await fetchWeather(location: result)
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}

