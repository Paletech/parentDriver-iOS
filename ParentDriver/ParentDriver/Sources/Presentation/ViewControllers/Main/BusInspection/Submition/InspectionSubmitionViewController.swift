import UIKit

protocol InspectionSubmitionViewControllerOutput: ViewControllerOutput {

}

class InspectionSubmitionViewController: UIViewController {

    var output: InspectionSubmitionViewControllerOutput!
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.start()
        configureUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.updateData()
    }

    // MARK: - Private

    private func configureUI() {
    }
}

// MARK: - Private InspectionSubmitionViewModelOutput
extension InspectionSubmitionViewController: InspectionSubmitionViewModelOutput {

    func dataDidUpdate() {

    }
}
