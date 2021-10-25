import Foundation

extension RidersheepChangesViewModel {

    enum ModuleOutputAction {

    }

    struct ModuleInput {

    }

    struct ModuleOutput {
        let action: (ModuleOutputAction) -> Void
    }

}
