import UIKit

class AppCoordinator: WindowCoordinator {
    
    override func start() {
        configure()
    }
    
    private func configure() {
        removeAllChilds()
        
        let splashVc = SplashConfigurator.configure(output: SplashViewModel.ModuleOutput(action: { [weak self] in
            switch $0 {
            case .authFlow:
                self?.showAuthFlow()
            case .mainFlow:
                self?.showMainFlow()
            }
        }))
        
        setRoot(viewControler: splashVc)
    }
    
    private func showAuthFlow() {
        removeAllChilds()
        let authCoordinator = AuthCoordinator(container: UINavigationController())
        authCoordinator.start()
        addChild(authCoordinator)
        setRoot(viewControler: authCoordinator.container)
    }
    
    private func showMainFlow() {
        
    }
}
