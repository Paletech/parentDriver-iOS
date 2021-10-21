import UIKit
import SnapKit

protocol SignInViewControllerOutput: ViewControllerOutput {
    func signIn()
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
    private let signInButton = StateButtton(type: .system)
    
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
        configureSignInButton()
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
    }
    
    private func configureSignInButton() {
        view.addSubview(signInButton)
        
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.layer.cornerRadius = Constants.buttonHeight / 2
        signInButton.addTarget(self, action: #selector(onSignIn), for: .touchUpInside)
    }
    
    private func configureConstraints() {
        contentStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.horizaontalOffset)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.horizaontalOffset)
        }
        
        signInButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Constants.horizaontalOffset)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.buttonHeight)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-Constants.horizaontalOffset)
        }
        
        inputs.forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(Constants.textFieldHeight)
            }
            contentStackView.addArrangedSubview($0)
        }
    }
    
    private func login() {
        inputs.forEach { $0.updateValueState() }
        guard inputs.first(where: { !$0.isValid }) == nil else { return }
        output.signIn()
    }
    
    // MARK: - Localisation
    
    private func setupTitles() {
        title = Localizable.title_sign_in()
        signInButton.setTitle(Localizable.title_sign_in(), for: .normal)
    }
    
    // MARK: - Actions
    
    @objc private func onSignIn() {
        login()
    }
}

// MARK: - Private SignInViewModelOutput
extension SignInViewController: SignInViewModelOutput {

    func dataDidUpdate() {

    }
}
