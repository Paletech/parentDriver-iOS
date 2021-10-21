//
//  AppDelegate.swift
//  ParentDriver
//
//  Created by Pavel Reva on 20.10.2021.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        DependencyProvider.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        IQKeyboardManager.shared.enable = true
        
        appCoordinator = AppCoordinator(container: window!)
        appCoordinator.start()
        window?.makeKeyAndVisible()
        
        return true
    }
}

