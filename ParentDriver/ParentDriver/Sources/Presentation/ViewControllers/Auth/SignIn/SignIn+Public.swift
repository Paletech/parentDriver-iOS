import Foundation

extension SignInViewModel {

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
