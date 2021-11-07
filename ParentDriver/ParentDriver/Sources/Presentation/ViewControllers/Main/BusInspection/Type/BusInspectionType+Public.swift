import Foundation

extension BusInspectionTypeViewModel {

    enum ModuleOutputAction {
        case onNext([InspectionPage])
        case showMenu
    }

    struct ModuleInput {
        
    }

    struct ModuleOutput {
        let action: (ModuleOutputAction) -> Void
    }

}
