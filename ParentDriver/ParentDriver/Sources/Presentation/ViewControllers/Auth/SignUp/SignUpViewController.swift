import UIKit
import SnapKit

protocol SignUpViewControllerOutput: ViewControllerOutput, TextFieldValidator {
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

    private lazy var authView: AuthView = { AuthView(output: output) } ()

    private let signUpButton = StateButtton(type: .system)

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureConstraints()
        setupTitles()
    }

    // MARK: - Private

    private func configureUI() {
        configureAuthView()
        configureSignUpButton()
    }

    private func configureAuthView() {
        view.addSubview(authView)
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
        authView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
        }

        signUpButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.horizaontalOffset)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-Constants.horizaontalOffset)
            make.height.equalTo(Constants.buttonHeight)
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
        guard authView.checkTextFieldsState() else {
            showAlert(messageText: Localizable.sign_up_alert_error_message(), buttonText: Localizable.sign_up_alert_button())
            return }
        showAlert(messageText: Localizable.sign_up_alert_message(), buttonText: Localizable.sign_up_alert_button())
        authView.resetTextFields()
    }

}

// MARK: - Private SignUpViewModelOutput
extension SignUpViewController: SignInViewModelOutput {
    func updateSignUpVisibility(value: Bool) {}
}
