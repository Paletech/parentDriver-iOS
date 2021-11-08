import Combine

protocol BusInspectionTypeViewModelOutput: ViewModelOutput {

    func dataDidUpdate()
}

class BusInspectionTypeViewModel {

    struct Dependencies {
        let inspectionInteractor: InspectionInteractor
    }

    let dependencies: Dependencies
    
    let moduleInput: ModuleInput
    var moduleOutput: ModuleOutput?
    
    weak var output: BusInspectionTypeViewModelOutput!

    private var selectedType: BusInspectionType?
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

// MARK: - BusInspectionTypeViewControllerOutput
extension BusInspectionTypeViewModel: BusInspectionTypeViewControllerOutput {
    var isNextButtonEnabled: Bool { selectedType != nil }
    
    func onLeftMenuItemClick() {
        moduleOutput?.action(.showMenu)
    }
    
    func selectInspectionType(_ type: BusInspectionType) {
        selectedType = type
        output.dataDidUpdate()
    }
    
    func onNext() {
        guard let inspectionType = selectedType else { return }
        
        output.startActivity()
        dependencies.inspectionInteractor.getInspection().sink(receiveCompletion: { [weak self] completion in
            if case let .failure(error) = completion {
                self?.output.catchError(error)
            }
            self?.output.stopActivity()
        }, receiveValue: { [weak self] pages in
            self?.moduleOutput?.action(.onNext(inspectionType, pages))
        })
    .store(in: &cancellables)
    }
}
