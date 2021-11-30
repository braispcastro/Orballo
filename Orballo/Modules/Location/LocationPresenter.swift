//
//  LocationPresenter.swift
//  Orballo
//
//  Created by Castro, Brais on 29/11/21.
//

import Foundation

protocol LocationViewControllerProtocol {
    func show(viewModel: Location.ViewModel)
}

protocol LocationPresenterProtocol {
    func prepareView()
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
        let viewModel = Location.ViewModel()
        viewController.show(viewModel: viewModel)
    }
    
}

extension LocationPresenter: LocationInteractorCallbackProtocol {
    
}
