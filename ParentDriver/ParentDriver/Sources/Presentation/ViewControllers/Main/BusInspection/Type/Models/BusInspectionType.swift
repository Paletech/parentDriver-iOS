//
//  BusInspectionType.swift
//  ParentDriver
//
//  Created by Pavel Reva on 06.11.2021.
//

import Foundation

enum BusInspectionType {
    case pre
    case post
    
    static var sorted: [BusInspectionType] { [.pre, .post] }
    
    var title: String {
        switch self {
        case .post:
            return Localizable.enum_inspection_type_post()
        case .pre:
            return Localizable.enum_inspection_type_pre()
        }
    }
}
