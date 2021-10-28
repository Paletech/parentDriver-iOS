import UIKit

class SignInConfigurator {

    class func configure(data: SignInViewModel.ModuleInput = SignInViewModel.ModuleInput(),
                         output: SignInViewModel.ModuleOutput? = nil) -> UIViewController
    {
        let viewModel = SignInViewModel(dependencies: createDependencies(), data: data)
        let viewController = SignInViewController(output: viewModel)

        viewModel.output = viewController
        viewModel.moduleOutput = output
            
        return viewController
    }
    
    private class func createDependencies() -> SignInViewModel.Dependencies {
        return SignInViewModel.Dependencies(interactor: inject())
    }
}
