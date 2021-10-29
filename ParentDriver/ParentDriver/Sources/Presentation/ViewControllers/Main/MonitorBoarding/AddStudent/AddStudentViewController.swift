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
extension AddStudentViewController: AddStudentViewModelOutput { }
