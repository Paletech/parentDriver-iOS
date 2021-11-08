import Foundation

protocol InspectionSubmitionViewModelOutput: ViewModelOutput {

    func dataDidUpdate()
}

class InspectionSubmitionViewModel {

    struct Dependencies {
        let interactor: InspectionInteractor
    }

    let dependencies: Dependencies
    
    let moduleInput: ModuleInput
    var moduleOutput: ModuleOutput?
    
    weak var output: InspectionSubmitionViewModelOutput!

    init(dependencies: Dependencies, data: ModuleInput) {
        self.dependencies = dependencies
        self.moduleInput = data
    }
}

// MARK: - InspectionSubmitionViewControllerOutput
extension InspectionSubmitionViewModel: InspectionSubmitionViewControllerOutput {

    func start() {
        
    }

    func update() {
        output.dataDidUpdate()
    }
}
