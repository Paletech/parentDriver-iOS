import Foundation

extension AddStudentViewModel {

    enum ModuleOutputAction {

    }

    struct ModuleInput {

    }

    struct ModuleOutput {
        let action: (ModuleOutputAction) -> Void
    }

}
