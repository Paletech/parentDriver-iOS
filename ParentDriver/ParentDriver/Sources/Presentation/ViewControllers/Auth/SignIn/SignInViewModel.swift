import Foundation

protocol SignInViewModelOutput: ViewModelOutput {

    func dataDidUpdate()
}

class SignInViewModel {

    struct Dependencies { }

    let dependencies: Dependencies
    
    let moduleInput: ModuleInput
    var moduleOutput: ModuleOutput?
    
    weak var output: SignInViewModelOutput!

    init(dependencies: Dependencies, data: ModuleInput) {
        self.dependencies = dependencies
        self.moduleInput = data
    }
}

// MARK: - SignInViewControllerOutput
extension SignInViewModel: SignInViewControllerOutput {

    func signIn() {
        
    }
}
