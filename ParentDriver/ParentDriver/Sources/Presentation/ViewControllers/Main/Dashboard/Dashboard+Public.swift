import Foundation

extension DashboardViewModel {

    enum ModuleOutputAction {
        case showMenu
    }

    struct ModuleInput {

    }

    struct ModuleOutput {
        let action: (ModuleOutputAction) -> Void
    }

}
