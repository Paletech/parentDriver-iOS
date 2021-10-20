//
//  BaseView.swift
//  MyHappyHabits
//
//  Created by Olha on 25.06.2021.
//

import UIKit

class BaseView: UIView {

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    // MARK: - UI
    func configure() {
        prepareUI()
        configureConstraints()
        prepareLocalization()
        configureAction()
    }

    // MARK: - Override
    func prepareUI() { }

    func configureConstraints() { }

    func prepareLocalization() { }

    func configureAction() { }

}
