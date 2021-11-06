import Foundation

extension AddStudentViewModel {

    enum ModuleOutputAction {
        case added
    }

    struct ModuleInput {
        let completion: EmptyClosure
    }

    struct ModuleOutput {
        let action: (ModuleOutputAction) -> Void
    }

}
