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
    
    private var pages: [InspectionPage] = []
    private var currentInspectinoStep: Int = 0
    
    private var inspectionBuilder = InspectionBuilder()
    
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
            case .onNext(let inspectionType, let pages):
                self?.currentInspectinoStep = 0
                self?.inspectionBuilder.inspectionType = inspectionType
                self?.pages = pages
                self?.processInpectionFlow()
            }
        }
        
        let vc = BusInspectionTypeConfigurator.configure(output: output)
        set([vc])
    }
    
    private func processInpectionFlow() {
        let page = pages[currentInspectinoStep]
        
        let data = BusInspectionViewModel.ModuleInput(page: page)
        let output = BusInspectionViewModel.ModuleOutput { [weak self] in
            guard let self = self else { return }
            
            switch $0 {
            case .next(let items):
                self.inspectionBuilder.failedIds.append(contentsOf: items)
                
                if self.pages.count == self.container.children.count - 1 {
                    self.showInspectionSubmition()
                } else {
                    self.currentInspectinoStep = self.container.children.count - 1
                    self.processInpectionFlow()
                }
            }
        }
        
        let pageVc = BusInspectionConfigurator.configure(data: data,
                                                         output: output)
        
        push(pageVc)
    }
    
    private func showInspectionSubmition() {
        
    }
}
