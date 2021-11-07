import UIKit

class BusInspectionTypeConfigurator {

    class func configure(data: BusInspectionTypeViewModel.ModuleInput = BusInspectionTypeViewModel.ModuleInput(),
                         output: BusInspectionTypeViewModel.ModuleOutput? = nil) -> UIViewController {
        let viewController = BusInspectionTypeViewController()
        let viewModel = BusInspectionTypeViewModel(dependencies: createDependencies(), data: data)
            
        viewController.output = viewModel
        viewModel.output = viewController
        viewModel.moduleOutput = output
            
        return viewController
    }
    
    private class func createDependencies() -> BusInspectionTypeViewModel.Dependencies {
        return BusInspectionTypeViewModel.Dependencies(inspectionInteractor: inject())
    }
}
