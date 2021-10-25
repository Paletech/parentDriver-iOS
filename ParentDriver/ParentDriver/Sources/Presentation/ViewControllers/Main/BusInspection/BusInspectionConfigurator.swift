import UIKit

class BusInspectionConfigurator {

    class func configure(data: BusInspectionViewModel.ModuleInput = BusInspectionViewModel.ModuleInput(),
                         output: BusInspectionViewModel.ModuleOutput? = nil) -> UIViewController
    {
        let viewController = BusInspectionViewController()
        let viewModel = BusInspectionViewModel(dependencies: createDependencies(), data: data)
            
        viewController.output = viewModel
        viewModel.output = viewController
        viewModel.moduleOutput = output
            
        return viewController
    }
    
    private class func createDependencies() -> BusInspectionViewModel.Dependencies {
        return BusInspectionViewModel.Dependencies()
    }
}
