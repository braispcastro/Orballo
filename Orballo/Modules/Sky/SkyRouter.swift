//
//  SkyRouter.swift
//  Orballo
//
//  Created by Castro, Brais on 30/11/21.
//

import Foundation
import UIKit.UIViewController

protocol SkyRouterProtocol {
    
}

class SkyRouter: SkyRouterProtocol {
    
    unowned let viewController: UIViewController
    
    internal var navigationController: UINavigationController? {
        return viewController.navigationController
    }
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }

}
