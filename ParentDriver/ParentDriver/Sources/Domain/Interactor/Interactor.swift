import UIKit

protocol ErrorDescription {
    var message: String { get }
}

indirect public enum AuthInteractorError: Error, ErrorDescription {

    case emptyValue
    case user(AuthInteractorError)
    case password
    
    // MARK: - ErrorDescription

    var message: String {
        switch self {

        case .emptyValue:
            return Localizable.error_empty_field()
        case .user(let error):
            return error.localizedDescription
        case .password:
            return Localizable.error_general()
        }
    }

}

protocol Interactor {

}

extension Interactor {
    
    func validate(text: String?) -> Result<String, AuthInteractorError> {
        Validator()
            .length(1, .emptyValue)
            .validate(text)
    }
    
    func validate(name: String?) -> Result<String, AuthInteractorError> {
        Validator()
            .length(1, .emptyValue)
            .validate(name)
    }
    
    func validate(password: String?) -> Result<String, AuthInteractorError> {
        Validator()
            .length(1, .emptyValue)
            .password(.user(.password))
            .validate(password)
    }
}
