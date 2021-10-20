import UIKit

protocol ErrorDescription {
    var message: String { get }
}

public enum AuthInteractorError: Error, ErrorDescription {

    case emailInvalid
    case emptyValue
    
    // MARK: - ErrorDescription

    var message: String {
        switch self {
        case .emailInvalid:
            return R.string.localizable.error_email()
        case .emptyValue:
            return Localizable.error_email()
        default:
            return String()
        }
    }

}

indirect enum HappyHabitError: LocalizedError {
    case emptyField
    case email
    case password
    case confirm
    case user(HappyHabitError)
    
    public var errorDescription: String? {
        switch self {
        case .emptyField:
            return Localizable.error_empty_field()
        case .email:
            return Localizable.error_email()
        case .user(let error):
            return error.errorDescription
        default:
            return Localizable.error_general()
        }
    }
}

protocol Interactor {

}

extension Interactor {
    
    func validate(text: String?) -> Result<String, HappyHabitError> {
        Validator()
            .length(1, .emptyField)
            .validate(text)
    }
    
    func validate(name: String?) -> Result<String, HappyHabitError> {
        Validator()
            .length(1, .emptyField)
            .validate(name)
    }
    
    func validate(email: String?) -> Result<String, HappyHabitError> {
        Validator()
            .length(1, .emptyField)
            .email(.user(.email))
            .validate(email)
    }
    
    func validate(password: String?) -> Result<String, HappyHabitError> {
        Validator()
            .length(1, .emptyField)
            .password(.user(.password))
            .validate(password)
    }
    
    func validate(password: String?, confirm: String?) -> Result<String, HappyHabitError> {
        Validator()
            .isEqual(password, .user(.confirm))
            .validate(confirm)
    }
}
