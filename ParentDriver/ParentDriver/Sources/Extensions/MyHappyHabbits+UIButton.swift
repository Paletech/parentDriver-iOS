//
//  MyHappyHabbits+UIButton.swift
//  MyHappyHabits
//
//  Created by Pavel Reva on 10.06.2021.
//

import UIKit

extension UIButton {
    
    func applyPrimaryStyle() {
        cornerRadius = bounds.height / 2
        backgroundColor = .blue
        layer.borderColor = UIColor.blue.cgColor
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 15)
    }
    
    func applyNotSelectedStyle() {
        cornerRadius = bounds.height / 2
        backgroundColor = .white
        setTitleColor(.black, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
    }
}
