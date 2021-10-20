//
//  Hapday+CGSize.swift
//  HapDay
//
//  Created by Pavlo Reva on 05/09/2020.
//  Copyright © 2020 Valtech. All rights reserved.
//

import UIKit

extension CGSize {
    func rotatedBy(degrees: CGFloat) -> CGSize {
        let radians = degrees.DEG2RAD
        return rotatedBy(radians: radians)
    }

    func rotatedBy(radians: CGFloat) -> CGSize {
        return CGSize(
            width: abs(width * cos(radians)) + abs(height * sin(radians)),
            height: abs(width * sin(radians)) + abs(height * cos(radians)))
    }
}
