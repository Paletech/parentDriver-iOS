import Foundation

extension SignUpViewModel {

    enum ModuleOutputAction {
        case onSignedIn
        case onSignUp
    }

    struct ModuleInput {

    }

    struct ModuleOutput {
        let action: (ModuleOutputAction) -> Void
    }

}
