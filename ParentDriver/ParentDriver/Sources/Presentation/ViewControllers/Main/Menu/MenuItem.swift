//
//  MenuCases.swift
//  ParentDriver
//
//  Created by Pavel Reva on 25.10.2021.
//

import Foundation

enum MenuItem: CaseIterable {
    
    case dashboard
    case monitorBoarding
    case busInspection
    case ridersheepChanges
    case changeBus
    case logout
    
    var title: String {
        switch self {
        case .dashboard:
            return Localizable.title_dashboard()
        case .monitorBoarding:
            return Localizable.title_monitor_boarding()
        case .ridersheepChanges:
            return Localizable.title_ridersheep_changes()
        case .busInspection:
            return Localizable.title_bus_inspection()
        case .changeBus:
            return Localizable.title_change_bus()
        case .logout:
            return Localizable.title_logout()
        }
    }
    
    static var sorted: [MenuItem] = MenuItem.allCases
}
