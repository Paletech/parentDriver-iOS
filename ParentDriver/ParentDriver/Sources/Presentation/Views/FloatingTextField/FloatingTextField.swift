import UIKit
import SnapKit
import IQKeyboardManagerSwift

final class FloatingTextField: UIView { //swiftlint:disable:this type_body_length

    private let titleLabel = UILabel()
    private let placeholderLabel = UILabel()
    private let inputTextField = UITextField()
    private let separatorView = UIView()
    private let errorLabel = UILabel()
    private let indicatorView = UIImageView()
    private let indicatorRightView = UIView()
    private let eyeButton = OverTouchButton()

    var datePickerInput: UIDatePicker? { inputTextField.inputView as? UIDatePicker }
    
    var validator: ValidValueHandler?
    var returnAction: EmptyClosure?
    var type: InputFieldType = .email

    var selectedValue: TitleIdble? {
        didSet {
            guard let value = selectedValue else { return }
            onPickerValueChanged?(value)
        }
    }
    var pickerValues: [TitleIdble] = [] {
        didSet {
            (inputTextField.inputView as? UIPickerView)?.reloadAllComponents()
        }
    }
    var onPickerValueChanged: ((TitleIdble) -> Void)?
    var onTextChanged: ((String) -> Void)?
    
    weak var delegate: ValidatableTextFieldDelegate?

    private var timer: Timer?
    private var forceError: String?

    private var nextInput: UIResponder? {
        didSet {
            inputTextField.returnKeyType = nextInput == nil ? (returnAction != nil ? .go : .done) : .next
        }
    }

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        prepareUI()
        prepareConstraints()
        translate(from: titleLabel, to: placeholderLabel, animated: false)
        updateValueState(needIndicator: false, animated: false)
    }
    
    deinit {
        timer?.invalidate()
    }

    // MARK: - UI

    private func prepareUI() {
        separatorView.backgroundColor = #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 0.3)

        errorLabel.text = " "
        errorLabel.font = UIFont.systemFont(ofSize: 10)
        errorLabel.textColor = .red
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .right

        titleLabel.font = UIFont.systemFont(ofSize: 10)
        titleLabel.textColor = .gray

        inputTextField.font = UIFont.systemFont(ofSize: 16)
        inputTextField.textColor = .gray
        inputTextField.borderStyle = .none
        inputTextField.tintColor = .gray
        inputTextField.rightViewMode = .always
        inputTextField.delegate = self
        inputTextField.keyboardDistanceFromTextField = 39.0

        placeholderLabel.font = UIFont.systemFont(ofSize: 14)
        placeholderLabel.textColor = .gray

        indicatorView.contentMode = .scaleAspectFit
        //indicatorView.image = #imageLiteral(resourceName: "ic_сross")

        eyeButton.setImage(R.image.ic_eye_off(), for: .normal)
        eyeButton.setImage(R.image.ic_eye_on(), for: .selected)
        eyeButton.imageView?.contentMode = .scaleAspectFit
        eyeButton.imageEdgeInsets.left = 4
        eyeButton.addTarget(self, action: #selector(didEyeButtonClicked(_:)), for: .touchUpInside)
        eyeButton.frame = CGRect(origin: .zero, size: CGSize(width: 24, height: 16))

        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapOnField)))
    }

    private func prepareConstraints() {
        [titleLabel, inputTextField, placeholderLabel,
         separatorView, errorLabel].forEach { addSubview($0) }
        indicatorRightView.addSubview(indicatorView)

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(3)
            make.left.equalToSuperview()
        }

        inputTextField.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(24.0)
            make.top.equalTo(titleLabel.snp.bottom).inset(-1)
        }

        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1.0)
            make.left.right.equalToSuperview()
            make.top.equalTo(inputTextField.snp.bottom).inset(-8.0)
        }

        placeholderLabel.snp.makeConstraints { make in
            make.centerY.equalTo(inputTextField)
            make.left.equalToSuperview()
        }

        errorLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(3)
            make.top.equalTo(separatorView.snp.bottom).inset(-3.0)
        }

        indicatorView.snp.makeConstraints { make in
            make.right.centerY.equalToSuperview()
            make.width.height.equalTo(12.0)
            make.left.equalToSuperview().inset(4.0)
        }
