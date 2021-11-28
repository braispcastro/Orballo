//
//  AppDelegate.swift
//  Orballo
//
//  Created by Castro, Brais on 28/11/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                    
            let homeViewController = HomeBuilder().build()
            let backButtonImage = UIImage(systemName: "arrow.backward")
            
            let navController = UINavigationController(rootViewController: homeViewController)
            navController.navigationBar.backIndicatorImage = backButtonImage
            navController.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
            navController.navigationBar.prefersLargeTitles = true
            
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = navController
            self.window?.makeKeyAndVisible()
            
            return true
        }


}

