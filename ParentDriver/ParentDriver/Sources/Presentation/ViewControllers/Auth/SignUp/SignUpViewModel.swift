import Foundation
import Combine

class SignUpViewModel {
    struct Dependencies {
        let interactor: AuthInteractor
    }

    let dependencies: Dependencies

    let moduleInput: ModuleInput
    var moduleOutput: ModuleOutput?

    weak var output: ViewModelOutput!

    private var cancellables = [AnyCancellable]()

    init(dependencies: Dependencies, data: ModuleInput) {
        self.dependencies = dependencies
        self.moduleInput = data
    }

    deinit {
        cancellables.forEach { $0.cancel() }
    }
}

extension SignUpViewModel: SignUpViewControllerOutput {
    
    func validate(_ field: FloatingTextField?) -> AuthInteractorError? {
        guard let field = field else { return .none }
        return dependencies.interactor.validate(text: field.value).error
    }
    
    func onSignUp() {
        moduleOutput?.action(.onSignedUp)
    }
}
