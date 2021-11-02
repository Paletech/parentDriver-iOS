import Foundation
import UIKit
import SnapKit

class RidersheepChangesCell: UITableViewCell {

    private struct Constants {
        static let spacing: CGFloat = 8
        static let cornerRadius: CGFloat = 16
        static let offset: CGFloat = 16
        static let labelWidth: CGFloat = 70
        static let fontSize: CGFloat = 16
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
            make.top.equalTo(Constants.spacing)
            make.left.equalTo(Constants.offset)
            make.right.equalTo(-Constants.offset)
            make.center.equalToSuperview()
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(Constants.spacing)
            make.left.equalTo(Constants.spacing)
            make.right.equalTo(-Constants.spacing)
            make.center.equalToSuperview()
        }
    }

    // MARK: - Logic

    func setup(item: RidersheepChangesUIModel) {
        let labels: [String] = [Localizable.label_student(),
                                Localizable.label_campus(),
                                Localizable.label_address()]

        let values: [String] = [item.student,
                                item.campus,
                                item.address]

        for index in 0..<labels.count {
            let view = configureView(label: labels[index],
                                     value: values[index])
            stackView.addArrangedSubview(view)
        }
    }

    private func configureView(label: String, value: String) -> UIView {
        let view = UIView()

        let titleLabel = UILabel()
        titleLabel.text = label
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        titleLabel.font = .systemFont(ofSize: Constants.fontSize, weight: .semibold)
        view.addSubview(titleLabel)

        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.numberOfLines = 0
        valueLabel.textColor = .black
        valueLabel.font = .systemFont(ofSize: Constants.fontSize)
        view.addSubview(valueLabel)

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.width.equalTo(Constants.labelWidth)
            make.leading.equalTo(view.snp.leading).offset(Constants.offset)
        }

        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.leading.equalTo(titleLabel.snp.trailing).offset(Constants.offset)
            make.trailing.equalTo(view.snp.trailing).offset(-Constants.offset)
        }

        view.snp.makeConstraints { make in
            make.height.equalTo(20)
        }

        return view
    }
}
