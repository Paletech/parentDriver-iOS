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
        setDashboard()
    }
    
    // MARK: - Navigation
    
    private func setDashboard() {
        let dashboardVc = DashboardConfigurator.configure(output: DashboardViewModel.ModuleOutput(action: { [weak self] in
            switch $0 {
            case .showMenu:
                self?.showMenu()
            case .showMenuItem(let item):
                self?.validateMenuItem(item)
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
        currentChild = controller
    }
    
    private func removeCurrentChild() {
        currentChild.flatMap { remove($0) }
    }
    
    // MARK: - SideMenu
    
    private func showMenu() {
        let menuRoot = MenuConfigurator.configure(output: MenuViewModel.ModuleOutput(action: { [weak self] in
            switch $0 {
            case .onItemSelected(let item):
                self?.validateMenuItem(item)
            }
            
            self?.container.presentedViewController?.dismiss(animated: true, completion: nil)
        }))
        
        let sideMenu = configureSideMenu(with: menuRoot)
        container.present(sideMenu, animated: true, completion: nil)
    }
    
    private func configureSideMenu(with controller: UIViewController) -> SideMenuNavigationController {
        let sideMenu = SideMenuNavigationController(rootViewController: controller)
        
        sideMenu.setNavigationBarHidden(true, animated: false)
        sideMenu.leftSide = true
        sideMenu.presentationStyle = .menuSlideIn
        sideMenu.presentationStyle.presentingEndAlpha = 0.5
        
        return sideMenu
    }
    
    private func validateMenuItem(_ item: MenuItem) {
        switch item {
        case .logout:
            onLogout()
        case .changeBus:
            setChangeBus()
        case .busInspection:
            setBusInspection()
        case .ridersheepChanges:
            setRidersheepChanges()
        case .dashboard:
            setDashboard()
        case .monitorBoarding:
            setMonitorBoarding()
        }
    }
}
