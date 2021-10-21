import Foundation

extension SplashViewModel {

    enum ModuleOutputAction {
        case mainFlow
        case authFlow
    }

    struct ModuleInput {

    }

    struct ModuleOutput {
        let action: (ModuleOutputAction) -> Void
    }

}
