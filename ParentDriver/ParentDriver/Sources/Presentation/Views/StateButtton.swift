import UIKit

class StateButtton: UIButton {
    
    struct Constatns {
        static let height: CGFloat = 50.0
    }

    var mainColor: UIColor = .blue
    var disabledColor: UIColor = UIColor.blue.withAlphaComponent(0.3)

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
    }

    // MARK: - UI

    private func prepareUI() {
        let color = isEnabled ? mainColor : disabledColor
        backgroundColor = color
        applyShadow(color: color, alpha: 0.4, x: 0, y: 4, blur: 30)
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.numberOfLines = 2
        titleLabel?.textAlignment = .center
    }
    
    func setDefaultStyle() {
        disabledColor = UIColor.blue.withAlphaComponent(0.3)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        layer.cornerRadius = Constatns.height / 2.0
    }

    // MARK: - Base Overrides

    func setEnabled(_ value: Bool, animated: Bool = true) {
        self.isEnabled = value
        let newColor = self.isEnabled ? self.mainColor : self.disabledColor

        if !animated {
            backgroundColor = newColor
            layer.shadowOpacity = isEnabled ? 0.4 : 0.0
        } else {
            UIView.animate(withDuration: 0.3) {
                self.backgroundColor = newColor
                self.layer.shadowOpacity = self.isEnabled ? 0.4 : 0.0
            }
        }
    }
}

class CommonButtton: UIButton {
    
    struct Constatns {
        static let height: CGFloat = 50.0
    }

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareUI()
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        prepareUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        round()
    }

    // MARK: - UI
    private func prepareUI() {
        backgroundColor = .blue
        applyShadow(color: UIColor.blue, alpha: 0.4, x: 0, y: 4, blur: 30)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
}
