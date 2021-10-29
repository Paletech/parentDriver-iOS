import UIKit

protocol AddStudentViewControllerOutput: ViewControllerOutput {

}

class AddStudentViewController: UIViewController {

    var output: AddStudentViewControllerOutput!
    
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

// MARK: - Private AddStudentViewModelOutput
extension AddStudentViewController: AddStudentViewModelOutput {

    func dataDidUpdate() {

    }
}
