import Foundation

extension BusInspectionViewModel {

    enum ModuleOutputAction {

    }

    struct ModuleInput {

    }

    struct ModuleOutput {
        let action: (ModuleOutputAction) -> Void
    }

}
