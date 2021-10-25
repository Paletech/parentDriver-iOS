import UIKit

protocol DashboardViewControllerOutput: ViewControllerOutput,
                                        BusSelectionProvider,
                                        MenuHandler  {

}

class DashboardViewController: UIViewController, NavigationHolderController {
    
    var busSelectionProvider: BusSelectionProvider { output }
    var menuHandler: MenuHandler { output }
    
    var output: DashboardViewControllerOutput!
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.start()
        configureUI()
        
        view.backgroundColor = .white
        title = Localizable.title_dashboard()
        
        setupNavigation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.updateData()
    }

    // MARK: - Private

    private func configureUI() {
    }
}

// MARK: - Private DashboardViewModelOutput
extension DashboardViewController: DashboardViewModelOutput {

    func dataDidUpdate() {

    }
}
