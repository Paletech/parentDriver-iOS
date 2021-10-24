import Foundation

extension SelectBusViewModel {

    enum ModuleOutputAction {
        case busSelected
    }

    struct ModuleInput {

    }

    struct ModuleOutput {
        let action: (ModuleOutputAction) -> Void
    }

}
