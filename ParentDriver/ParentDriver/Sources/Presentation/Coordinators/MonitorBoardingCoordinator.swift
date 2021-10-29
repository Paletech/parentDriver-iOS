//
//  MonitorBoardingCoordinator.swift
//  ParentDriver
//
//  Created by Pavel Reva on 28.10.2021.
//

import UIKit

class MonitorBoardingCoordinator: NavigationCoordinator {
    
    struct Output {
        let showMenu: EmptyClosure
    }
    
    let output: Output
    
    // MARK: - Init/Deinit
    
    init(container: UINavigationController, output: Output) {
        self.output = output
        super.init(container: container)
    }
    
    // MARK: - Base overrides
    
    override func start() {
        showMonitorBoarding()
    }
    
    private func showMonitorBoarding() {
        let monitorBoardingVc = MonitorBoardingConfigurator.configure(output: MonitorBoardingViewModel.ModuleOutput(action: { [weak self] in
            switch $0 {
            case .onShowMenu:
                self?.output.showMenu()
            case .onAdd:
                self?.showAddAStudent()
            }
        }))
        
        set([monitorBoardingVc])
    }
    
    private func showAddAStudent() {
        let addStudentVc = AddStudentConfigurator.configure()
        push(addStudentVc)
    }
}
