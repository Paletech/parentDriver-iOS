import Foundation

protocol DashboardViewModelOutput: ViewModelOutput { }

class DashboardViewModel: BusSelectionProvider, MenuHandler {

    struct Dependencies { }

    let dependencies: Dependencies
    
    let moduleInput: ModuleInput
    var moduleOutput: ModuleOutput?
    
    weak var output: DashboardViewModelOutput!

    init(dependencies: Dependencies, data: ModuleInput) {
        self.dependencies = dependencies
        self.moduleInput = data
    }
    
    // MARK: - MenuHandler
    
    func onLeftMenuItemClick() {
        moduleOutput?.action(.showMenu)
    }
}

// MARK: - DashboardViewControllerOutput
extension DashboardViewModel: DashboardViewControllerOutput {
    func openMenuItem(_ item: MenuItem) {
        moduleOutput?.action(.showMenuItem(item))
    }
}
