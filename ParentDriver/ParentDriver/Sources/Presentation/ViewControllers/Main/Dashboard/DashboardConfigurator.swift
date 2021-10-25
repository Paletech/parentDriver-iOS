import UIKit

class DashboardConfigurator {

    class func configure(data: DashboardViewModel.ModuleInput = DashboardViewModel.ModuleInput(),
                         output: DashboardViewModel.ModuleOutput? = nil) -> UIViewController
    {
        let viewController = DashboardViewController()
        let viewModel = DashboardViewModel(dependencies: createDependencies(), data: data)
            
        viewController.output = viewModel
        viewModel.output = viewController
        viewModel.moduleOutput = output
            
        return viewController
    }
    
    private class func createDependencies() -> DashboardViewModel.Dependencies {
        return DashboardViewModel.Dependencies()
    }
}
