import UIKit

class RidersheepChangesConfigurator {

    class func configure(data: RidersheepChangesViewModel.ModuleInput = RidersheepChangesViewModel.ModuleInput(),
                         output: RidersheepChangesViewModel.ModuleOutput? = nil) -> UIViewController
    {
        let viewController = RidersheepChangesViewController()
        let viewModel = RidersheepChangesViewModel(dependencies: createDependencies(), data: data)
            
        viewController.output = viewModel
        viewModel.output = viewController
        viewModel.moduleOutput = output
            
        return viewController
    }
    
    private class func createDependencies() -> RidersheepChangesViewModel.Dependencies {
        return RidersheepChangesViewModel.Dependencies(interactor: inject())
    }
}
