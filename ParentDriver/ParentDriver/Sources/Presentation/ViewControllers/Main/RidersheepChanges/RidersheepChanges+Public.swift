import Foundation

extension RidersheepChangesViewModel {

    enum ModuleOutputAction {
        case showMenu
    }

    struct ModuleInput {

    }

    struct ModuleOutput {
        let action: (ModuleOutputAction) -> Void
    }

}
