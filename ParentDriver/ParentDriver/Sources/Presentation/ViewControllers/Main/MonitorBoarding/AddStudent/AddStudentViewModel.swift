import Foundation

protocol AddStudentViewModelOutput: ViewModelOutput {

    func dataDidUpdate()
}

class AddStudentViewModel {

    struct Dependencies { }

    let dependencies: Dependencies
    
    let moduleInput: ModuleInput
    var moduleOutput: ModuleOutput?
    
    weak var output: AddStudentViewModelOutput!

    init(dependencies: Dependencies, data: ModuleInput) {
        self.dependencies = dependencies
        self.moduleInput = data
    }
}

// MARK: - AddStudentViewControllerOutput
extension AddStudentViewModel: AddStudentViewControllerOutput {

    func start() {
        
    }

    func update() {
        output.dataDidUpdate()
    }
}
