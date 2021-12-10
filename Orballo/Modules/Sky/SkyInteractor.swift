//
//  SkyInteractor.swift
//  Orballo
//
//  Created by Castro, Brais on 30/11/21.
//

import Foundation
import CoreLocation

protocol SkyInteractorProtocol {
    func getCurrentLocationAstronomyInfo(viewModel: Sky.ViewModel)
}

protocol SkyInteractorCallbackProtocol {
    func showAstronomyInformation(viewModel: Sky.ViewModel)
}

class SkyInteractor {

    var presenter: SkyInteractorCallbackProtocol!
    
}

extension SkyInteractor: SkyInteractorProtocol {
    
    func getCurrentLocationAstronomyInfo(viewModel: Sky.ViewModel) {
        var vm = viewModel
        let lat = UserDefaults.standard.double(forKey: "Latitude")
        let lon = UserDefaults.standard.double(forKey: "Longitude")
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: lat, longitude: lon)) { p, e in
            if let error = e {
                print(error)
            }
            
            if let placemark = p {
                let city = placemark[0].locality ?? "Unknown"
                vm.location = city
                self.getAstronomyInfo(viewModel: vm, latitude: lat, longitude: lon)
            }
        }
        
    }
    
    func getAstronomyInfo(viewModel: Sky.ViewModel, latitude: Double, longitude: Double) {
        var vm = viewModel
        WeatherApiService.shared.astronomy(latitude: latitude, longitude: longitude) { astro in
            vm.sunrise = astro.sunrise
            vm.sunset = astro.sunset
            vm.moonrise = astro.moonrise
            vm.moonset = astro.moonset
            self.presenter.showAstronomyInformation(viewModel: vm)
        } failure: { error in
            print(error)
        }
    }
    
}
