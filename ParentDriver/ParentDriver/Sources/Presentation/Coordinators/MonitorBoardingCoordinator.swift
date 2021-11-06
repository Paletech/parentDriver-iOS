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
            case .onAdd(let completion):
                self?.showAddAStudent(completion: completion)
            }
        }))
        
        set([monitorBoardingVc])
    }
    
    private func showAddAStudent(completion: @escaping EmptyClosure) {
        let output = AddStudentViewModel.ModuleOutput { [weak self] in
            switch $0 {
            case .added:
                self?.pop()
            }
        }
        
        let data = AddStudentViewModel.ModuleInput(completion: completion)
        
        let addStudentVc = AddStudentConfigurator.configure(data: data, output: output)
        push(addStudentVc)
    }
}
