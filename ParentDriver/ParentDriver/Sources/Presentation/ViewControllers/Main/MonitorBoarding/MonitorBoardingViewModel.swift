import Foundation

protocol MonitorBoardingViewModelOutput: ViewModelOutput {

    func dataDidUpdate()
}

class MonitorBoardingViewModel {

    struct Dependencies { }

    let dependencies: Dependencies
    
    let moduleInput: ModuleInput
    var moduleOutput: ModuleOutput?
    
    weak var output: MonitorBoardingViewModelOutput!

    init(dependencies: Dependencies, data: ModuleInput) {
        self.dependencies = dependencies
        self.moduleInput = data
    }
}

// MARK: - MonitorBoardingViewControllerOutput
extension MonitorBoardingViewModel: MonitorBoardingViewControllerOutput {

    func start() {
        
    }

    func update() {
        output.dataDidUpdate()
    }
}
