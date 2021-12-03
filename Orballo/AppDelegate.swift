//
//  AppDelegate.swift
//  Orballo
//
//  Created by Castro, Brais on 28/11/21.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        let homeViewController = HomeBuilder().build()
        let locationViewController = LocationBuilder().build()
        let skyViewController = SkyBuilder().build()
        let settingsViewController = SettingsBuilder().build()
        let mainTabBarViewController = UITabBarController()
        mainTabBarViewController.setViewControllers([
            homeViewController,
            locationViewController,
            skyViewController,
            settingsViewController
        ], animated: true)
        
        let navController = UINavigationController(rootViewController: mainTabBarViewController)
        let backButtonImage = UIImage(systemName: "arrow.backward")
        navController.navigationBar.backIndicatorImage = backButtonImage
        navController.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        navController.navigationBar.prefersLargeTitles = true
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    // MARK: - Core Data stack

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

