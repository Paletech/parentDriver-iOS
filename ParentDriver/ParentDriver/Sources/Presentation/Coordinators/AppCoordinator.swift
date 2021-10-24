import UIKit

class AppCoordinator: WindowCoordinator {
    
    override func start() {
        configure()
    }
    
    private func configure() {
        removeAllChilds()
        
        let splashVc = SplashConfigurator.configure(output: SplashViewModel.ModuleOutput(action: { [weak self] in
            switch $0 {
            case .showAuthFlow:
                self?.showAuthFlow()
            case .showSelectBusFlow:
                self?.showBusSelectionFlow()
            case .showMainFlow:
                self?.showMainFlow()
            }
        }))
        
        setRoot(viewControler: splashVc)
    }
    
    private func showAuthFlow() {
        removeAllChilds()
        
        let authCoordinator = AuthCoordinator(navigationController: UINavigationController(), output: AuthCoordinator.Output(authorized: { [weak self] in
            self?.showBusSelectionFlow()
        }))
        
        authCoordinator.start()
        addChild(authCoordinator)
        
        setRoot(viewControler: authCoordinator.container)
    }
    
    private func showBusSelectionFlow() {
        removeAllChilds()
        
        let busSelectionVc = SelectBusConfigurator.configure()
        let navigationVc = UINavigationController(rootViewController: busSelectionVc)
        
        setRoot(viewControler: navigationVc)
    }
    
    private func showMainFlow() {
        
    }
}
