import UIKit
import SnapKit

protocol SignUpViewControllerOutput: ViewControllerOutput {
    func validate(_ field: FloatingTextField?) -> AuthInteractorError?
}

class SignUpViewController: UIViewController {

    private struct Constants {
        static let horizaontalOffset: CGFloat = 24
        static let spacing: CGFloat = 12
        static let textFieldHeight: CGFloat = 70
        static let buttonHeight: CGFloat = 60
    }

    var output: SignUpViewControllerOutput!

    private let contentStackView = UIStackView()

    private let driverIdInput = FloatingTextField()
    private let passwordInput = FloatingTextField()
    private let schoolIdInput = FloatingTextField()

    private let signUpButton = StateButtton(type: .system)

    private var inputs: [FloatingTextField] { [driverIdInput, passwordInput, schoolIdInput] }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureConstraints()
        setupTitles()
    }

    // MARK: - Private

    private func configureUI() {
        configureStackView()
        configureTextFields()
        configureSignUpButton()
    }

    private func configureStackView() {
        view.addSubview(contentStackView)

        contentStackView.alignment = .fill
        contentStackView.axis = .vertical
        contentStackView.distribution = .fill
        contentStackView.spacing = Constants.spacing
    }

    private func configureTextFields() {
        driverIdInput.setup(with: .driverId, nextInput: passwordInput)
        passwordInput.setup(with: .password, nextInput: schoolIdInput)
        schoolIdInput.setup(with: .schoolId)

        inputs.forEach { field in
            field.validator = { [weak self] value -> Error? in
                return self?.output.validate(field)
            }
        }
    }

    private func configureSignUpButton() {
        configureDefaultButton(signUpButton)
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }

    private func configureDefaultButton(_ button: UIButton) {
        view.addSubview(button)

        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = Constants.buttonHeight / 2
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    private func configureConstraints() {
        contentStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.horizaontalOffset)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.horizaontalOffset)
        }

        signUpButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.horizaontalOffset)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-Constants.horizaontalOffset)
            make.height.equalTo(Constants.buttonHeight)
        }

        inputs.forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(Constants.textFieldHeight)
            }
            contentStackView.addArrangedSubview($0)
        }
    }

    private func showAlert(messageText: String, buttonText: String) {
        let alert = UIAlertController(title: messageText, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: nil))

        self.present(alert, animated: true)
    }

    private func resetFields() {
        driverIdInput.value = ""
        passwordInput.value = ""
        schoolIdInput.value = ""
    }

    // MARK: - Localisation

    private func setupTitles() {
        title = Localizable.title_sign_up()
        signUpButton.setTitle(Localizable.button_sign_up(), for: .normal)
    }

    // MARK: - Actions

    @objc private func signUp() {
        inputs.forEach { $0.updateValueState() }
        guard inputs.first(where: { !$0.isValid }) == nil else {
            showAlert(messageText: Localizable.sign_up_alert_error_message(), buttonText: Localizable.sign_up_alert_button())
            return }
        showAlert(messageText: Localizable.sign_up_alert_message(), buttonText: Localizable.sign_up_alert_button())
        resetFields()
    }

}

// MARK: - Private SignUpViewModelOutput
extension SignUpViewController: SignInViewModelOutput {
    func updateSignUpVisibility(value: Bool) {}
}
