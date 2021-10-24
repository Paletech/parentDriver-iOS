//
//  HapDay+ActivityIndicator.swift
//  HapDay
//
//  Created by Pavel on 23.06.2020.
//  Copyright © 2020 Valtech. All rights reserved.
//

import UIKit

extension UIView {

    func showActivityIndicator(style: UIActivityIndicatorView.Style = .medium, tintColor: UIColor = .white) {
        removeActivityIndicator()

        let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView(style: style)
        activityIndicatorView.frame = bounds
        activityIndicatorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        activityIndicatorView.isUserInteractionEnabled = false
        activityIndicatorView.color = tintColor

        self.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }

    func removeActivityIndicator() {
        if let activityIndicator: UIView = self.subviews.first(where: { $0 is UIActivityIndicatorView }) {
            activityIndicator.removeFromSuperview()
        }
    }
}
