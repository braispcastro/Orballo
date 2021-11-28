//
//  HomeBuilder.swift
//  Orballo
//
//  Created by Castro, Brais on 28/11/21.
//

import Foundation
import UIKit.UIViewController

final class HomeBuilder {

    func build() -> UIViewController {

        let viewController: HomeViewController = HomeViewController()
        let router: HomeRouter = HomeRouter(viewController: viewController)
        let interactor = HomeInteractor()
        let presenter: HomePresenter = HomePresenter(viewController: viewController, router: router, interactor: interactor)
        
        viewController.presenter = presenter
        interactor.presenter = presenter

        return viewController
    }

}
