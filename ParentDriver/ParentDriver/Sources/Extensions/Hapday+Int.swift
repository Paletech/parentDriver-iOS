//
//  Hapday+Int.swift
//  HapDay
//
//  Created by Pavlo Reva on 07/09/2020.
//  Copyright © 2020 Valtech. All rights reserved.
//

import Foundation

extension Int {
    var toString: String { "\(self)" }
    var perencetedString: String { toString + "%" }

    var toNumber: NSNumber { NSNumber(value: self) }
}
