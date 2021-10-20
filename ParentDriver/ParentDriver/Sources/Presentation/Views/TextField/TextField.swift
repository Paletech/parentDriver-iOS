import UIKit

class TextField: UITextField {

    typealias Start = () -> Void
    typealias End = () -> Void
    typealias Exit = () -> Void
    typealias Validator = (String?) -> Bool
    typealias UpdateText = (String?) -> Void

    var errorColor: UIColor = .red
    var normalTextColor: UIColor = .systemBlue
    var normalDividerColor: UIColor = .lightGray
    var editingDividerColor: UIColor = .darkGray
    var defaultDividerColor: UIColor = .lightGray

    private let divider = UIImageView()
    private var validator: Validator!
    private var onExit: Exit?
    private var end: End?
    private var updateText: UpdateText!
    private var start: Start?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    func setPlaceholder(_ text: String?, color: UIColor = UIColor.lightGray) {
        attributedPlaceholder = NSAttributedString(string: text ?? "", attributes: [.foregroundColor: color])
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.insetBy(dx: 10.0, dy: 0.0)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    func setText(_ text: String?) {
        if validator(text) {
            normalState()
        } else {
            errorState()
        }
        self.text = text
    }
    
    func onExit(_ exit: @escaping Exit) {
        self.onExit = exit
    }

    func end(_ end: @escaping Exit) {
        self.end = end
    }

    func start(_ start: @escaping Start) {
        self.start = start
    }

    func validate(_ validator: @escaping Validator) {
        self.validator = validator
    }

    func updateText(_ updateText: @escaping UpdateText) {
        self.updateText = updateText
    }

    private func setup() {
        addDivider()
        normalState()
        delegate = self
    }

    func normalState() {
        textColor = normalTextColor

        if text?.count == 0 {
            divider.backgroundColor = defaultDividerColor
        } else {
            divider.backgroundColor = normalDividerColor
        }
    }

    func editingState() {
        textColor = normalTextColor
        divider.backgroundColor = editingDividerColor
    }

    private func errorState() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - 10, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + 10, y: center.y))
        layer.add(animation, forKey: "position")

        textColor = errorColor
        divider.backgroundColor = errorColor
    }

    private func addDivider() {
        addSubview(divider)
        divider.translatesAutoresizingMaskIntoConstraints = false

        let views = ["divider": divider]
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[divider]|",
                                                                   options: NSLayoutConstraint.FormatOptions.alignAllCenterY,
                                                                   metrics: nil,
                                                                   views: views)

        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[divider(1)]|",
                                                                 options: NSLayoutConstraint.FormatOptions.alignAllCenterX,
                                                                 metrics: nil,
                                                                 views: views)
        addConstraints(horizontalConstraints)
        addConstraints(verticalConstraints)
    }
}

extension TextField: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        editingState()
        start?()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if validator(textField.text) {
            normalState()
        } else {
            errorState()
        }
        end?()
    }

    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        editingState()
        
        let textReasult = TextFieldDelegate().textField(textField, shouldChangeCharactersIn: range, replacementString: string)
        updateText(textReasult.text)
        return textReasult.shouldChange
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.onExit?()
        return true
    }
}

class TextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> (shouldChange: Bool, text: String) {
        let newString = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        return (true, newString)
    }
}
