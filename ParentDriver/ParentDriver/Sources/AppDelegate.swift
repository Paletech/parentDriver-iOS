//
//  AppDelegate.swift
//  ParentDriver
//
//  Created by Pavel Reva on 20.10.2021.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        resolveThirdParty()
        resolveDependencies()
        resolveNavigationStack()
        
        return true
    }
    
    private func resolveDependencies() {
        DependencyProvider.configure()
    }
    
    private func resolveNavigationStack() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        appCoordinator = AppCoordinator(container: window!)
        appCoordinator.start()
        window?.makeKeyAndVisible()
    }
    
    private func resolveThirdParty() {
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
}

