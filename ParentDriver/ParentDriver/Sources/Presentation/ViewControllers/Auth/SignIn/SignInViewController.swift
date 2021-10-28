import UIKit
import SnapKit

protocol SignInViewControllerOutput: ViewControllerOutput, TextFieldValidator {
    func signIn(driverID: String, password: String, schoolId: String)
    func onSignUp()
    func fetchSignUpVisibilityState()
    func validate(_ field: FloatingTextField?) -> AuthInteractorError?
}

protocol TextFieldValidator {
    func validate(_ field: FloatingTextField?) -> AuthInteractorError?
}

class SignInViewController: UIViewController {

    private struct Constants {
        static let horizaontalOffset: CGFloat = 24
        static let spacing: CGFloat = 12
        static let textFieldHeight: CGFloat = 70
        static let buttonHeight: CGFloat = 60
    }
    
    var output: SignInViewControllerOutput!
    
    private let contentStackView = UIStackView()
    
    private let driverIdInput = FloatingTextField()
    private let passwordInput = FloatingTextField()
    private let schoolIdInput = FloatingTextField()
    
    private let buttonsStackView = UIStackView()
    
    private let signInButton = StateButtton(type: .system)
    private let signUpButton = StateButtton(type: .system)
    
    private var inputs: [FloatingTextField] { [driverIdInput, passwordInput, schoolIdInput] }
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        configureConstraints()
        setupTitles()
    }

    override func viewWillAppear(_ animated: Bool) {
        resetTextFields()
    }

    // MARK: - Private

    private func resetTextFields() {
        driverIdInput.value = ""
        passwordInput.value = ""
        schoolIdInput.value = ""
    }

    private func configureUI() {
        configureStackView()
        configureTextFields()
        configureButtonsStackView()
        configureSignInButton()
        configureSignUpButton()
        
        output.fetchSignUpVisibilityState()
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
    
    private func configureButtonsStackView() {
        view.addSubview(buttonsStackView)
        
        buttonsStackView.alignment = .fill
        buttonsStackView.axis = .vertical
        buttonsStackView.distribution = .fill
        buttonsStackView.spacing = Constants.spacing
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
        
        buttonsStackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Constants.horizaontalOffset)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-Constants.horizaontalOffset)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.buttonHeight)
        }
        
        inputs.forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(Constants.textFieldHeight)
            }
            contentStackView.addArrangedSubview($0)
        }
        
        [signInButton, signUpButton].forEach {
            buttonsStackView.addArrangedSubview($0)
        }
    }
    
    private func login() {
        inputs.forEach { $0.updateValueState() }
        guard inputs.first(where: { !$0.isValid }) == nil else { return }
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
