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

    private var items: [RidersheepChangesUIModel] = []

    init(dependencies: Dependencies, data: ModuleInput) {
        self.dependencies = dependencies
        self.moduleInput = data

        let object1 = RidersheepChangesUIModel(student: "", campus: "", address: "")
        items.append(object1)
    }
}

// MARK: - RidersheepChangesViewControllerOutput
extension RidersheepChangesViewModel: RidersheepChangesViewControllerOutput {
    func onLeftMenuItemClick() {
        moduleOutput?.action(.showMenu)
    }

    func numberOfItems() -> Int {
        return items.count
    }
    func item(for indexPath: IndexPath) -> RidersheepChangesUIModel {
        return items[indexPath.row]
    }

    func start() {
        
    }

    func update() {
        output.dataDidUpdate()
    }
}
