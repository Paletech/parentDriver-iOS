import UIKit

extension UITextField {

    func filterInputValue(filter: String?, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let filter = filter, !string.isEmpty else { return true }
        return string.matches(filter)
    }
}

extension UIImageView {

    func setImage(_ image: UIImage?, style: UIView.AnimationOptions = .transitionCrossDissolve, animated: Bool = true) {
        UIView.transition(with: self, duration: animated ? 0.25 : 0.0, options: [style], animations: { [weak self] in
            self?.image = image
        })
    }
}

extension UILabel {

    func setText(_ text: String = "", style: UIView.AnimationOptions = .transitionCrossDissolve, animated: Bool = true) {
        UIView.transition(with: self, duration: animated ? 0.25 : 0.0, options: [style], animations: { [weak self] in
            self?.text = text
        })
    }

    func setTextColor(_ color: UIColor, animated: Bool = true) {
        UIView.animate(withDuration: animated ? 0.25 : 0.0) { [weak self] in
            self?.textColor = color
        }
    }
}
