import UIKit

protocol MonitorBoardingViewControllerOutput: ViewControllerOutput {

}

class MonitorBoardingViewController: UIViewController {

    var output: MonitorBoardingViewControllerOutput!
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.start()
        configureUI()
        
        title = Localizable.title_monitor_boarding()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.updateData()
    }

    // MARK: - Private

    private func configureUI() {
    }
}

// MARK: - Private MonitorBoardingViewModelOutput
extension MonitorBoardingViewController: MonitorBoardingViewModelOutput {

    func dataDidUpdate() {

    }
}
