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
        let output = SignUpViewModel.ModuleOutput { [weak self] in
            switch $0 {
            case .onSignedUp:
                self?.showSignedUpAlert()
            }
        }
        
        let signUpVc = SignUpConfigurator.configure(output: output)
        self.push(signUpVc, animated: true)
    }
    
    private func showSignedUpAlert() {
        let alert = UIAlertController(title: Localizable.sign_up_alert_message(), message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localizable.sign_up_alert_button(), style: .default, handler: { [weak self] _  in
            self?.pop()
        }))

        container.present(alert, animated: true)
    }
}
