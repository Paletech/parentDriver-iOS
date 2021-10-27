//
//  MonitorBoardingCell.swift
//  ParentDriver
//
//  Created by Pavel Reva on 27.10.2021.
//

import UIKit

class MonitorBoardingCell: UITableViewCell {
    
    private struct Constants {
        static let spacing: CGFloat = 8
        static let cornerRadius: CGFloat = 16
    }
    
    private let containerView = UIView()
    private let stackView = UIStackView()
    
    // MARK: - Init/Deinit
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    // MARK: - Private
        
    private func configureUI() {
        configureContentView()
        configureStackView()
    }
    
    private func configureContentView() {
        contentView.backgroundColor = .white
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = Constants.cornerRadius
        containerView.applyShadow(color: .black, alpha: 0.1, x: 0, y: 2)
        
        contentView.addSubview(containerView)
        containerView.addSubview(stackView)
    }
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = Constants.spacing
    }
    
    private func configureConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(Constants.spacing * 4)
            make.center.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(Constants.spacing)
            make.left.equalTo(Constants.spacing)
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - Logic
    
    func setup(item: MonitorBoardingUIModel) {
        let labels: [String] = [Localizable.label_student(),
                                Localizable.label_status(),
                                Localizable.label_time()]
        
        let values: [String] = [item.student,
                                item.status,
                                item.time]
        
        let images: [UIImage?] = [nil,
                                  item.image,
                                  nil]
        
        for index in 0..<labels.count {
            let view = configureView(label: labels[index],
                                     value: values[index],
                                     image: images[index])
            stackView.addArrangedSubview(view)
        }
    }
    
    private func configureView(label: String,
                               value: String,
                               image: UIImage?) -> TitleValueView {
        let item = TitleValueView()
        
        item.setup(label: label,
                   value: value,
                   image: image)
        
        return item
    }
}
