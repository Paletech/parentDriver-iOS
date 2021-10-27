import UIKit

class SignUpConfigurator {
    
    class func configure(data: SignUpViewModel.ModuleInput = SignUpViewModel.ModuleInput(),
                         output: SignUpViewModel.ModuleOutput? = nil) -> UIViewController {
        let viewController = SignUpViewController()
        let viewModel = SignUpViewModel(dependencies: createDependencies(), data: data)
        
        viewController.output = viewModel
        viewModel.output = viewController
        viewModel.moduleOutput = output
        
        return viewController
    }
    
    private class func createDependencies() -> SignUpViewModel.Dependencies {
        return SignUpViewModel.Dependencies(interactor: inject())
    }
}
