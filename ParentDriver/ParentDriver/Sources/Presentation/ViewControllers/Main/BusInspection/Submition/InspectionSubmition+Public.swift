import Foundation

extension InspectionSubmitionViewModel {

    enum ModuleOutputAction {
        case submitted
    }

    struct ModuleInput {
        let builder: InspectionBuilder
    }

    struct ModuleOutput {
        let action: (ModuleOutputAction) -> Void
    }

}
