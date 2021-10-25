import Foundation
import Combine

protocol SelectBusViewModelOutput: ViewModelOutput {
    func dataDidUpdate()
}

class SelectBusViewModel {
    
    private struct Constants {
        static let minSearchCount = 3
    }

    struct Dependencies {
        let interactor: BusInteractor
    }

    let dependencies: Dependencies
    
    let moduleInput: ModuleInput
    var moduleOutput: ModuleOutput?
    
    weak var output: SelectBusViewModelOutput!
    
    private var items: [Bus] = []
    private var filteredItems: [Bus] = []
    private var latestQuery: String?
    
    private var cancellables = [AnyCancellable]()

    // MARK: - Init/Deinit

    init(dependencies: Dependencies, data: ModuleInput) {
        self.dependencies = dependencies
        self.moduleInput = data
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}

// MARK: - SelectBusViewControllerOutput
extension SelectBusViewModel: SelectBusViewControllerOutput {
    
    func start() {
        output.startActivity()
        dependencies.interactor.getAllBuses().sink(receiveCompletion: { [weak self] completion in
            if case let .failure(error) = completion {
                self?.output.catchError(error)
            }
            self?.output.stopActivity()
        }, receiveValue: { [weak self] items in
            self?.items = items
            self?.filteredItems = items
            self?.output.dataDidUpdate()
        })
        .store(in: &cancellables)
    }
    
    func numberOfItems() -> Int {
        filteredItems.count
    }
    
    func titleForItem(at indexPath: IndexPath) -> String {
        filteredItems[safe: indexPath.row]?.trackerName ?? ""
    }
    
    func selectItem(at indexPath: IndexPath) {
        filteredItems[safe: indexPath.row].flatMap {
            dependencies.interactor.saveBusSelection($0)
            moduleOutput?.action(.busSelected)
        }
    }
    
    func searchForQuery(_ query: String) {
        if query == latestQuery {
            return
        } else if query.count < Constants.minSearchCount {
            filteredItems = items
            output.dataDidUpdate()
        } else {
            filteredItems = items.filter { $0.trackerName.contains(query) }
            output.dataDidUpdate()
        }
        
        latestQuery = query
    }
}
