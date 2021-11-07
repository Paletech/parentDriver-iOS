//
//  InspectionCoordinator.swift
//  ParentDriver
//
//  Created by Pavel Reva on 06.11.2021.
//

import UIKit

class InspectionCoordinator: NavigationCoordinator {
    
    struct Output {
        let showMenu: EmptyClosure
    }
    
    let output: Output
    
    // MARK: - Init/Deinit
    
    init(container: UINavigationController, output: Output) {
        self.output = output
        super.init(container: container)
    }
    
    override func start() {
        showInspectionType()
    }
    
    private func showInspectionType() {
        let output = BusInspectionTypeViewModel.ModuleOutput { [weak self] in
            switch $0 {
            case .showMenu:
                self?.output.showMenu()
            case .onNext:
                self?.showInspectionFlow()
            }
        }
        
        let vc = BusInspectionTypeConfigurator.configure(output: output)
        set([vc])
    }
    
    private func showInspectionFlow() {
        
    }
}
