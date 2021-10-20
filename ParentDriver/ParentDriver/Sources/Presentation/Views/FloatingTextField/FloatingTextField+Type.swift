import UIKit

enum InputFieldType {

    case email
    

    var placeHolder: String {
        switch self {
        case .email:
            return "eamil"
        }
    }

    var capitalization: UITextAutocapitalizationType {
        switch self {
        default:
            return .none
        }
    }

    var contentType: UITextContentType? {
        switch self {
        case .email:
            return .emailAddress
        default:
            return nil
        }
    }

    var keyboardType: UIKeyboardType {
        switch self {
        case .email:
            return .emailAddress
        default:
            return .default
        }
    }

    var filter: String? {
        switch self {
        case .email:
            return "[a-zA-z0-9@._-]"
        default:
            return nil
        }
    }

    var needEyeSecure: Bool {
        switch self {
        default:
            return false
        }
    }
}
