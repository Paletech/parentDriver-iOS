import Foundation

extension BusInspectionViewModel {

    enum ModuleOutputAction {
        case next([String])
    }

    struct ModuleInput {
        let page: InspectionPage
    }

    struct ModuleOutput {
        let action: (ModuleOutputAction) -> Void
    }

}
