import UIKit

class AddStudentConfigurator {

    class func configure(data: AddStudentViewModel.ModuleInput = AddStudentViewModel.ModuleInput(),
                         output: AddStudentViewModel.ModuleOutput? = nil) -> UIViewController
    {
        let viewController = AddStudentViewController()
        let viewModel = AddStudentViewModel(dependencies: createDependencies(), data: data)
            
        viewController.output = viewModel
        viewModel.output = viewController
        viewModel.moduleOutput = output
            
        return viewController
    }
    
    private class func createDependencies() -> AddStudentViewModel.Dependencies {
        return AddStudentViewModel.Dependencies(interactor: inject())
    }
}
