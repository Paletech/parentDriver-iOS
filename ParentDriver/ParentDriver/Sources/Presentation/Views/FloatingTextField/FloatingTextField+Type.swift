import UIKit

enum InputFieldType {
    
    case driverId
    case password
    case schoolId
    
    
    var placeHolder: String {
        switch self {
        case .driverId:
            return Localizable.placeholder_driver_id()
        case .password:
            return Localizable.placeholder_password()
        case .schoolId:
            return Localizable.placeholder_school_id()
        }
    }
    
    var capitalization: UITextAutocapitalizationType {
        return .none
    }
    
    var contentType: UITextContentType? {
        switch self {
        case .password:
            return .password
        default: return .none
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .password:
            return .default
        case .schoolId, .driverId:
            return .decimalPad
        }
    }
    
    var filter: String? {
        return nil
    }
    
    var needEyeSecure: Bool {
        switch self {
        case .password:
            return true
        default:
            return false
        }
    }
}
