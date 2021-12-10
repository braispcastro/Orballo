//
//  SkyPresenter.swift
//  Orballo
//
//  Created by Castro, Brais on 30/11/21.
//

import Foundation

protocol SkyViewControllerProtocol {
    func show(viewModel: Sky.ViewModel)
}

protocol SkyPresenterProtocol {
    func prepareView()
}

final class SkyPresenter {

    let interactor: SkyInteractorProtocol
    let viewController: SkyViewControllerProtocol
    let router: SkyRouterProtocol
    
    init(viewController: SkyViewControllerProtocol,
         router: SkyRouterProtocol,
         interactor: SkyInteractorProtocol) {
            self.viewController = viewController
            self.router = router
            self.interactor = interactor
        }
    
}

extension SkyPresenter: SkyPresenterProtocol {
    
    func prepareView() {
        let viewModel = Sky.ViewModel(title: "Astronomy",
                                      location: "",
                                      sunrise: "",
                                      sunset: "",
                                      moonrise: "",
                                      moonset: "")
        LocationManager.shared.startUpdatingLocation()
        interactor.getCurrentLocationAstronomyInfo(viewModel: viewModel)
    }
    
}

extension SkyPresenter: SkyInteractorCallbackProtocol {
    
    func showAstronomyInformation(viewModel: Sky.ViewModel) {
        viewController.show(viewModel: viewModel)
    }
    
}
