//
//  AuthCoordinator.swift
//  ParentDriver
//
//  Created by Pavel Reva on 21.10.2021.
//

import Foundation

class AuthCoordinator: NavigationCoordinator {
    
    override func start() {
        showSignIn()
    }
    
    private func showSignIn() {
        let signInVc = SignInConfigurator.configure()
        set([signInVc])
    }
}
