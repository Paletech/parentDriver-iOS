//
//  CheckboxView.swift
//  HapDay
//
//  Created by Pavel Reva on 06.09.2021.
//  Copyright © 2021 Valtech. All rights reserved.
//

import UIKit

class CheckboxView: UIView {
    
    private struct Constants {
        static let font: UIFont = UIFont.systemFont(ofSize: 12)
        static let textColor = UIColor.gray
        static let selectedTextColor = UIColor.black
        static let lineSize: CGFloat = 1.2
        static let checkboxSize: CGFloat = 40
        static let checkboxPadding: CGFloat = 8
        static let defaultOffset: CGFloat = 4
        static let animationDuration: TimeInterval = 0.5
    }
    
    private let impact = UIImpactFeedbackGenerator(style: .light)
    
    private var textLabel: UILabel!
    private var checkbox: UIButton!
    
    var onStatusChanged: ((Bool) -> Void)?
    
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
        translatesAutoresizingMaskIntoConstraints = false
        
        textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = Constants.textColor
        textLabel.numberOfLines = 0
        
        checkbox = UIButton(type: .custom)
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        checkbox.contentEdgeInsets = UIEdgeInsets(top: Constants.checkboxPadding,
                                                  left: Constants.checkboxPadding,
                                                  bottom: Constants.checkboxPadding,
                                                  right: 0)
        checkbox.addTarget(self, action: #selector(onCheckboxClick(_:)), for: .touchUpInside)
        
        applyCheckboxImages()
    }
    
    private func applyCheckboxImages() {
        checkbox.setImage(R.image.ic_checkbox(), for: .disabled)
        checkbox.setImage(R.image.ic_checkbox(), for: [.disabled, .highlighted])
        checkbox.setImage(R.image.ic_checkbox(), for: [.normal])
        checkbox.setImage(R.image.ic_checkbox_checked(), for: [.disabled, .selected])
        checkbox.setImage(R.image.ic_checkbox_checked(), for: [.selected, .highlighted])
        checkbox.setImage(R.image.ic_checkbox_checked(), for: .selected)
        checkbox.setImage(R.image.ic_checkbox_checked(), for: [.selected, .normal])
    }
    
    private func configureConstraints() {
        setContentHuggingPriority(.required, for: .vertical)
        setContentCompressionResistancePriority(.required, for: .vertical)
        
        [textLabel, checkbox].forEach { addSubview($0) }
        
        textLabel.setContentHuggingPriority(.required, for: .vertical)
        textLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        textLabel.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.right.equalTo(checkbox.snp.left).offset(-Constants.checkboxPadding)
            
            make.top.equalTo(Constants.defaultOffset)
            make.centerY.equalTo(snp.centerY)
        }
        
        checkbox.snp.makeConstraints { make in
            make.height.equalTo(Constants.checkboxSize)
            make.width.equalTo(Constants.checkboxSize)
            
            make.centerY.equalTo(textLabel.snp.centerY)
            make.top.greaterThanOrEqualTo(snp.top).offset(Constants.defaultOffset)
            
            make.right.equalTo(0)
        }
    }
    
    // MARK: - Logic
    
    func setup(title: String, isChecked: Bool = false) {
        textLabel.attributedText = title.attributed(withSpacing: Constants.lineSize,
                                                    font: Constants.font,
                                                    alignment: .left)
        checkbox.isSelected = isChecked
    }
    
    // MARK: - Actions
    
    @objc private func onCheckboxClick(_ sender: UIButton) {
        sender.isSelected.toggle()
        onStatusChanged?(sender.isSelected)
        updateTextColor()
        impact.impactOccurred()
    }
    
    private func updateTextColor() {
        UIView.transition(with: textLabel,
                          duration: Constants.animationDuration,
                          options: .transitionCrossDissolve) {
            self.textLabel.textColor = self.checkbox.isSelected ? Constants.selectedTextColor : Constants.textColor
        } completion: { _ in }
    }
}
