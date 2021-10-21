import UIKit

class SignInConfigurator {

    class func configure(data: SignInViewModel.ModuleInput = SignInViewModel.ModuleInput(),
                         output: SignInViewModel.ModuleOutput? = nil) -> UIViewController
    {
        let viewController = SignInViewController()
        let viewModel = SignInViewModel(dependencies: createDependencies(), data: data)
            
        viewController.output = viewModel
        viewModel.output = viewController
        viewModel.moduleOutput = output
            
        return viewController
    }
    
    private class func createDependencies() -> SignInViewModel.Dependencies {
        return SignInViewModel.Dependencies()
    }
}
