import UIKit

protocol AddStudentViewControllerOutput: SearchViewOutput {

}

class AddStudentViewController: BaseSearchViewController {

    var output: AddStudentViewControllerOutput!
    override var searchViewOutput: SearchViewOutput! { output }
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseSetup()
        setupTitles()
    }
    
    // MARK: - Localisation
    
    private func setupTitles() {
        title = Localizable.title_add_student()
        emptySearchLabel.text = Localizable.error_empty_search()
        navigationItem.searchController?.searchBar.placeholder = Localizable.placeholder_search_student()
    }
}

// MARK: - Private AddStudentViewModelOutput
extension AddStudentViewController: AddStudentViewModelOutput {

    func showSettingsAlert() {
        let alert = UIAlertController(title: Localizable.title_location_permission_is_mandatory(),
                                      message: Localizable.subtitle_location_permission_is_mandatory(), preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: Localizable.button_settings(), style: .default) { _ in
            URL(string: UIApplication.openSettingsURLString)
                .flatMap { UIApplication.shared.open($0) }
        }
        let cancelAction = UIAlertAction(title: Localizable.button_cancel(), style: .cancel, handler: nil)
        
        [settingsAction, cancelAction].forEach { alert.addAction($0) }
        
        present(alert, animated: true, completion: nil)
    }
}
