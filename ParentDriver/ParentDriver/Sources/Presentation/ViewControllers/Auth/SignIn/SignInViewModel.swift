import Foundation
import Combine

protocol SignInViewModelOutput: ViewModelOutput {
    func updateSignUpVisibility(value: Bool)
}

class SignInViewModel {

    struct Dependencies {
        let interactor: AuthInteractor
    }

    let dependencies: Dependencies
    
    let moduleInput: ModuleInput
    var moduleOutput: ModuleOutput?
    
    weak var output: SignInViewModelOutput!
    
    private var cancellables = [AnyCancellable]()

    init(dependencies: Dependencies, data: ModuleInput) {
        self.dependencies = dependencies
        self.moduleInput = data
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
}

// MARK: - SignInViewControllerOutput
extension SignInViewModel: SignInViewControllerOutput {
    func signIn(driverID: String, password: String, schoolId: String) {
        output.startActivity()
        dependencies.interactor.signIn(driverId: driverID,
                                       password: password,
                                       schoolId: schoolId)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.output.catchError(error)
                }
                self?.output.stopActivity()
            }, receiveValue: { [weak self] _ in
                self?.moduleOutput?.action(.onSignedIn)
            })
            .store(in: &cancellables)
    }
    
    func onSignUp() {
        moduleOutput?.action(.onSignUp)
    }
    
    func fetchSignUpVisibilityState() {
        output.updateSignUpVisibility(value: dependencies.interactor.isSignUpAvailable())
    }
    
    func validate(_ field: FloatingTextField?) -> AuthInteractorError? {
        guard let field = field else { return .none }
        return dependencies.interactor.validate(text: field.value).error
    }
}
