//
//  AccuweatherModels.swift
//  Orballo
//
//  Created by Castro, Brais on 5/12/21.
//

import Foundation

struct Geoposition: Decodable {
    let Key: String
}

struct CurrentConditions: Decodable {
    let WeatherText: String
    let HasPrecipitation: Bool
    let IsDayTime: Bool
    let Temperature: TemperatureSystem
}

struct TemperatureSystem: Decodable {
    let Metric: Temperature
    let Imperial: Temperature
}

struct Temperature: Decodable {
    let Value: Double
    let Unit: String
}
