import Foundation

protocol RidersheepChangesViewModelOutput: ViewModelOutput {

    func dataDidUpdate()
}

class RidersheepChangesViewModel {

    struct Dependencies { }

    let dependencies: Dependencies
    
    let moduleInput: ModuleInput
    var moduleOutput: ModuleOutput?
    
    weak var output: RidersheepChangesViewModelOutput!

    init(dependencies: Dependencies, data: ModuleInput) {
        self.dependencies = dependencies
        self.moduleInput = data
    }
}

// MARK: - RidersheepChangesViewControllerOutput
extension RidersheepChangesViewModel: RidersheepChangesViewControllerOutput {

    func start() {
        
    }

    func update() {
        output.dataDidUpdate()
    }
}
