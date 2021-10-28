//
//  TitleValueView.swift
//  ParentDriver
//
//  Created by Pavel Reva on 27.10.2021.
//

import UIKit

class TitleValueView: UIView {
    
    private struct Constants {
        static let offset: CGFloat = 16
        static let imageSize: CGFloat = 24
        static let stackViewOffset: CGFloat = 16
        static let fontSize: CGFloat = 16
        static let labelWidth: CGFloat = 70
        static let generalStackViewOffset: CGFloat = 6
    }
    
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let valueStackView = UIStackView()
    private let imageView = UIImageView()
    private let valueLabel = UILabel()
    private let valueView = UIView()
        
    // MARK: - Init/Deinit
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    // MARK: - Private
    
    private func setup() {
        configureUI()
        configureConstraints()
    }
    
    private func configureUI() {
        configureStackView()
        configureTitleLabel()
        configureImageView()
        configureValueLabel()
        
        valueView.addSubview(valueLabel)
        
        valueStackView.addArrangedSubview(imageView)
        valueStackView.addArrangedSubview(valueView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueStackView)
    }
    
    private func configureStackView() {
        addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = Constants.generalStackViewOffset
    }
    
    private func configureTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: Constants.fontSize, weight: .semibold)
    }
    
    private func configureValueStackView() {
        valueStackView.axis = .horizontal
        valueStackView.distribution = .fill
        valueStackView.alignment = .leading
        valueStackView.spacing = Constants.stackViewOffset
    }
    
    private func configureImageView() {
        imageView.contentMode = .center
    }
    
    private func configureValueLabel() {
        valueLabel.numberOfLines = 0
        valueLabel.textColor = .black
        valueLabel.font = .systemFont(ofSize: Constants.fontSize)
    }
    
    private func configureConstraints() {
        stackView.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(Constants.offset)
            make.width.equalTo(Constants.labelWidth)
        }
        
        valueLabel.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(Constants.imageSize)
        }
    }
    
    // MARK: - Logic
    
    func setup(label: String,
               value: String,
               image: UIImage?) {
        if image == nil {
            imageView.isHidden = true
        }
        
        titleLabel.text = label
        valueLabel.text = value
        imageView.image = image
    }
}
