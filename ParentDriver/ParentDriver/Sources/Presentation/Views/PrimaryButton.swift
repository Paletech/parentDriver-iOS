//
//  PrimaryButton.swift
//  MyHappyHabits
//
//  Created by Pavel Reva on 17.06.2021.
//

import UIKit

class PrimaryButton: UIButton {

    func applyEnabledState(_ isEnabled: Bool) {
        if self.isEnabled != isEnabled {
            self.isEnabled = isEnabled
            
            UIView.transition(with: self,
                              duration: 0.4,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.alpha = self.isEnabled ? 1 : 0.4
                              },
                              completion: nil)
        }
    }
}
