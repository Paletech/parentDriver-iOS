//
//  CheckboxDataSource.swift
//  HapDay
//
//  Created by Pavel Reva on 06.09.2021.
//  Copyright © 2021 Valtech. All rights reserved.
//

import Foundation

class CheckBoxDataSource: StackDataSource<Checkbox, CheckboxView> {
    
    var isSelected: Bool = false
    var onStatusChanged: ((Bool) -> Void)?
    
    override func reload() {
        view.setup(title: item.title)
        view.onStatusChanged = { [weak self] in
            self?.isSelected = $0
            self?.onStatusChanged?($0)
        }
    }
}
