//
//  GeoCoderModel.swift
//  WeatherApp
//
//  Created by Vishal Manhas on 19/06/24.
//

import Foundation

struct GeoCoderModel: Codable {
    let name: String?
    let localNames: [String: String]?
    let lat, lon: Double?
    let country, state: String?

    enum CodingKeys: String, CodingKey {
        case name
        case localNames = "local_names"
        case lat, lon, country, state
    }
}

