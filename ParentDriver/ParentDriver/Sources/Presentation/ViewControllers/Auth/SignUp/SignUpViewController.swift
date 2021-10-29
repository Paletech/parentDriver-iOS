import UIKit
import SnapKit

protocol SignUpViewControllerOutput: ViewControllerOutput, TextFieldValidator {
    func onSignUp()
}

class SignUpViewController: UIViewController, AuthView {
    
    var output: SignUpViewControllerOutput
    var authViewOutput: TextFieldValidator { output }

    var driverIdInput = FloatingTextField()
    var passwordInput = FloatingTextField()
    var schoolIdInput = FloatingTextField()
    
    var contentStackView = UIStackView()
    
    private var signUpButton = StateButtton(type: .system)
    
    var inputs: [FloatingTextField]

    init(output: SignUpViewControllerOutput) {
        self.output = output
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
        view.backgroundColor = .white
        
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

    // MARK: - Localisation

    private func setupTitles() {
        title = Localizable.title_sign_up()
        signUpButton.setTitle(Localizable.button_sign_up(), for: .normal)
    }

    // MARK: - Actions

    @objc private func signUp() {
        inputs.forEach { $0.updateValueState() }
        guard inputs.first(where: { !$0.isValid }) == nil else { return }
        output.onSignUp()
    }
}

// MARK: - Private SignUpViewModelOutput
extension SignUpViewController: SignInViewModelOutput {
    func updateSignUpVisibility(value: Bool) {}
}
