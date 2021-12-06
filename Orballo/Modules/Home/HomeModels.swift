//
//  HomeModels.swift
//  Orballo
//
//  Created by Castro, Brais on 28/11/21.
//

import Foundation

enum Home {
    
    struct ViewModel: Equatable {
        let title: String
    }
    
    struct LocationViewModel: Equatable {
        let name: String
        let isCurrentLocation: Bool
        let weatherDescription: String
        let temperature: String
        let locationKey: String
        let added: Date
    }
    
}
