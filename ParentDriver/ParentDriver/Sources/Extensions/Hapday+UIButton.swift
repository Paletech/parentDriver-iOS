//
//  Hapday+UIButton.swift
//  HapDay
//
//  Created by Pavlo Reva on 29/07/2020.
//  Copyright © 2020 Valtech. All rights reserved.
//

import UIKit

extension UIButton {
    func animateChange(duration: TimeInterval = 0.5,
                       change: @escaping ((UIButton) -> Void),
                       completion: ((UIButton) -> Void)? = nil) {
        UIView.transition(with: self,
                          duration: duration,
                          options: .transitionCrossDissolve,
                          animations: { change(self) },
                          completion: { _ in completion?(self) })
    }
}
