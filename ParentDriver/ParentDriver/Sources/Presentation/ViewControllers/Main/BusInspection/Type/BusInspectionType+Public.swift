import Foundation

extension BusInspectionTypeViewModel {

    enum ModuleOutputAction {
        case onNext(BusInspectionType, [InspectionPage])
        case showMenu
    }

    struct ModuleInput {
        
    }

    struct ModuleOutput {
        let action: (ModuleOutputAction) -> Void
    }

}
