import UIKit

class MenuConfigurator {

    class func configure(data: MenuViewModel.ModuleInput = MenuViewModel.ModuleInput(),
                         output: MenuViewModel.ModuleOutput? = nil) -> UIViewController
    {
        let viewController = MenuViewController()
        let viewModel = MenuViewModel(dependencies: createDependencies(), data: data)
            
        viewController.output = viewModel
        viewModel.output = viewController
        viewModel.moduleOutput = output
            
        return viewController
    }
    
    private class func createDependencies() -> MenuViewModel.Dependencies {
        return MenuViewModel.Dependencies()
    }
}
