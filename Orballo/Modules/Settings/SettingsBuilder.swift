//
//  SettingsBuilder.swift
//  Orballo
//
//  Created by Castro, Brais on 30/11/21.
//

import Foundation
import UIKit.UIViewController

final class SettingsBuilder {

    func build() -> UIViewController {

        let viewController: SettingsViewController = SettingsViewController()
        let router: SettingsRouter = SettingsRouter(viewController: viewController)
        let interactor = SettingsInteractor()
        let presenter: SettingsPresenter = SettingsPresenter(viewController: viewController, router: router, interactor: interactor)
        
        viewController.title = "Settings"
        viewController.tabBarItem.image = UIImage(systemName: "ellipsis")
        
        viewController.presenter = presenter
        interactor.presenter = presenter

        return viewController
    }

}
