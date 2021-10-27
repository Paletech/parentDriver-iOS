import Foundation

extension MonitorBoardingViewModel {

    enum ModuleOutputAction {
        case onAdd
        case onShowMenu
    }

    struct ModuleInput {

    }

    struct ModuleOutput {
        let action: (ModuleOutputAction) -> Void
    }

}
