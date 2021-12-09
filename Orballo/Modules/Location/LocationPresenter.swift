//
//  LocationPresenter.swift
//  Orballo
//
//  Created by Castro, Brais on 29/11/21.
//

import Foundation

protocol LocationViewControllerProtocol {
    func show(viewModel: Location.ViewModel)
    func askForConfirmationToAddLocation(placeViewModel: Location.PlaceViewModel)
}

protocol LocationPresenterProtocol {
    func prepareView()
    func getLocationInformation(latitude: Double, longitude: Double)
    func saveLocation(placeViewModel: Location.PlaceViewModel)
}

final class LocationPresenter {

    let interactor: LocationInteractorProtocol
    let viewController: LocationViewControllerProtocol
    let router: LocationRouterProtocol
    
    init(viewController: LocationViewControllerProtocol,
         router: LocationRouterProtocol,
         interactor: LocationInteractorProtocol) {
            self.viewController = viewController
            self.router = router
            self.interactor = interactor
        }
    
}

extension LocationPresenter: LocationPresenterProtocol {
    
    func prepareView() {
        LocationManager.shared.startUpdatingLocation()
        let lat = UserDefaults.standard.double(forKey: "Latitude")
        let lon = UserDefaults.standard.double(forKey: "Longitude")
        let viewModel = Location.ViewModel(latitude: lat, longitude: lon)
        viewController.show(viewModel: viewModel)
    }
    
    func getLocationInformation(latitude: Double, longitude: Double) {
        interactor.getLocationInformation(latitude: latitude, longitude: longitude)
    }
    
    func saveLocation(placeViewModel: Location.PlaceViewModel) {
        interactor.saveLocation(placeViewModel: placeViewModel)
    }
    
}

extension LocationPresenter: LocationInteractorCallbackProtocol {
    func askForConfirmationToAddLocation(placeViewModel: Location.PlaceViewModel) {
        viewController.askForConfirmationToAddLocation(placeViewModel: placeViewModel)
    }
}
