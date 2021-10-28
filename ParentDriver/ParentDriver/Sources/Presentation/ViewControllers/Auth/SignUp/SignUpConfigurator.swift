import UIKit

class SignUpConfigurator {
    
    class func configure(data: SignUpViewModel.ModuleInput = SignUpViewModel.ModuleInput(),
                         output: SignUpViewModel.ModuleOutput? = nil) -> UIViewController {
        let viewModel = SignUpViewModel(dependencies: createDependencies(), data: data)
        let viewController = SignUpViewController(output: viewModel)

        viewModel.output = viewController
        viewModel.moduleOutput = output
        
        return viewController
    }
    
    private class func createDependencies() -> SignUpViewModel.Dependencies {
        return SignUpViewModel.Dependencies(interactor: inject())
    }
}
