//
//  Hapday+FloatingPoint.swift
//  HapDay
//
//  Created by Pavlo Reva on 04/09/2020.
//  Copyright © 2020 Valtech. All rights reserved.
//

import Foundation

extension FloatingPoint {
    var DEG2RAD: Self { return self * .pi / 180 }
    var RAD2DEG: Self { return self * 180 / .pi }
}
