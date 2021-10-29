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

extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        @objc class ClosureSleeve: NSObject {
            let closure:()->()
            init(_ closure: @escaping()->()) { self.closure = closure }
            @objc func invoke() { closure() }
        }
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, "\(UUID())", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}
