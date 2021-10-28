import UIKit
import SnapKit

protocol SignUpViewControllerOutput: ViewControllerOutput, TextFieldValidator {
    func validate(_ field: FloatingTextField?) -> AuthInteractorError?
}

class SignUpViewController: UIViewController, AuthView {
    var authViewOutput: TextFieldValidator

    var driverIdInput = FloatingTextField()
    var passwordInput = FloatingTextField()
    var schoolIdInput = FloatingTextField()
    var contentStackView = UIStackView()
    var inputs: [FloatingTextField]

    private var signUpButton = StateButtton(type: .system)

    init(output: SignUpViewControllerOutput) {
        self.authViewOutput = output
        inputs =  [driverIdInput, passwordInput, schoolIdInput]

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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

    private func configureSignUpButton() {
        configureDefaultButton(signUpButton)
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }

    private func configureConstraints() {
        configureTextFieldsConstraints()

        signUpButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(horizontalOffset)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-horizontalOffset)
            make.height.equalTo(buttonHeight)
        }
    }

    private func showAlert(messageText: String, buttonText: String) {
        let alert = UIAlertController(title: messageText, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonText, style: .default, handler: nil))

        self.present(alert, animated: true)
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
