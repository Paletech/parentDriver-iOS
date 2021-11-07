//
//  MenuCoordinator.swift
//  ParentDriver
//
//  Created by Pavel Reva on 25.10.2021.
//

import SideMenu
import UIKit

class MenuCoordinator: ViewControllerCoordinator {
        
    struct Output {
        var logout: EmptyClosure
    }

    var output: Output

    // MARK: - Init/Deinit

    init(container: UIViewController, output: Output) {
        self.output = output
        super.init(container: container)
    }

    override func start() {
        setDashboard()
    }
    
    // MARK: - Navigation
    
    private func setDashboard() {
        childs.removeAll()

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
        childs.removeAll()

        let ridersheepChangesCoordinator = RidersheepChangesConfigurator.configure(output: RidersheepChangesViewModel.ModuleOutput(action: { [weak self] in
            switch $0 {
            case .showMenu:
                self?.showMenu()
            }
        }))

        setController(ridersheepChangesCoordinator)
    }
    
    private func setBusInspection() {
        childs.removeAll()
        
        let busInspectionCoordinator = InspectionCoordinator(container: UINavigationController(),
                                                             output: InspectionCoordinator.Output(showMenu: { [weak self] in
            self?.showMenu()
        }))
        addChild(busInspectionCoordinator)
        
        busInspectionCoordinator.start()
        setController(busInspectionCoordinator.container)
    }
    
    private func setMonitorBoarding() {
        childs.removeAll()

        let monitorBoardingCoordinator = MonitorBoardingCoordinator(container: UINavigationController(),
                                                                    output: MonitorBoardingCoordinator.Output(showMenu: { [weak self] in
            self?.showMenu()
        }))
        addChild(monitorBoardingCoordinator)

        monitorBoardingCoordinator.start()
        setController(monitorBoardingCoordinator.container)
    }
    
    private func setChangeBus() {
        childs.removeAll()

        let selectBusVc = SelectBusConfigurator.configure(output: SelectBusViewModel.ModuleOutput(action: { [weak self] in
            switch $0 {
            case .busSelected:
                self?.setDashboard()
            }
        }))
        
        setController(selectBusVc)
    }
    
    private func onLogout() {
        let alert = UIAlertController(title: Localizable.logout_alert_message(), message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Localizable.logout_alert_button_yes(), style: .default, handler: { [weak self] _  in
            self?.output.logout()
        }))
        alert.addAction(UIAlertAction(title: Localizable.logout_alert_button_no(), style: .default))

        self.container.dismiss(animated: true, completion: nil)
        self.container.present(alert, animated: true)
    }

    private func setController(_ controller: UIViewController) {
        removeChildren()
        
        let navigation: UINavigationController
        
        if let nc = controller as? UINavigationController {
            navigation = nc
        } else {
            navigation = UINavigationController(rootViewController: controller)
        }
        
        add(navigation)
    }
    
    private func removeChildren() {
        container.children.forEach { remove($0) }
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
