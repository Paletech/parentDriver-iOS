import Foundation

protocol SplashViewModelOutput: ViewModelOutput {

    func dataDidUpdate()
}

class SplashViewModel {

    struct Dependencies {
        let tokenStore: KeycheinStore<Token>
        let authInteractor: AuthInteractor
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
        dependencies.authInteractor.fetchAnActivateConfig { [weak self] _ in
            self?.resolveAppState()
        }
    }
    
    private func resolveAppState() {
        switch dependencies.authInteractor.provideAppState() {
        case .unauthorized:
            moduleOutput?.action(.showAuthFlow)
        case .selectBus:
            moduleOutput?.action(.showSelectBusFlow)
        case .mainFlow:
            moduleOutput?.action(.showMainFlow)
        }
    }
}
