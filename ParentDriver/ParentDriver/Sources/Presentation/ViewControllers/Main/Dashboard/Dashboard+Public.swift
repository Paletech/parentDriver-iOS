import Foundation

extension DashboardViewModel {

    enum ModuleOutputAction {
        case showMenu
        case showMenuItem(MenuItem)
    }

    struct ModuleInput {

    }

    struct ModuleOutput {
        let action: (ModuleOutputAction) -> Void
    }

}
