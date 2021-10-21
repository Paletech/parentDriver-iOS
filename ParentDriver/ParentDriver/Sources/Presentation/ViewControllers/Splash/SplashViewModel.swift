import Foundation

protocol SplashViewModelOutput: ViewModelOutput {

    func dataDidUpdate()
}

class SplashViewModel {

    struct Dependencies {
        let tokenStore: KeycheinStore<Token>
    }

    let dependencies: Dependencies
    
    let moduleInput: ModuleInput
    var moduleOutput: ModuleOutput?
    
    weak var output: SplashViewModelOutput!

    init(dependencies: Dependencies, data: ModuleInput) {
        self.dependencies = dependencies
        self.moduleInput = data
    }
}

// MARK: - SplashViewControllerOutput
extension SplashViewModel: SplashViewControllerOutput {

    func start() {
        if let _ = try? dependencies.tokenStore.get(from: KeychainKeys.token.rawValue) {
            moduleOutput?.action(.mainFlow)
        } else {
            moduleOutput?.action(.authFlow)
        }
    }
}
