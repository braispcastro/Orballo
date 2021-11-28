//
//  HomeRouter.swift
//  Orballo
//
//  Created by Castro, Brais on 28/11/21.
//

import Foundation
import UIKit.UIViewController

protocol HomeRouterProtocol {
    
}

class HomeRouter: HomeRouterProtocol {
    
    unowned let viewController: UIViewController
    
    internal var navigationController: UINavigationController? {
        return viewController.navigationController
    }
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }

}
