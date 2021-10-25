//
//  MenuCoordinator.swift
//  ParentDriver
//
//  Created by Pavel Reva on 25.10.2021.
//

import SideMenu
import UIKit

class MenuCoordinator: ViewControllerCoordinator {
    
    private var currentChild: UIViewController?
    
    override func start() {
        removeCurrentChild()
        setDashboard()
    }
        
    func showMenu() {
        let menuRoot = MenuConfigurator.configure(output: MenuViewModel.ModuleOutput(action: { [weak self] in
            switch $0 {
            case .onItemSelected(let item):
                            
                switch item {
                case .logout:
                    self?.onLogout()
                case .changeBus:
                    self?.setChangeBus()
                case .busInspection:
                    self?.setBusInspection()
                case .ridersheepChanges:
                    self?.setRidersheepChanges()
                case .dashboard:
                    self?.setDashboard()
                case .monitorBoarding:
                    self?.setMonitorBoarding()
                }
            }
            
            self?.container.presentedViewController?.dismiss(animated: true, completion: nil)
        }))
        
        let sideMenu = SideMenuNavigationController(rootViewController: menuRoot)
        sideMenu.setNavigationBarHidden(true, animated: false)
        sideMenu.leftSide = true
        sideMenu.presentationStyle = .menuSlideIn
        sideMenu.presentationStyle.presentingEndAlpha = 0.5
        
        container.present(sideMenu, animated: true, completion: nil)
    }
    
    private func setDashboard() {
        let dashboardVc = DashboardConfigurator.configure(output: DashboardViewModel.ModuleOutput(action: { [weak self] in
            switch $0 {
            case .showMenu:
                self?.showMenu()
            }
        }))
        
        setController(dashboardVc)
    }
    
    private func setRidersheepChanges() {
        
    }
    
    private func setBusInspection() {
        
    }
    
    private func setMonitorBoarding() {
        
    }
    
    private func setChangeBus() {
        let selectBusVc = SelectBusConfigurator.configure(output: SelectBusViewModel.ModuleOutput(action: { [weak self] in
            switch $0 {
            case .busSelected:
                self?.setDashboard()
            }
        }))
        
        setController(selectBusVc)
    }
    
    private func onLogout() {
        
    }
    
    private func setController(_ controller: UIViewController) {
        removeCurrentChild()
        if currentChild != controller {
            let navigation = UINavigationController(rootViewController: controller)
            add(navigation)
        }
    }
    
    private func removeCurrentChild() {
        currentChild.flatMap { removeChild($0) }
    }
}
