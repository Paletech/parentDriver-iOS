import UIKit
import SnapKit

extension UIView {
    
    @IBInspectable public var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }

    @IBInspectable public var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor ?? UIColor.black.cgColor) }
        set { layer.borderColor = newValue.cgColor }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }

    internal class func instanceFromNib<T: UIView>() -> T {
        let nib = UINib(nibName: "\(T.self)", bundle: nil)
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? T  else {
            fatalError("\(T.self) not found")
        }
        return view
    }

    func addView(_ view: UIView, _ top: Int = 0) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(top)-[view]|",
                                                      options: .alignAllLeading,
                                                      metrics: ["top": top],
                                                      views: ["view": view])

        let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                        options: .alignAllLeading,
                                                        metrics: nil,
                                                        views: ["view": view])
        self.addConstraints(vertical)
        self.addConstraints(horizontal)
    }

    func addBottomPopup(_ view: UIView, _ bottom: Int = 0) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)

        let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:[view]-(bottom)-|",
                                                      options: .alignAllLeading,
                                                      metrics: ["bottom": bottom],
                                                      views: ["view": view])

        let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                        options: .alignAllLeading,
                                                        metrics: nil,
                                                        views: ["view": view])
        self.addConstraints(vertical)
        self.addConstraints(horizontal)
    }

    class func animate(_ transaction: @autoclosure @escaping () -> Void) {
        self.animate(withDuration: 0.35, animations: transaction)
    }

    func addStretchedSubview(_ view: UIView) {
        addSubview(view)
        view.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    func applyShadow(color: UIColor = .black, alpha: Float = 0.5,
                     x: CGFloat = 0, y: CGFloat = 0,
                     blur: CGFloat = 4, spread: CGFloat = 0) {

        layer.shadowColor = color.cgColor
        layer.shadowOpacity = alpha
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur

        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let daxis = -spread
            let rect = bounds.insetBy(dx: daxis, dy: daxis)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }

    func round() {
        layer.cornerRadius = frame.height / 2.0
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
    }

    // MARK: - IBInspectable

    @IBInspectable var isRounded: Bool {
        get { return layer.cornerRadius == (layer.frame.height / 2.0) }
        set { layer.cornerRadius = layer.frame.height / 2.0 }
    }

    // MARK: - Animations

    func updateLayoutAnimated(with duration: TimeInterval = 0.25, completion: EmptyClosure? = nil) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: duration, animations: {
                self.layoutIfNeeded()
            }, completion: { _ in
                completion?()
            })
        }
    }

    func updateLayout(animated: Bool, completion: EmptyClosure? = nil) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: animated ? 0.25 : 0.0, animations: {
                self.layoutIfNeeded()
            }, completion: { _ in
                completion?()
            })
        }
    }

    func show(_ isVisible: Bool, delay: TimeInterval = 0.0, animated: Bool = true) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: animated ? 0.25 : 0.0, delay: delay, options: [], animations: { [weak self] in
                self?.alpha = isVisible ? 1.0 : 0.0
            }, completion: nil)
        }
    }

    func stackViewShowItem(_ isVisible: Bool, animated: Bool = true) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: animated ? 0.25 : 0.0, delay: 0.0, options: [], animations: { [weak self] in
                self?.isHidden = !isVisible
                self?.alpha = isVisible ? 1.0 : 0.0
            }, completion: nil)
        }
    }

    func hide(_ isHidden: Bool, delay: TimeInterval = 0.0, animated: Bool = true) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: animated ? 0.25 : 0.0, delay: delay, options: [], animations: { [weak self] in
                self?.isHidden = isHidden
            }, completion: nil)
        }
    }

    func animateSelection(_ isHiglited: Bool) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.2, animations: {
                self.transform = isHiglited ? CGAffineTransform(scaleX: 1.1, y: 1.1) : .identity
            })
        }
    }

    static func highlightAnimatedItem(items: [UIView]) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.125, animations: {
                items.forEach({ $0.alpha = 0.3})
            }, completion: { _ in
                UIView.animate(withDuration: 0.125) {
                    items.forEach({ $0.alpha = 1.0})
                }
            })
        }
    }

    // MARK: - Shadow

    var shadowView: ShadowView? {
        return subviews.compactMap { $0 as? ShadowView }.first
    }

    func addShadowView(with color: UIColor = #colorLiteral(red: 0.03137254902, green: 0.01568627451, blue: 0.01568627451, alpha: 0.6)) {
        let shadowView = ShadowView(color: color)
        addSubview(shadowView)
        sendSubviewToBack(shadowView)

        shadowView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(2.0)
        }

        shadowView.show()
    }

    func removeShadow() {
        subviews.compactMap({ $0 as? ShadowView }).forEach { $0.hide() }
    }
    
    func animateBorderColor(toColor: UIColor, duration: Double) {
        let animation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = layer.borderColor
        animation.toValue = toColor.cgColor
        animation.duration = duration
        layer.add(animation, forKey: "borderColor")
        layer.borderColor = toColor.cgColor
      }
}
