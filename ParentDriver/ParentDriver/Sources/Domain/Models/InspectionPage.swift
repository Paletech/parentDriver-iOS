//
//  InspectionPage.swift
//  ParentDriver
//
//  Created by Pavel Reva on 07.11.2021.
//

import Foundation

class InspectionPage {
    var title: String = ""
    var items: [InspectionItem] = []
    
    init(title: String, items: [InspectionItem]) {
        self.title = title
        self.items = items
    }
}

class InspectionItem {
    let id: String
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
