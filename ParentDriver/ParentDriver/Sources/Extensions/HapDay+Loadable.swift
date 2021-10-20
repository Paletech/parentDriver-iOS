//
//  HapDay+Loadable.swift
//  HapDay
//
//  Created by Pavel on 23.06.2020.
//  Copyright © 2020 Valtech. All rights reserved.
//

import UIKit

protocol Loadable {
    func startLoading()
    func stopLoading()
}

extension Loadable where Self: UIViewController {

    func startLoading() {
        view.showActivityIndicator()
    }

    func stopLoading() {
        view.removeActivityIndicator()
    }

}
