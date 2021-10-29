//
//  AuthViewProtocol.swift
//  ParentDriver
//
//  Created by Машенька on 28/10/2021.
//

import UIKit

protocol TextFieldValidator {
    func validate(_ field: FloatingTextField?) -> AuthInteractorError?
}

protocol AuthView {
    var driverIdInput: FloatingTextField { get set }
    var passwordInput: FloatingTextField { get set }
    var schoolIdInput: FloatingTextField { get set }
    var contentStackView: UIStackView { get set }
    var inputs: [FloatingTextField] { get set }

    var authViewOutput: TextFieldValidator { get }
    
    func configureStackView()
    func configureTextFields()
    func configureDefaultButton(_ button: UIButton)
    func resetFields()
}

extension AuthView where Self: UIViewController {
    var buttonHeight: CGFloat { 60 }
    var spacing: CGFloat { 12 }
    var textFieldHeight: CGFloat { 70 }
    var horizontalOffset: CGFloat { 24 }

    func configureStackView() {
        self.view.addSubview(contentStackView)

        contentStackView.alignment = .fill
        contentStackView.axis = .vertical
        contentStackView.distribution = .fill
        contentStackView.spacing = spacing
    }

    func configureTextFields() {
        driverIdInput.setup(with: .driverId, nextInput: passwordInput)
        passwordInput.setup(with: .password, nextInput: schoolIdInput)
        schoolIdInput.setup(with: .schoolId)

        inputs.forEach { field in
            field.validator = { [weak self] value -> Error? in
                return self?.authViewOutput.validate(field)
            }
        }
    }

    func configureDefaultButton(_ button: UIButton) {
        view.addSubview(button)

        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = buttonHeight / 2
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    func resetFields() {
        driverIdInput.value = ""
        passwordInput.value = ""
        schoolIdInput.value = ""
    }

    func configureTextFieldsConstraints() {
        contentStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(horizontalOffset)
        }

        inputs.forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(textFieldHeight)
            }
            contentStackView.addArrangedSubview($0)
        }
    }
}
