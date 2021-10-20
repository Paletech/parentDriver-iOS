//
//  Hapday+CGPoint.swift
//  HapDay
//
//  Created by Pavlo Reva on 04/09/2020.
//  Copyright © 2020 Valtech. All rights reserved.
//

import UIKit

extension CGPoint {

    static func distanceSquared(from: CGPoint, to: CGPoint) -> CGFloat {
        return (from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)
    }

    static func distance(from: CGPoint, to: CGPoint) -> CGFloat {
        return sqrt(distanceSquared(from: from, to: to))
    }

    func moving(distance: CGFloat, atAngle angle: CGFloat) -> CGPoint {
        CGPoint(x: x + distance * cos(angle.DEG2RAD), y: y + distance * sin(angle.DEG2RAD))
    }
}
