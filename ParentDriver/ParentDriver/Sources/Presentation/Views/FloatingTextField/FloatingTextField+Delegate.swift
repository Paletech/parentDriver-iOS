import Foundation

protocol ValidatableTextFieldDelegate: AnyObject {
    func didChangeValue(_ inputField: FloatingTextField)
    func didFocused(_ inputField: FloatingTextField)
}

extension ValidatableTextFieldDelegate {
    func didChangeValue(_ inputField: FloatingTextField) {}
    func didFocused(_ inputField: FloatingTextField) {}
}
