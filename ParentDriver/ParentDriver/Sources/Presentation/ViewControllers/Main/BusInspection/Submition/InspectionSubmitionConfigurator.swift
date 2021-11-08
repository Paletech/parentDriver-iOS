import UIKit

class InspectionSubmitionConfigurator {

    class func configure(data: InspectionSubmitionViewModel.ModuleInput,
                         output: InspectionSubmitionViewModel.ModuleOutput? = nil) -> UIViewController
    {
        let viewController = InspectionSubmitionViewController()
        let viewModel = InspectionSubmitionViewModel(dependencies: createDependencies(), data: data)
            
        viewController.output = viewModel
        viewModel.output = viewController
        viewModel.moduleOutput = output
            
        return viewController
    }
    
    private class func createDependencies() -> InspectionSubmitionViewModel.Dependencies {
        return InspectionSubmitionViewModel.Dependencies(interactor: inject())
    }
}
