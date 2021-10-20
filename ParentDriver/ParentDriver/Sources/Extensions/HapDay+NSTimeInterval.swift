//
//  HapDay+NSTimeInterval.swift
//  HapDay
//
//  Created by Denis on 14.09.2020.
//  Copyright © 2020 Valtech. All rights reserved.
//

import UIKit

extension TimeInterval {

    func stringRepresentation() -> String {

        let interval: Int = Int(self)
        let seconds: Int = interval % 60 < 0 ? 0 : interval % 60
        let minutes: Int = (interval / 60) % 60 < 0 ? 0 : (interval / 60) % 60
        let hours: Int = (interval / 3600) < 0 ? 0 : (interval / 3600)

        var result: String = " "

        if hours == 0 {

            result = String(format: "%02d:%02d", minutes, seconds)
        } else {

            result = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }

        return result
    }
}
