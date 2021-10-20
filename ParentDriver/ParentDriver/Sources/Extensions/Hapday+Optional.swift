//
//  Hapday+Optional.swift
//  HapDay
//
//  Created by Pavlo Reva on 07/09/2020.
//  Copyright © 2020 Valtech. All rights reserved.
//

import Foundation

extension Optional {
    var toString: String? { self.flatMap { "\($0)" } }
}
