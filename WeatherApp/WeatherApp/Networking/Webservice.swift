//
//  GeoCodingClients.swift
//  WeatherApp
//
//  Created by Vishal Manhas on 19/06/24.
//

import Foundation

class Webservice {
    func doRequest<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingError
        }
    }
}

enum NetworkError: Error {
    case invalidResponse
    case noData
    case decodingError
}
