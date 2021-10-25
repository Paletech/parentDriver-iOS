import UIKit

protocol BusInspectionViewControllerOutput: ViewControllerOutput {

}

class BusInspectionViewController: UIViewController {

    var output: BusInspectionViewControllerOutput!
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.start()
        configureUI()
        
        title = Localizable.title_bus_inspection()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.updateData()
    }

    // MARK: - Private

    private func configureUI() {
    }
}

// MARK: - Private BusInspectionViewModelOutput
extension BusInspectionViewController: BusInspectionViewModelOutput {

    func dataDidUpdate() {

    }
}
