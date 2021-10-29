import UIKit

protocol SelectBusViewControllerOutput: SearchViewOutput { }

class SelectBusViewController: BaseSearchViewController {

    var output: SelectBusViewControllerOutput!
    override var searchViewOutput: SearchViewOutput! { output }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        baseSetup()
        setupTitles()
    }
    
    // MARK: - Localisation
    
    private func setupTitles() {
        title = Localizable.title_select_bus()
        emptySearchLabel.text = Localizable.error_empty_search()
    }
}

// MARK: - SelectBusViewModelOutput
extension SelectBusViewController: SelectBusViewModelOutput { }
