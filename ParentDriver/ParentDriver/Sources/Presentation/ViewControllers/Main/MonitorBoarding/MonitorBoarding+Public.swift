import Foundation

extension MonitorBoardingViewModel {

    enum ModuleOutputAction {

    }

    struct ModuleInput {

    }

    struct ModuleOutput {
        let action: (ModuleOutputAction) -> Void
    }

}
