//
//  HapDay+View+Blur.swift
//  HapDay
//
//  Created by Pavel on 17.07.2020.
//  Copyright © 2020 Valtech. All rights reserved.
//

import UIKit

extension UIView {

    func blurView(style: UIBlurEffect.Style, alpha: CGFloat) {
        var blurEffectView = UIVisualEffectView()
        let blurEffect = UIBlurEffect(style: style)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.alpha = alpha
        addSubview(blurEffectView)
    }

    func removeBlur() {
        for view in self.subviews {
            if let view = view as? UIVisualEffectView {
                view.removeFromSuperview()
            }
        }
    }

}
