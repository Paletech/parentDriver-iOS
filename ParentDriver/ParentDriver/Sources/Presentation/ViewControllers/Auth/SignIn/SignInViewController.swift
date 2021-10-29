import UIKit
import SnapKit

protocol SignInViewControllerOutput: ViewControllerOutput, TextFieldValidator {
    func signIn(driverID: String, password: String, schoolId: String)

    func onSignUp()
    func fetchSignUpVisibilityState()
}

class SignInViewController: UIViewController, AuthView {
    var output: SignInViewControllerOutput
    var authViewOutput: TextFieldValidator

    var driverIdInput = FloatingTextField()
    var passwordInput = FloatingTextField()
    var schoolIdInput = FloatingTextField()
    var contentStackView = UIStackView()
    var inputs: [FloatingTextField]

    private var buttonsStackView = UIStackView()
    
    private var signInButton = StateButtton(type: .system)
    private var signUpButton = StateButtton(type: .system)

    init(output: SignInViewControllerOutput) {
        self.output = output
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

    override func viewWillAppear(_ animated: Bool) {
        resetFields()
    }

    // MARK: - Private

    private func configureUI() {
        configureStackView()
        configureTextFields()
        configureButtonsStackView()
        configureSignInButton()
        configureSignUpButton()
        
        output.fetchSignUpVisibilityState()
    }
    
    private func configureButtonsStackView() {
        view.addSubview(buttonsStackView)
        
        buttonsStackView.alignment = .fill
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .fill
        buttonsStackView.spacing = spacing
    }
    
    private func configureSignInButton() {
        configureDefaultButton(signInButton)
        signInButton.addTarget(self, action: #selector(onSignIn), for: .touchUpInside)
    }
    
    private func configureSignUpButton() {
        configureDefaultButton(signUpButton)
        signUpButton.addTarget(self, action: #selector(onSignUp), for: .touchUpInside)
        signUpButton.isHidden = true
    }
    
    private func configureConstraints() {
        configureTextFieldsConstraints()

        buttonsStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(horizontalOffset)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-horizontalOffset)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(buttonHeight)
        }
        
        [signInButton, signUpButton].forEach {
            buttonsStackView.addArrangedSubview($0)
        }
    }
    
    private func login() {
        
        output.signIn(driverID: driverIdInput.value,
                      password: passwordInput.value,
                      schoolId: schoolIdInput.value)
    }
    
    // MARK: - Localisation
    
    private func setupTitles() {
        title = Localizable.title_sign_in()
        signInButton.setTitle(Localizable.title_sign_in(), for: .normal)
        signUpButton.setTitle(Localizable.button_sign_up(), for: .normal)
    }
    
    // MARK: - Actions
    
    @objc private func onSignIn() {
        login()
    }
    
    @objc private func onSignUp() {
        output.onSignUp()
    }
}

// MARK: - Private SignInViewModelOutput
extension SignInViewController: SignInViewModelOutput {
    func updateSignUpVisibility(value: Bool) {
        signUpButton.isHidden = !value
    }
    
    func startActivity() {
        signInButton.isUserInteractionEnabled = false
        signInButton.setTitle(nil, for: .normal)
        signInButton.showActivityIndicator()
    }
    
    func stopActivity() {
        signInButton.isUserInteractionEnabled = true
        signInButton.setTitle(Localizable.button_sign_in(), for: .normal)
        signInButton.removeActivityIndicator()
    }
}
