//
//  LocationBuilder.swift
//  Orballo
//
//  Created by Castro, Brais on 29/11/21.
//

import Foundation
import UIKit.UIViewController

final class LocationBuilder {

    func build() -> UIViewController {

        let viewController: LocationViewController = LocationViewController()
        let router: LocationRouter = LocationRouter(viewController: viewController)
        let interactor = LocationInteractor()
        let presenter: LocationPresenter = LocationPresenter(viewController: viewController, router: router, interactor: interactor)
        
        viewController.title = "Location"
        viewController.tabBarItem.image = UIImage(systemName: "map")
        
        viewController.presenter = presenter
        interactor.presenter = presenter

        return viewController
    }

}
