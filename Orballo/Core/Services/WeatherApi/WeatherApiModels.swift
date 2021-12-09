//
//  WeatherApiModels.swift
//  Orballo
//
//  Created by Castro, Brais on 9/12/21.
//

import Foundation

struct Weather: Decodable {
    let current: Current
}

struct Current: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case celsius = "temp_c"
        case fahrenheit = "temp_f"
        case isDay = "is_day"
        case humidity
        case cloud
        case condition
    }
    
    let celsius: Double
    let fahrenheit: Double
    let isDay: Int
    let humidity: Double
    let cloud: Double
    let condition: Condition
}

struct Condition: Decodable {
    let text: String
    let icon: String
    let code: Int
}
