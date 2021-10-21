import Foundation

extension SignInViewModel {

    enum ModuleOutputAction {

    }

    struct ModuleInput {

    }

    struct ModuleOutput {
        let action: (ModuleOutputAction) -> Void
    }

}
