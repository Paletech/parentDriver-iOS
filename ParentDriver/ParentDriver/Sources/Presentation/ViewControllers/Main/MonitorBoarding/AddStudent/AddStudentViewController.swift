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
    
    // MARK: - Private

    private func configureUI() {
        view.backgroundColor = .white
    }
}

// MARK: - Private AddStudentViewModelOutput
extension AddStudentViewController: AddStudentViewModelOutput {

    func dataDidUpdate() {

    }
}
