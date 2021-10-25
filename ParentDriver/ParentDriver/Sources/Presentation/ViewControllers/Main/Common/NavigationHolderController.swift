//
//  NavigationHolderCoontroller.swift
//  ParentDriver
//
//  Created by Pavel Reva on 25.10.2021.
//

import UIKit
import SideMenu

protocol BusSelectionProvider {
    func selectedBus() -> Bus?
}

extension BusSelectionProvider {
    func selectedBus() -> Bus? {
        let busStore: KeycheinStore<Bus> = inject()
        return try? busStore.get(from: KeychainKeys.selectedBus.rawValue)
    }
}

protocol MenuHandler {
    func onLeftMenuItemClick()
}

protocol NavigationHolderController {
    var busSelectionProvider: BusSelectionProvider { get }
    var menuHandler: MenuHandler { get }
    
    func setupNavigation()
}
 
extension NavigationHolderController where Self: UIViewController {
    
    func setupNavigation() {
        setupBusName()
        setupLeftBottomBar()
    }
    
    private func setupBusName() {
        title = busSelectionProvider.selectedBus()?.trackerName
    }
    
    private func setupLeftBottomBar() {
        let image = UIImage(systemName: "text.justify")

        let leftBarbuttonItem = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        leftBarbuttonItem.actionClosure = { [weak self] in
            self?.menuHandler.onLeftMenuItemClick()
        }
    
        navigationItem.leftBarButtonItem = leftBarbuttonItem
    }
}
