import UIKit

class SplashConfigurator {

    class func configure(data: SplashViewModel.ModuleInput = SplashViewModel.ModuleInput(),
                         output: SplashViewModel.ModuleOutput? = nil) -> UIViewController {
        let viewController = SplashViewController()
        let viewModel = SplashViewModel(dependencies: createDependencies(), data: data)
            
        viewController.output = viewModel
        viewModel.output = viewController
        viewModel.moduleOutput = output
            
        return viewController
    }
    
    private class func createDependencies() -> SplashViewModel.Dependencies {
        return SplashViewModel.Dependencies(tokenStore: inject())
    }
}
