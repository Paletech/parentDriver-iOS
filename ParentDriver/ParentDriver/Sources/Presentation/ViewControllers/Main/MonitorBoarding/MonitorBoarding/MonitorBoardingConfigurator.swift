import UIKit

class MonitorBoardingConfigurator {

    class func configure(data: MonitorBoardingViewModel.ModuleInput = MonitorBoardingViewModel.ModuleInput(),
                         output: MonitorBoardingViewModel.ModuleOutput? = nil) -> UIViewController
    {
        let viewController = MonitorBoardingViewController()
        let viewModel = MonitorBoardingViewModel(dependencies: createDependencies(), data: data)
            
        viewController.output = viewModel
        viewModel.output = viewController
        viewModel.moduleOutput = output
            
        return viewController
    }
    
    private class func createDependencies() -> MonitorBoardingViewModel.Dependencies {
        return MonitorBoardingViewModel.Dependencies(interactor: inject())
    }
}
