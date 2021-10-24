import Foundation

extension SplashViewModel {

    enum ModuleOutputAction {
        case showMainFlow
        case showAuthFlow
        case showSelectBusFlow
    }

    struct ModuleInput {

    }

    struct ModuleOutput {
        let action: (ModuleOutputAction) -> Void
    }

}
