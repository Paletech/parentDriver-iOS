import Foundation
import Combine
import CoreLocation

protocol AddStudentViewModelOutput: ViewModelOutput { }

class AddStudentViewModel {

    private struct Constants {
        static let minSearchCount = 3
    }

    struct Dependencies {
        let interactor: StudentInteractor
        let locationInteractor: LocationInteractor
    }

    let dependencies: Dependencies
    
    let moduleInput: ModuleInput
    var moduleOutput: ModuleOutput?
    
    weak var output: AddStudentViewModelOutput!
    
    private var items: [Student] = []
    private var filteredItems: [Student] = []

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

// MARK: - AddStudentViewControllerOutput
extension AddStudentViewModel: AddStudentViewControllerOutput {
    func searchForQuery(_ query: String) {
        if query.count >= Constants.minSearchCount {
            output.startActivity()
            dependencies.interactor.findStudent(studentName: query).sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.output.catchError(error)
                }
                self?.output.stopActivity()
            }, receiveValue: { [weak self] items in
                self?.filteredItems = items
                self?.output.dataDidUpdate()
            })
            .store(in: &cancellables)
        } else {
            filteredItems = items
            output.dataDidUpdate()
        }
    }
    
    func start() {
        output.startActivity()
        dependencies.interactor.findStudent(studentName: "").sink(receiveCompletion: { [weak self] completion in
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
        return filteredItems.count
    }
    
    func titleForItem(at indexPath: IndexPath) -> String {
        return filteredItems[indexPath.row].name
    }
    
    func selectItem(at indexPath: IndexPath) {
        let student = filteredItems[indexPath.row]
        
        output.startActivity()
        
        dependencies.locationInteractor.getAccess()
        .map {
            self.dependencies.locationInteractor.getLocation()
        }
        .switchToLatest()
        .map {
            self.dependencies.interactor.addStudent(studentId: student.id, coordinates: $0.coordinate.toString)
        }
        .switchToLatest()
        .eraseToAnyPublisher()
        .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    if error is LocationError {
                        self?.output.showSettingsAlert()
                    } else {
                        self?.output.catchError(error)
                    }
                }
                self?.output.stopActivity()
            }, receiveValue: { [weak self] _ in
                self?.moduleOutput?.action(.added)
                self?.moduleInput.completion()
            })
        .store(in: &cancellables)
    }
}
