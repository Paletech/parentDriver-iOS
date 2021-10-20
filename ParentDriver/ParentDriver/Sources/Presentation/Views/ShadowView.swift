//
//  ShadowView.swift
//  HapDay
//
//  Created by Pavel on 07.07.2020.
//  Copyright © 2020 Valtech. All rights reserved.
//

import Foundation

import UIKit

final class ShadowView: UIView {

    let color: UIColor

    // MARK: Init/Deinit

    init(color: UIColor = .black) {
        self.color = color
        super.init(frame: .zero)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func show(animated: Bool = true) {
        changeBackgroundColor(to: #colorLiteral(red: 0.1254901961, green: 0.1254901961, blue: 0.1254901961, alpha: 0.6), duration: animated ? 0.4 : 0)
    }

    func hide(animated: Bool = true) {
        changeBackgroundColor(to: .clear, duration: animated ? 0.4 : 0)
    }

    // MARK: - UI

    func changeBackgroundColor(to color: UIColor, duration: Double) {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.backgroundColor = color
        }
    }

}
