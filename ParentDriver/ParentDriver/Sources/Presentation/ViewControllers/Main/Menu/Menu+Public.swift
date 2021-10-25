import Foundation

extension MenuViewModel {

    enum ModuleOutputAction {
        case onItemSelected(MenuItem)
    }

    struct ModuleInput {

    }

    struct ModuleOutput {
        let action: (ModuleOutputAction) -> Void
    }

}
