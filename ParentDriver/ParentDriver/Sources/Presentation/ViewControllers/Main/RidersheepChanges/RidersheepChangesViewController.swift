import UIKit

protocol RidersheepChangesViewControllerOutput: ViewControllerOutput {

}

class RidersheepChangesViewController: UIViewController {

    var output: RidersheepChangesViewControllerOutput!
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        output.start()
        configureUI()
        
        title = Localizable.title_ridersheep_changes()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output.updateData()
    }

    // MARK: - Private

    private func configureUI() {
    }
}

// MARK: - Private RidersheepChangesViewModelOutput
extension RidersheepChangesViewController: RidersheepChangesViewModelOutput {

    func dataDidUpdate() {

    }
}
