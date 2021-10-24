//
//  AuthCoordinator.swift
//  ParentDriver
//
//  Created by Pavel Reva on 21.10.2021.
//

import Foundation
import UIKit

class AuthCoordinator: NavigationCoordinator {
    
    struct Output {
        let authorized: EmptyClosure
    }
    
    let output: Output
    
    // MARK: - Init/Deinit
    
    init(navigationController: UINavigationController, output: Output) {
        self.output = output
        super.init(container: navigationController)
    }
    
    // MARK: - Logic
    
    override func start() {
        showSignIn()
    }
    
    private func showSignIn() {
        let output = SignInViewModel.ModuleOutput { [weak self] in
            switch $0 {
            case .onSignUp:
                self?.showSignUp()
            case .onSignedIn:
                self?.output.authorized()
            }
        }
        
        let signInVc = SignInConfigurator.configure(output: output)
        set([signInVc])
    }
    
    private func showSignUp() {
        // TODO: push signUp vc here
    }
}
