//
//  TitleTextView.swift
//  HapDay
//
//  Created by Pavel Reva on 07.09.2021.
//  Copyright © 2021 Valtech. All rights reserved.
//

import UIKit

class TitleTextView: UIView {
    
    private struct Constants {
        static let labelNumberOfLines = 0
    }
    
    private var label = UILabel()
    
    // MARK: - Init/Deinit
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    // MARK: - UI
    
    private func configure() {
        setupUI()
        configureConstraints()
    }
    
    private func setupUI() {
        backgroundColor = .clear
        label.numberOfLines = Constants.labelNumberOfLines
    }
    
    private func configureConstraints() {
        setContentCompressionResistancePriority(.required, for: .vertical)
        setContentHuggingPriority(.required, for: .vertical)

        addSubview(label)
        
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        
        label.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(0)
        }
    }
    
    // MARK: - Logic
    
    func setup(config: TitleTextConfig) {
        label.font = config.font
        label.textColor = config.textColor
        label.text = config.text
        label.textAlignment = config.alignment
    }
    
    func setup(attributedString: NSAttributedString) {
        label.attributedText = attributedString
    }
}