//
//        eyeButton.snp.makeConstraints { make in
//            make.width.equalTo(16.0)
//            make.height.equalTo(24.0)
//        }

    }

    private func translate(from: UILabel, to: UILabel, animated: Bool = true) {
        let scale = to.font.pointSize / from.font.pointSize
        let oldOrigin = from.frame.origin

        UIView.animate(withDuration: animated ? 0.25 : 0.0, delay: 0.0, options: [.curveEaseOut], animations: {
            from.transform = CGAffineTransform(scaleX: scale, y: scale)
            from.frame.origin = to.frame.origin
            self.layoutIfNeeded()
        }, completion: { _ in
            to.isHidden = false
            from.isHidden = true
            from.transform = .identity
            from.frame.origin = oldOrigin
        })
    }

    private func updateStateOfPlaceholder() {
        let isActive = inputTextField.isFirstResponder
        let hasValue = inputTextField.text?.isEmpty == false

        if isActive {
            translate(from: placeholderLabel, to: titleLabel)
        } else {
            if hasValue {
                translate(from: placeholderLabel, to: titleLabel)
            } else {
                translate(from: titleLabel, to: placeholderLabel)
            }
        }
    }

    private func didChangedValue() {
        timer?.invalidate()
        forceError = nil
        updateValueState()
        delegate?.didChangeValue(self)
    }

    // MARK: - Actions

    @objc private func didTapOnField() {
        inputTextField.becomeFirstResponder()
    }

    @objc private func didEyeButtonClicked(_ sender: UIButton) {
        sender.isSelected.toggle()
        inputTextField.isSecureTextEntry = !sender.isSelected
        inputTextField.font = .systemFont(ofSize: 16.0)
    }

    // MARK: - Public

    var value: String {
        get {
            inputTextField.text ?? ""
        }
        set {
            onTextChanged?(value)
            inputTextField.text = newValue
            if !newValue.isEmpty {
                updateStateOfPlaceholder()
                updateValueState()
            }
        }
    }

    var isValid: Bool {
        return validator?(inputTextField.text) == nil
    }

    func setup(with type: InputFieldType, nextInput: FloatingTextField? = nil) {
        titleLabel.text = type.placeHolder.capitalized
        placeholderLabel.text = type.placeHolder.capitalized
        inputTextField.rightView = type.needEyeSecure ? eyeButton : indicatorRightView
        inputTextField.isSecureTextEntry = type.needEyeSecure
        inputTextField.autocapitalizationType = type.capitalization
        inputTextField.keyboardType = type.keyboardType
        inputTextField.textContentType = type.contentType
        inputTextField.rightViewMode = type.needEyeSecure ? .always : .never
        self.type = type
        self.nextInput = nextInput?.inputTextField
        
        switch type {
        default: break
        }
    }
    
    private func setupDatePicker() {
        let picker = UIDatePicker()
        if #available(iOS 14, *) {
            picker.preferredDatePickerStyle = .wheels
            picker.sizeToFit()
        }
        picker.datePickerMode = .date
        picker.maximumDate = Date()
        picker.addTarget(self, action: #selector(pickerValueChanged), for: .valueChanged)
        inputTextField.inputView = picker
    }
    
    private func setupPicker() {
        let picker = UIPickerView()
        picker.dataSource = self
        picker.delegate = self
        inputTextField.inputView = picker
    }
    
    @objc private func pickerValueChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let value = formatter.string(from: sender.date)
        inputTextField.text = value
        onTextChanged?(value)
    }

    func updateValueState(needIndicator: Bool = true, animated: Bool = true) {
        let errorText = forceError ?? (validator?(inputTextField.text) as? ErrorDescription)?.message
        let isValueValid = errorText == nil
        errorLabel.isHidden = isValueValid
        errorLabel.setText(errorText ?? " ", animated: animated)

        if !type.needEyeSecure {
            inputTextField.rightViewMode = needIndicator ? .always : .never
            //indicatorView.setImage(isValueValid ? #imageLiteral(resourceName: "ic_tick") : #imageLiteral(resourceName: "ic_сross"), animated: animated)
        }
    }

    func applyError(_ text: String?) {
        forceError = text
        updateValueState()
    }
    
    func setupTitles() {
        if !errorLabel.isHidden {
            errorLabel.setText((validator?(inputTextField.text) as? ErrorDescription)?.message ?? "")
        }
    }
}

// MARK: - UITextFieldDelegate

extension FloatingTextField: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard textField.filterInputValue(filter: type.filter, shouldChangeCharactersIn: range, replacementString: string.trimmingCharacters(in: .whitespaces)) else { return false }
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
            self?.didChangedValue()
        })

        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let next: UIResponder = nextInput {
            next.becomeFirstResponder()
        } else {
            if let returnAction = returnAction {
                returnAction()
            }

            textField.resignFirstResponder()
        }

        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.didFocused(self)
        updateStateOfPlaceholder()
        if let pickerView = textField.inputView as? UIDatePicker {
            pickerView.sendActions(for: .valueChanged)
        } else if let picker = textField.inputView as? UIPickerView {
            inputTextField.text = pickerValues[safe: picker.selectedRow(inComponent: 0)]?.title
            selectedValue = pickerValues[safe: picker.selectedRow(inComponent: 0)]
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = textField.text?.trimmingCharacters(in: .whitespaces)
        updateStateOfPlaceholder()
        didChangedValue()
    }
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate

extension FloatingTextField: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        pickerValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        pickerValues[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        inputTextField.text = pickerValues[row].title
        selectedValue = pickerValues[row]
    }
}

protocol TitleIdible {
    var title: String { get }
    var id: String { get }
}
