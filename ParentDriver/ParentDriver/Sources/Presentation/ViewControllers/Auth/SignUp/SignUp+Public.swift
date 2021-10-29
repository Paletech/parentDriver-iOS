import Foundation

extension SignUpViewModel {

    enum ModuleOutputAction {
        case onSignedUp
    }

    struct ModuleInput {

    }

    struct ModuleOutput {
        let action: (ModuleOutputAction) -> Void
    }

}
