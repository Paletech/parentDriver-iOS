import UIKit

class SelectBusConfigurator {

    class func configure(data: SelectBusViewModel.ModuleInput = SelectBusViewModel.ModuleInput(),
                         output: SelectBusViewModel.ModuleOutput? = nil) -> UIViewController {
        let viewController = SelectBusViewController()
        let viewModel = SelectBusViewModel(dependencies: createDependencies(), data: data)
            
        viewController.output = viewModel
        viewModel.output = viewController
        viewModel.moduleOutput = output
            
        return viewController
    }
    
    private class func createDependencies() -> SelectBusViewModel.Dependencies {
        return SelectBusViewModel.Dependencies(interactor: inject())
    }
}
