//
//  LocationModels.swift
//  Orballo
//
//  Created by Castro, Brais on 29/11/21.
//

import Foundation

enum Location {
    
    struct ViewModel: Equatable {
        let latitude: Double
        let longitude: Double
    }
    
    struct PlaceViewModel: Equatable {
        let country: String
        let state: String
        let city: String
        let zipcode: String
        let latitude: Double
        let longitude: Double
    }
}
