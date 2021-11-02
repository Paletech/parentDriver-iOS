import Foundation

protocol MenuViewModelOutput: ViewModelOutput {

    func dataDidUpdate()
}

class MenuViewModel {

    struct Dependencies {}

    let dependencies: Dependencies
    
    let moduleInput: ModuleInput
    var moduleOutput: ModuleOutput?
    
    weak var output: MenuViewModelOutput!

    init(dependencies: Dependencies, data: ModuleInput) {
        self.dependencies = dependencies
        self.moduleInput = data
    }
}

// MARK: - MenuViewControllerOutput
extension MenuViewModel: MenuViewControllerOutput {
    func numberOfItems() -> Int {
        return MenuItem.sorted.count
    }
    
    func titleForItemAt(at indexPath: IndexPath) -> String? {
        MenuItem.sorted[safe: indexPath.row]?.title
    }
    
    func selectItem(at indexPath: IndexPath) {
        MenuItem.sorted[safe: indexPath.row].flatMap {
            moduleOutput?.action(.onItemSelected($0))
        }
    }
}
