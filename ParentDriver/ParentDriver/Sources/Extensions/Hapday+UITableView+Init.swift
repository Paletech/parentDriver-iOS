//
//  UITableView+Help.swift
//  Apteka911
//
//  Created by Agilie on 18.11.2019.
//  Copyright © 2019 Declareme UG. All rights reserved.
//

import Foundation

import UIKit

extension UITableView {

    func registerReusable<T: UITableViewCell>(_ type: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: T.self))
    }

    func registerNibReusable<T: UITableViewCell>(_ type: T.Type) {
        register(UINib(nibName: String(describing: T.self), bundle: nil),
                 forCellReuseIdentifier: String(describing: T.self))
    }

    func dequeueReusable<T>(type: T.Type, at indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self),
                                   for: indexPath) as! T // swiftlint:disable:this force_cast
    }

    func updateFooterSize() {
        guard let footer = tableFooterView else {
            return
        }

        let size = footer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        if footer.frame.size.height != size.height {
            footer.frame.size.height = size.height
            tableFooterView = footer
        }
    }

    func updateHeaderSize() {
        guard let headerView = tableHeaderView else {
            return
        }

        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)

        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            tableHeaderView = headerView
        }
    }

}
