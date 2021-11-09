//
//  YesNoView.swift
//  ParentDriver
//
//  Created by Pavel Reva on 09.11.2021.
//

import UIKit

enum YesNoOption {
    case yes
    case no
    
    var title: String {
        switch self {
        case .no:
            return Localizable.label_no()
        case .yes:
            return Localizable.label_yes()
        }
    }
}

class YesNoView: BaseView {
    
    private struct Constants {
        static let optionButtonWidth: CGFloat = 50
        static let spacing: CGFloat = 10
        static let optionCornerRadius: CGFloat = 8
        static let optionHeight: CGFloat = 30
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    private let options: [YesNoOption] = [.yes, .no]
    private var selectedOption: YesNoOption { yesButton.isSelected ? .yes : .no }
    
    private let titleLabel = UILabel()
    private let optionsStackView = UIStackView()
    private let yesButton = SelectableButton(type: .custom)
    private let noButton = SelectableButton(type: .custom)
    
    var onUpdateSelection: ((YesNoOption) -> Void)?
    
    // MARK: - Base Overrides
    
    override func prepareUI() {
        [titleLabel, optionsStackView].forEach { addSubview($0) }
        
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: 16)
        
        optionsStackView.axis = .horizontal
        optionsStackView.alignment = .fill
        optionsStackView.distribution = .fillEqually
        optionsStackView.spacing = Constants.spacing
        
        [yesButton, noButton].forEach {
            $0.setTitleColor(.black, for: .normal)
            $0.layer.cornerRadius = Constants.optionHeight / 2
            optionsStackView.addArrangedSubview($0)
        }
        
        yesButton.setTitle(YesNoOption.yes.title, for: .normal)
        noButton.setTitle(YesNoOption.no.title, for: .normal)
    }

    override func configureConstraints() {
        optionsStackView.snp.makeConstraints { make in
            make.right.equalTo(0)
            make.width.equalTo(Constants.spacing + Constants.optionButtonWidth * 2)
            make.height.equalTo(Constants.optionHeight)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(Constants.spacing)
            make.centerY.equalToSuperview()
            make.right.equalTo(optionsStackView.snp.left).offset(-Constants.spacing)
            make.top.equalTo(0)
            make.height.greaterThanOrEqualTo(Constants.optionHeight)
        }
    }

    override func configureAction() {
        yesButton.addAction { [weak self] in
            self?.yesButton.isSelected = true
            self?.noButton.isSelected = false
            self?.onUpdateSelection?(.yes)
        }
        
        noButton.addAction { [weak self] in
            self?.yesButton.isSelected = false
            self?.noButton.isSelected = true
            self?.onUpdateSelection?(.no)
        }
    }
}
