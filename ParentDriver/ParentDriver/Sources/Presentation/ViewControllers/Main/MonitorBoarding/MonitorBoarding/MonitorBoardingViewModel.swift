import Combine
import CoreFoundation
import Foundation

protocol MonitorBoardingViewModelOutput: ViewModelOutput {

    func dataDidUpdate()
}

class MonitorBoardingViewModel {

    private struct Constants {
        static let timerTick: TimeInterval = 5
    }
    
    struct Dependencies {
        let interactor: MonitorBoardingInteractor
    }

    let dependencies: Dependencies
    
    let moduleInput: ModuleInput
    var moduleOutput: ModuleOutput?
    
    weak var output: MonitorBoardingViewModelOutput!
    
    private var cancellables: [AnyCancellable] = []
    
    private var items: [MonitorBoardingUIModel] = []
    private var timer: Timer?
    
    // MARK: - Deinit/init
    
    deinit {
        timer?.invalidate()
        timer = nil
        cancellables.forEach { $0.cancel() }
    }

    init(dependencies: Dependencies, data: ModuleInput) {
        self.dependencies = dependencies
        self.moduleInput = data
    }
}

// MARK: - MonitorBoardingViewControllerOutput
extension MonitorBoardingViewModel: MonitorBoardingViewControllerOutput {
    
    func start() {
        getMonitorBoarding()
        setupTimer()
    }
    
    func numberOfImtes() -> Int {
        return 1
        //items.count
    }
    func item(for indexPath: IndexPath) -> MonitorBoardingUIModel {
        let jsonString = "{\"studentName\":\"LOCKE, Patrick\",\"alert\":\"Tag read 0.58 miles from Dad's Work and 0.83 miles from NFT High School.\", \"time\":\"9:49 am - 9:48 am\"}"
        let item = MonitorBoarding(JSONString: jsonString, context: nil)
        let mockResult = MonitorBoardingUIModel(status: item!)
        return mockResult
        //return items[indexPath.row]
    }
    
    func onAdd() {
        moduleOutput?.action(.onAdd)
    }
    
    func onLeftMenuItemClick() {
        moduleOutput?.action(.onShowMenu)
    }
    
    // MARK: - Private
    
    private func setupTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: Constants.timerTick, repeats: true, block: { [weak self]  _ in
            self?.getMonitorBoarding(withActivity: false)
        })
        timer?.fire()
    }
    
    private func getMonitorBoarding(withActivity: Bool = true) {
        if withActivity {
            output.startActivity()
        }
        dependencies.interactor.getAll().sink(receiveCompletion: { [weak self] completion in
            if case let .failure(error) = completion {
                self?.output.catchError(error)
            }
            if withActivity {
                self?.output.stopActivity()
            }
        }, receiveValue: { [weak self] items in
            self?.items = items.map { MonitorBoardingUIModel(status: $0) }
            self?.output.dataDidUpdate()
        })
        .store(in: &cancellables)
    }
}
