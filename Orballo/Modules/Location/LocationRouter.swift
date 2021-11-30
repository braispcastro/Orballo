//
//  LocationRouter.swift
//  Orballo
//
//  Created by Castro, Brais on 29/11/21.
//

import Foundation
import UIKit.UIViewController

protocol LocationRouterProtocol {
    
}

class LocationRouter: LocationRouterProtocol {
    
    unowned let viewController: UIViewController
    
    internal var navigationController: UINavigationController? {
        return viewController.navigationController
    }
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }

}
