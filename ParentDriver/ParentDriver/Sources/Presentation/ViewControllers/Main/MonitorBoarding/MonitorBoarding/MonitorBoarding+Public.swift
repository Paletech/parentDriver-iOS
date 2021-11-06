import Foundation

extension MonitorBoardingViewModel {

    enum ModuleOutputAction {
        case onAdd(EmptyClosure)
        case onShowMenu
    }

    struct ModuleInput {

    }

    struct ModuleOutput {
        let action: (ModuleOutputAction) -> Void
    }

}
