import Foundation

protocol BusInspectionViewModelOutput: ViewModelOutput {

    func dataDidUpdate()
}

class BusInspectionViewModel {

    struct Dependencies { }

    let dependencies: Dependencies
    
    let moduleInput: ModuleInput
    var moduleOutput: ModuleOutput?
    
    weak var output: BusInspectionViewModelOutput!

    init(dependencies: Dependencies, data: ModuleInput) {
        self.dependencies = dependencies
        self.moduleInput = data
    }
}

// MARK: - BusInspectionViewControllerOutput
extension BusInspectionViewModel: BusInspectionViewControllerOutput {

    func start() {
        
    }

    func update() {
        output.dataDidUpdate()
    }
}
