import Combine
import CoreFoundation
import Foundation

protocol RidersheepChangesViewModelOutput: ViewModelOutput {

    func dataDidUpdate()
}

class RidersheepChangesViewModel {

    struct Dependencies {
        let interactor: RidersheepChangesInteractor
    }

    let dependencies: Dependencies
    
    let moduleInput: ModuleInput
    var moduleOutput: ModuleOutput?

    private var cancellables: [AnyCancellable] = []

    weak var output: RidersheepChangesViewModelOutput!

    private var items: [RidersheepChangesUIModel] = []

    init(dependencies: Dependencies, data: ModuleInput) {
        self.dependencies = dependencies
        self.moduleInput = data
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
        getRidersheepChanges()
    }

    func update() {
        output.dataDidUpdate()
    }

    private func getRidersheepChanges() {
        output.startActivity()
        dependencies.interactor.getAll().sink(receiveCompletion: { [weak self] completion in
            if case let .failure(error) = completion {
                self?.output.catchError(error)
            }
            self?.output.stopActivity()
        }, receiveValue: { [weak self] items in
            self?.items = items.map { RidersheepChangesUIModel(data: $0) }
            self?.output.dataDidUpdate()
        })
        .store(in: &cancellables)
    }
}
