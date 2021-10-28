import UIKit
import SnapKit

class AuthView: UIView {
    private struct Constants {
        static let horizontalOffset: CGFloat = 24
        static let spacing: CGFloat = 12
        static let textFieldHeight: CGFloat = 70
    }

    private let contentStackView = UIStackView()

    private let driverIdInput = FloatingTextField()
    private let passwordInput = FloatingTextField()
    private let schoolIdInput = FloatingTextField()

    private var inputs: [FloatingTextField] { [driverIdInput, passwordInput, schoolIdInput] }

    private var output: TextFieldValidator!

    // MARK: - Init

    public required init (output: TextFieldValidator) {
        super.init(frame: .zero)
        self.output = output
        configure()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }

    func configure() {
        configureStackView()
        configureTextFields()
        configureConstraints()
    }
    
    func resetTextFields() {
        driverIdInput.value = ""
        passwordInput.value = ""
        schoolIdInput.value = ""
    }

    private func configureStackView() {
        addSubview(contentStackView)

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

    private func configureConstraints() {
        self.snp.makeConstraints { make in
            make.height.equalTo(90)
        }

        contentStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.horizontalOffset)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(Constants.horizontalOffset)
        }

        inputs.forEach {
            $0.snp.makeConstraints { make in
                make.height.equalTo(Constants.textFieldHeight)
            }
            contentStackView.addArrangedSubview($0)
        }
    }

    func checkTextFieldsState() -> Bool {
        inputs.forEach { $0.updateValueState() }
        return inputs.first(where: { !$0.isValid }) == nil
    }
}
