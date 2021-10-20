//
//  HapDay+View+Animation.swift
//  HapDay
//
//  Created by Pavel on 20.08.2020.
//  Copyright © 2020 Valtech. All rights reserved.
//

import UIKit

extension UIView {

    func alphaHighlight(state: Bool, animated: Bool = true) {
        UIView.animate(withDuration: animated ? 0.15 : 0.0, animations: { [weak self] in
            self?.alpha = state ? 0.3 : 1.0
        })
    }

    func alphaSelect(animated: Bool, completion: EmptyClosure? = nil) {
        UIView.animate(withDuration: animated ? 0.15 : 0.0, animations: { [weak self] in
            self?.alpha = 0.3
            }, completion: { [weak self] _ in
                UIView.animate(withDuration: animated ? 0.15 : 0.0, animations: {
                    self?.alpha = 1.0
                }, completion: { _ in
                    completion?()
                })
        })
    }

    static func alphaHighlight(views: [UIView], state: Bool, animated: Bool = true) {
        UIView.animate(withDuration: animated ? 0.15 : 0.0, animations: {
            views.forEach { $0.alpha = state ? 0.3 : 1.0 }
        })
    }

    static func alphaSelect(views: [UIView], animated: Bool, completion: EmptyClosure? = nil) {
        UIView.animate(withDuration: animated ? 0.15 : 0.0, animations: {
            views.forEach { $0.alpha = 0.3 }
            }, completion: { _ in
                UIView.animate(withDuration: animated ? 0.15 : 0.0, animations: {
                    views.forEach { $0.alpha = 1.0 }
                }, completion: { _ in
                    completion?()
                })
        })
    }

}
