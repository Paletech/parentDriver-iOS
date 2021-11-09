import Combine

protocol InspectionSubmitionViewModelOutput: ViewModelOutput {
    func updateSubmitEnabledState(value: Bool)
}

class InspectionSubmitionViewModel {

    private struct Constants {
        static let minCommentsSize: Int = 3
    }
    
    struct Dependencies {
        let interactor: InspectionInteractor
    }

    let dependencies: Dependencies
    
    let moduleInput: ModuleInput
    var moduleOutput: ModuleOutput?
    
    weak var output: InspectionSubmitionViewModelOutput!
    
    private var isSafeToOperate: Bool = false
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

// MARK: - InspectionSubmitionViewControllerOutput
extension InspectionSubmitionViewModel: InspectionSubmitionViewControllerOutput {
    private var builder: InspectionBuilder {
        moduleInput.builder
    }
    
    func changeIsSafeToOperate(value: Bool) {
        isSafeToOperate = value
    }
    
    func changeIsEverythingWasChecked(value: Bool) {
        output.updateSubmitEnabledState(value: value)
    }
    
    func submit(comment: String?) {
        if moduleInput.builder.failedIds.isEmpty {
            finishInspection(comments: comment)
        } else if let comment = comment {
            if comment.count < Constants.minCommentsSize {
                output.showMessage(Localizable.error_comments_required())
            } else {
                finishInspection(comments: comment)
            }
        } else {
            output.showMessage(Localizable.error_comments_required())
        }
    }
    
    private func finishInspection(comments: String?) {
        output.startActivity()
        dependencies.interactor.submitInspection(inspectionType: builder.inspectionType,
                                                 failedItems: builder.failedIds.unique,
                                                 inspectionStatus: isSafeToOperate ? .pass: .fail,
                                                 comments: comments).sink(receiveCompletion: { [weak self] completion in
            if case let .failure(error) = completion {
                if error is LocationError {
                    self?.output.showSettingsAlert()
                } else {
                    self?.output.catchError(error)
                }
            }
            self?.output.stopActivity()
        }, receiveValue: { [weak self] _ in
            self?.moduleOutput?.action(.submitted)
        })
        .store(in: &cancellables)
    }
}
