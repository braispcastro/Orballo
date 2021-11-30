//
//  SkyBuilder.swift
//  Orballo
//
//  Created by Castro, Brais on 30/11/21.
//

import Foundation
import UIKit.UIViewController

final class SkyBuilder {

    func build() -> UIViewController {

        let viewController: SkyViewController = SkyViewController()
        let router: SkyRouter = SkyRouter(viewController: viewController)
        let interactor = SkyInteractor()
        let presenter: SkyPresenter = SkyPresenter(viewController: viewController, router: router, interactor: interactor)
        
        viewController.title = "Sky"
        viewController.tabBarItem.image = UIImage(systemName: "sun.max")
        
        viewController.presenter = presenter
        interactor.presenter = presenter

        return viewController
    }

}
