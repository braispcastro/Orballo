//
//  HomePresenter.swift
//  Orballo
//
//  Created by Castro, Brais on 28/11/21.
//

import Foundation

protocol HomeViewControllerProtocol {
    func show(viewModel: Home.ViewModel)
    func showLocations(locations: [Home.LocationViewModel])
}

protocol HomePresenterProtocol {
    func prepareView()
    func getLocationsToShow()
    func locationToDelete(locationViewModel: Home.LocationViewModel)
}

final class HomePresenter {

    let interactor: HomeInteractorProtocol
    let viewController: HomeViewControllerProtocol
    let router: HomeRouterProtocol
    
    init(viewController: HomeViewControllerProtocol,
         router: HomeRouterProtocol,
         interactor: HomeInteractorProtocol) {
            self.viewController = viewController
            self.router = router
            self.interactor = interactor
        }
    
}

extension HomePresenter: HomePresenterProtocol {
    
    func prepareView() {
        let viewModel = Home.ViewModel(title: "Orballo")
        LocationManager.shared.startUpdatingLocation()
        viewController.show(viewModel: viewModel)
    }
    
    func getLocationsToShow() {
        interactor.createLocationList()
    }
    
    func locationToDelete(locationViewModel: Home.LocationViewModel) {
        interactor.deleteLocation(locationViewModel: locationViewModel)
    }
}

extension HomePresenter: HomeInteractorCallbackProtocol {
    
    func showLocationList(locations: [Home.LocationViewModel]) {
        viewController.showLocations(locations: locations)
    }
    
}
